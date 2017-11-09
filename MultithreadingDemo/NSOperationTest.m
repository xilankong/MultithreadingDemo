//
//  NSOperationTest.m
//  MultithreadingDemo
//
//  Created by yanghuang on 2017/11/9.
//  Copyright © 2017年 com.yang. All rights reserved.
//

#import "NSOperationTest.h"

@implementation NSOperationTest

- (void)start {
//    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
//    __weak typeof(self) weakself = self;
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        [weakself run];
//    }];
//    [operation addExecutionBlock:^{
//        sleep(1);
//        [weakself run];
//    }];
//    queue.maxConcurrentOperationCount = 1;
//    [queue addOperation:operation];
//    [queue addOperationWithBlock:^{
//        [weakself run];
//    }];
    
    NSBlockOperation *operationA = [NSBlockOperation blockOperationWithBlock:^{
        sleep(1);
        NSLog(@"拉取A接口--%@",NSThread.currentThread);
    }];
    
    NSBlockOperation *operationB = [NSBlockOperation blockOperationWithBlock:^{
        sleep(1);
        NSLog(@"通过A接口参数拉取B接口--%@",NSThread.currentThread);
    }];
    
    NSBlockOperation *operationC = [NSBlockOperation blockOperationWithBlock:^{
        sleep(1);
        NSLog(@"通过B接口参数拉取C接口--%@",NSThread.currentThread);
    }];
    [operationB addDependency:operationA];
    [operationC addDependency:operationB];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperations:@[operationA, operationB] waitUntilFinished:NO];
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    [queue2 addOperations:@[operationC] waitUntilFinished:NO];
}

- (void)run {
    NSLog(@"---%@",NSThread.currentThread);
}
@end
