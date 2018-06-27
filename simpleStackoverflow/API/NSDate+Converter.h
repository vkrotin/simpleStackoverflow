//
//  NSDate+Converter.h
//  simpleStackoverflow
//
//  Created by Aleksey Anisimov on 02.11.17.
//  Copyright © 2017 Aleksey Anisimov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Converter)

+(NSDate *) dateFromInterval:(id) interval;

-(NSString *) stringDateWithTime;

@end
