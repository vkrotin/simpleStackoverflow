//
//  OwnerModel.h
//  simpleStackoverflow
//
//  Created by Aleksey Anisimov on 02.11.17.
//  Copyright © 2017 Aleksey Anisimov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OwnerModel : NSObject
@property(assign, nonatomic) NSInteger reputation;
@property(assign, nonatomic) NSUInteger userId;
@property(strong, nonatomic) NSString *userType;
@property(strong, nonatomic) NSString *profileImage;
@property(strong, nonatomic) NSString *displayName;
@property(strong, nonatomic) NSString *link;

-(instancetype) initWithJsonDict:(NSDictionary *) jsonDict;

@end
