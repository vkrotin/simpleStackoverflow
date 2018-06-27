//
//  StackoverTableViewCell.h
//  simpleStackoverflow
//
//  Created by Aleksey Anisimov on 02.11.17.
//  Copyright © 2017 Aleksey Anisimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemModel.h"

@protocol TableViewCellDelegate<NSObject>
@optional
-(void) openOwnerUrl:(NSURL *) ownerUrl;

@end

@interface StackoverTableViewCell : UITableViewCell

@property (weak, nonatomic) id <TableViewCellDelegate> cellDelegate;
@property (weak, nonatomic) IBOutlet UIButton *userAvatar;
@property(nonatomic, strong) ItemModel *itemModel;

@end
