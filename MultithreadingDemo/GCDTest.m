//
//  GCDTest.m
//  MultithreadingDemo
//
//  Created by yanghuang on 2017/11/9.
//  Copyright © 2017年 com.yang. All rights reserved.
//

#import "GCDTest.h"

@implementation GCDTest


-(void)start {
//    [self serialThread];
//    [self concurrentThread];
    [self otherThreadMethod];
}

- (void)serialThread {
    [self run];
    __weak typeof(self) weakself = self;
    dispatch_queue_t queue = dispatch_queue_create("串行队列", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        [weakself run];
    });
    dispatch_async(queue, ^{
        [weakself run];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [weakself run];
        });
    });
}

- (void)concurrentThread {
    [self run];
    __weak typeof(self) weakself = self;
    dispatch_queue_t queue = dispatch_queue_create("并行队列", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [weakself run];
    });
    dispatch_async(queue, ^{
        [weakself run];
        dispatch_sync(queue, ^{
            [weakself run];
        });
    });
}

- (void)otherThreadMethod {
    __weak typeof(self) weakself = self;
    dispatch_queue_t queue = dispatch_queue_create("并行队列", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [weakself run];
    });
    dispatch_async(queue, ^{
        [weakself run];
    });
    
    //加入
    dispatch_barrier_async(queue, ^{
        sleep(1);
        [weakself run2];
        sleep(1);
    });
    dispatch_barrier_async(queue, ^{
        [weakself run2];
        sleep(1);
    });
    
    dispatch_async(queue, ^{
        [weakself run];
    });
    dispatch_async(queue, ^{
        [weakself run];
    });
    
//    __weak typeof(self) weakself = self;
//    dispatch_queue_t queue = dispatch_queue_create("并行队列", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, ^{
//        [weakself run];
//    });
//    dispatch_async(queue, ^{
//        dispatch_suspend(queue);
//        [weakself run];
//        dispatch_sync(queue, ^{
//            [weakself run];
//        });
//    });
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//
//    });
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_group_t group = dispatch_group_create();
//
//    // 添加队列到组中
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"one---%@",NSThread.currentThread);
//    });
//    dispatch_group_async(group, queue, ^{
//        // 一些延时操作
//        sleep(2);
//        NSLog(@"two---%@",NSThread.currentThread);
//    });
//    dispatch_group_async(group, queue, ^{
//        // 一些延时操作
//        sleep(3);
//        NSLog(@"three---%@",NSThread.currentThread);
//    });
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"four---%@",NSThread.currentThread);
//    });
//
//    dispatch_group_notify(group, queue, ^{
//        NSLog(@"我会一直等到现在");
//    });
//    NSLog(@"123");
}

- (void)run {
    NSLog(@"---%@",NSThread.currentThread);
}
- (void)run2 {
    NSLog(@"++++%@",NSThread.currentThread);
}
@end
