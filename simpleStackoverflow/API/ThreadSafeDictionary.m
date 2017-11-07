//
//  ThreadSafeDictionary.m
//  simpleTest
//
//  Created by Aleksey Anisimov on 11.04.15.
//  Copyright (c) 2015 Alexey. All rights reserved.
//

#import "ThreadSafeDictionary.h"

@interface ThreadSafeDictionary(){
    dispatch_queue_t _safeQueue;
    NSMutableDictionary *_safeDictionary;
}

@end

@implementation ThreadSafeDictionary



- (instancetype)init {

    self = [super init];
    if (self) {
        _safeQueue = dispatch_queue_create([@"thread_safe_queue" UTF8String], DISPATCH_QUEUE_CONCURRENT);
        _safeDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSEnumerator *)keyEnumerator
{
    __block NSEnumerator *enumerator;
    dispatch_sync(_safeQueue, ^{
        enumerator = [_safeDictionary.allKeys objectEnumerator];
    });

    return enumerator;
}


- (NSUInteger)count{

    __block NSUInteger count;
    dispatch_sync(_safeQueue, ^{
        count = _safeDictionary.count;
    });
    return count;
}

- (id)objectForKey:(id)aKey{
    __block id obj;
    dispatch_sync(_safeQueue, ^{
        obj = _safeDictionary[aKey];
    });
    return obj;
}

- (void)removeAllObjects{

    dispatch_barrier_async(_safeQueue, ^{
        [_safeDictionary removeAllObjects];
    });

}

- (void)setObject:(id)object forKey:(id)aKey{

    aKey = [aKey copy];
    dispatch_barrier_async(_safeQueue, ^{
        _safeDictionary[aKey] = object;
    });
}


@end
