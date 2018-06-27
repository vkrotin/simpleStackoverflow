//
//  NSURLSessionManager.m
//  simpleStackoverflow
//
//  Created by Aleksey Anisimov on 01.11.17.
//  Copyright © 2017 Aleksey Anisimov. All rights reserved.
//

#import "NSURLSessionManager.h"
#import "NSError+Powered.h"
#import "ItemModel.h"

static NSString *requestString = @"http://api.stackexchange.com/2.2/search?order=desc&sort=activity&site=stackoverflow&intitle=%@";
static NSString *items = @"items";
static NSString *error_message = @"Result is not Array object";
static NSString *error_message_nil = @"Result count 0";


NS_INLINE NSString *urlSearchText(NSString * text){
    NSString *searchText =[NSString stringWithFormat:requestString, text];
    return [searchText stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

@implementation NSURLSessionManager

+ (void)sendRequestWithText:(NSString *) searchText completion:(ApiRequestResult) successBlock {
    NSURL *url = [NSURL URLWithString:urlSearchText(searchText)];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *_data, NSURLResponse * _response, NSError * error) {
        if (error) {
            successBlock([NSArray new], error);
            return;
        }
        NSError *dictError;
        NSDictionary *answer = [NSJSONSerialization JSONObjectWithData:_data options:kNilOptions error:&dictError];
        
        if ([answer[items] isKindOfClass:[NSArray class]] || [answer[items] isKindOfClass:[NSDictionary class]]){
            if (((NSArray *)answer[items]).count == 0){
                successBlock([NSArray new], [NSError errorWithMessage:error_message_nil]);
            } else{
                NSArray *parse = [self parseJsonArray:answer[items]];
                successBlock(parse, dictError);
            }
        } else{
            successBlock([NSArray new], [NSError errorWithMessage:error_message]);
        }
    }] resume];
}

+(NSArray*) parseJsonArray:(NSArray *) jsonArray{
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    for (NSDictionary *object in jsonArray){
        [itemArray addObject:[[ItemModel alloc] initWithJsonDict:object]];
    }
    return itemArray;
}

@end
