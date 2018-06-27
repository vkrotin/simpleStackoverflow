//
//  OwnerModel.m
//  simpleStackoverflow
//
//  Created by Aleksey Anisimov on 02.11.17.
//  Copyright © 2017 Aleksey Anisimov. All rights reserved.
//

#import "OwnerModel.h"

@implementation OwnerModel


-(instancetype) initWithJsonDict:(NSDictionary *) jsonDict{
    self = [super init];
    if (self){
        self.reputation = [jsonDict[@"reputation"] integerValue];
        self.userId = [jsonDict[@"user_id"] integerValue];
        self.userType = jsonDict[@"user_type"];
        self.profileImage = jsonDict[@"profile_image"];
        self.displayName = jsonDict[@"display_name"];
        self.link = jsonDict[@"link"];
    }
    return self;
}

@end
