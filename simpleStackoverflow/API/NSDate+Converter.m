//
//  NSDate+Converter.m
//  simpleStackoverflow
//
//  Created by Aleksey Anisimov on 02.11.17.
//  Copyright © 2017 Aleksey Anisimov. All rights reserved.
//

#import "NSDate+Converter.h"

@implementation NSDate (Converter)

+(NSDate *) dateFromInterval:(id) interval{
    if (interval == nil)
        return nil;
    return [NSDate dateWithTimeIntervalSince1970:[interval doubleValue]];
}

-(NSString *) stringDateWithTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:self];
}

@end
