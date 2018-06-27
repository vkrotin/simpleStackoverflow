 //
//  ItemModel.m
//  simpleStackoverflow
//
//  Created by Aleksey Anisimov on 01.11.17.
//  Copyright © 2017 Aleksey Anisimov. All rights reserved.
//

#import "ItemModel.h"
#import "NSDate+Converter.h"

@implementation ItemModel

-(instancetype) initWithJsonDict:(NSDictionary *) jsonDict{
    self = [super init];
    if (self){
        self.tags = jsonDict[@"tags"];
        self.owner = [[OwnerModel alloc] initWithJsonDict:jsonDict[@"owner"]];
        self.isAnswered = [jsonDict[@"is_answered"] boolValue];
        self.viewCount = [jsonDict[@"view_count"] integerValue];
        self.answerCount = [jsonDict[@"answer_count"] integerValue];
        self.score = [jsonDict[@"score"] integerValue];
        self.lastActivityDate = [NSDate dateFromInterval:jsonDict[@"last_activity_date"]];
        self.creationDate = [NSDate dateFromInterval:jsonDict[@"creation_date"]];
        self.lastEditDate = [NSDate dateFromInterval:jsonDict[@"last_edit_date"]];
        self.questionId = [jsonDict[@"question_id"] integerValue];
        self.link = jsonDict[@"link"];
        self.titleItem = jsonDict[@"title"];
    }
    return self;
}



@end
