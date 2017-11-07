//
//  StackoverTableViewCell.m
//  simpleStackoverflow
//
//  Created by Aleksey Anisimov on 02.11.17.
//  Copyright © 2017 Aleksey Anisimov. All rights reserved.
//

#import "StackoverTableViewCell.h"
#import "NSDate+Converter.h"

@interface StackoverTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *stackTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNickLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateCreationLabel;
@property (weak, nonatomic) IBOutlet UILabel *anwerCountLabel;

@end


@implementation StackoverTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) setItemModel:(ItemModel *)itemModel{
    _itemModel = itemModel;
    self.stackTitleLabel.text = _itemModel.titleItem;
    self.userNickLabel.text = _itemModel.owner.displayName;
    self.dateCreationLabel.text = [_itemModel.creationDate stringDateWithTime];
    self.anwerCountLabel.text = [NSString stringWithFormat:@"%i Answer", (int)_itemModel.answerCount];
}

- (IBAction)userAvatar_touch:(id)sender {
    if (self.cellDelegate && [self.cellDelegate respondsToSelector:@selector(openOwnerUrl:)]){
        [self.cellDelegate openOwnerUrl:[NSURL URLWithString:_itemModel.owner.link]];
    }
}

@end
