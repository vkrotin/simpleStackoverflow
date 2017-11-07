//
//  ThreadSafeDictionary.h
//  simpleTest
//
//  Created by Aleksey Anisimov on 11.04.15.
//  Copyright (c) 2015 Alexey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThreadSafeDictionary : NSDictionary

- (NSUInteger)count;
- (id)objectForKey:(id)aKey;
- (void)removeAllObjects;
- (void)setObject:(id)object forKey:(id)aKey;

@end
