//
//  TableViewController.m
//  simpleStackoverflow
//
//  Created by Aleksey Anisimov on 01.11.17.
//  Copyright © 2017 Aleksey Anisimov. All rights reserved.
//

#import "TableViewController.h"
#import "NSURLSessionManager.h"
#import "ItemModel.h"
#import "BungViewForTable.h"
#import "StackoverTableViewCell.h"
#import "ThreadSafeDictionary.h"


@interface TableViewController () <UISearchBarDelegate, TableViewCellDelegate>{
    BungViewForTable *_bungView;
}
@property (nonatomic, strong) NSArray<ItemModel*>*questionArray;
@property (nonatomic, strong) ThreadSafeDictionary *imageCache;



@end

@implementation TableViewController

static NSString *reuseIdentifier = @"stackoverflowCell";

#pragma mark - Initialize

-(void) awakeFromNib{
    [super awakeFromNib];
    _bungView = [[BungViewForTable alloc] initWithFrame:self.tableView.frame];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 130;
    self.tableView.tableFooterView = [UIView new];
    self.questionArray = [NSArray new];
    self.imageCache = [[ThreadSafeDictionary alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) prefersStatusBarHidden{
    return [self.navigationController isNavigationBarHidden] == true;
}

-(UIStatusBarAnimation) preferredStatusBarUpdateAnimation{
    return UIStatusBarAnimationSlide;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_questionArray.count > 0) {
        tableView.backgroundView = [UIView new];
        return _questionArray.count;
    }else{
        tableView.backgroundView = _bungView;
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StackoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.cellDelegate = self;
    cell.itemModel = _questionArray[indexPath.row];
    
    NSString *imagePath = _questionArray[indexPath.row].owner.profileImage;
    [cell.userAvatar setImage:[UIImage imageNamed:@"userAvatarImage"] forState:UIControlStateNormal];
    UIImage *cacheImage = [self.imageCache objectForKey:imagePath]; //self.imageCache[imagePath];
    if (cacheImage){
        [cell.userAvatar setImage:cacheImage forState:UIControlStateNormal];
    }else{
         __weak __typeof(self)wself = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            __strong __typeof (wself) sself = wself;
            
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:imagePath]];
            UIImage * img = [UIImage imageWithData:imageData];
            [sself.imageCache setObject:img forKey:imagePath];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!sself) {
                    return;
                }
                StackoverTableViewCell * cell = (StackoverTableViewCell *)[sself.tableView cellForRowAtIndexPath:indexPath];
                 [cell.userAvatar setImage:img forState:UIControlStateNormal];
            });
        });
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [self presentAlertForUser:[NSURL URLWithString:_questionArray[indexPath.row].link]];
}


#pragma mark - TableViewCellDelegate

-(void) openOwnerUrl:(NSURL *) ownerUrl{
    [self presentAlertForUser:ownerUrl];
}

#pragma mark - Alert Method

-(void) presentAlertForUser:(NSURL *)url{
    UIAlertController *messageAlert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                          message:@"Open in Safari browser"
                                                                   preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"Open" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL complite){
                [messageAlert dismissViewControllerAnimated:true completion:nil];
            }];
        }else{
           [[UIApplication sharedApplication] openURL:url];
        }
    }];
    
    [messageAlert addAction:defaultAction];
    [messageAlert addAction:settingsAction];
    [self presentViewController:messageAlert animated:YES completion:nil];
}


#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"search presed");
     [searchBar resignFirstResponder];
    __weak __typeof(self)wself = self;
    [NSURLSessionManager sendRequestWithText:searchBar.text  completion:^(NSArray *result, NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"count %li", result.count);
            [wself.imageCache removeAllObjects];
            wself.questionArray = result;
            [wself.tableView reloadData];
            if (result.count == 0)
                return;
            
            [wself.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [wself.tableView setContentOffset:CGPointZero animated:YES];
            });
        });
    }];
}

@end
