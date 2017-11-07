//
//  NSError+Powered.m
//  simpleStackoverflow
//
//  Created by Aleksey Anisimov on 01.11.17.
//  Copyright © 2017 Aleksey Anisimov. All rights reserved.
//

#import "NSError+Powered.h"

@implementation NSError (Powered)

+(NSError *) noInternet{
    return  [NSError errorWithDomain:@"local.domain" code:404 userInfo:@{NSLocalizedDescriptionKey : @"No internet connection"}];
}

+(NSError *) errorWithMessage:(NSString *) message{
    return  [NSError errorWithDomain:@"local.domain" code:205 userInfo:@{NSLocalizedDescriptionKey : message}];
}

@end
