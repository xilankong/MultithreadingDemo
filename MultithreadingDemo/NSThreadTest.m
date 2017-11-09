//
//  NSThreadTest.m
//  MultithreadingDemo
//
//  Created by yanghuang on 2017/11/9.
//  Copyright © 2017年 com.yang. All rights reserved.
//

#import "NSThreadTest.h"



@implementation NSThreadTest {
    NSLock *lock;
}

- (void)start {
    //1 创建nsthread 并启动
    lock = [NSLock new];
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
    
    [thread start];
    
    //2 创建并自启动
    __weak typeof(self) weakself = self;
    [NSThread detachNewThreadWithBlock:^{
        [weakself run];
    }];
    //3 创建并自启动
    [self performSelectorInBackground:@selector(run) withObject:nil];
}

    //共同执行的方法\两种锁
- (void)run {
//    [lock lock];
//    NSLog(@"111111");
//    NSLog(@"3---%@",NSThread.currentThread);
//    [lock unlock];
    
    @synchronized (self) {
        NSLog(@"111111%@",NSThread.currentThread);
        NSLog(@"---%@",NSThread.currentThread);
    }

}

@end
