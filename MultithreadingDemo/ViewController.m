//
//  ViewController.m
//  MultithreadingDemo
//
//  Created by yanghuang on 2017/11/9.
//  Copyright © 2017年 com.yang. All rights reserved.
//

#import "ViewController.h"
#import "NSThreadTest.h"
#import "GCDTest.h"
#import "NSOperationTest.h"

@interface ViewController ()

@property (nonatomic, strong) GCDTest *gcd;
@property (nonatomic, strong) NSThreadTest *thread;
@property (nonatomic, strong) NSOperationTest *operation;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.thread = [[NSThreadTest alloc]init];
    self.gcd = [[GCDTest alloc]init];
    self.operation = [[NSOperationTest alloc]init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)gcdAction:(id)sender {
    [self.gcd start];
}

- (IBAction)nsthread:(id)sender {
    [self.thread start];
}

- (IBAction)nsoperation:(id)sender {
    [self.operation start];
}

@end
