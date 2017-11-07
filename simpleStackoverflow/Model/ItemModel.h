//
//  ItemModel.h
//  simpleStackoverflow
//
//  Created by Aleksey Anisimov on 01.11.17.
//  Copyright © 2017 Aleksey Anisimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OwnerModel.h"

@interface ItemModel : NSObject

@property(strong, nonatomic) NSArray *tags;
@property(strong, nonatomic) OwnerModel *owner;
@property(assign, nonatomic) BOOL isAnswered;
@property(assign, nonatomic) NSInteger viewCount;
@property(assign, nonatomic) NSInteger answerCount;
@property(assign, nonatomic) NSInteger score;
@property(strong, nonatomic) NSDate *lastActivityDate;
@property(strong, nonatomic) NSDate *creationDate;
@property(strong, nonatomic) NSDate *lastEditDate;
@property(assign, nonatomic) NSInteger questionId;
@property(strong, nonatomic) NSString *link;
@property(strong, nonatomic) NSString *titleItem;

-(instancetype) initWithJsonDict:(NSDictionary *) jsonDict;

@end
