//
//  NSError+Powered.h
//  simpleStackoverflow
//
//  Created by Aleksey Anisimov on 01.11.17.
//  Copyright © 2017 Aleksey Anisimov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Powered)

+(NSError *) noInternet;
+(NSError *) errorWithMessage:(NSString *) message;

@end
