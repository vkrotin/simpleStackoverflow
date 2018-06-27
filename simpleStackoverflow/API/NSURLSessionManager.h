//
//  NSURLSessionManager.h
//  simpleStackoverflow
//
//  Created by Aleksey Anisimov on 01.11.17.
//  Copyright © 2017 Aleksey Anisimov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ApiRequestResult)(NSArray *result, NSError *error);

@interface NSURLSessionManager : NSObject

+ (void)sendRequestWithText:(NSString *) searchText completion:(ApiRequestResult) successBlock;

@end
