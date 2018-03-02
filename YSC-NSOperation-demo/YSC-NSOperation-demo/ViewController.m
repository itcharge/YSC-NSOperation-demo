//
//  ViewController.m
//  YSC-NSOperation-demo
//
//  Created by WalkingBoy on 2018/3/2.
//  Copyright © 2018年 Walking Boy. All rights reserved.
//

#import "ViewController.h"
#import "YSCOperation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    在当前线程使用子类 NSInvocationOperation
//    [self useInvocationOperation];
    
//    在其他线程使用子类 NSInvocationOperation
//    [NSThread detachNewThreadSelector:@selector(useInvocationOperation) toTarget:self withObject:nil];

//    在当前线程使用 NSBlockOperation
//    [self useBlockOperation];
    
//    使用 NSBlockOperation 的 AddExecutionBlock: 方法
//    [self useBlockOperationAddExecutionBlock];
//    使用自定义继承自 NSOperation 的子类
//    [self useCustomOperation];
    
//    [self addOperationToQueue];
    
//    [self addOperationWithBlockToQueue];
    
    [self setMaxConcurrentOperationCount];
}

/**
 * 使用子类 NSInvocationOperation
 */
- (void)useInvocationOperation {
    
    // 1.创建 NSInvocationOperation 对象
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    
    // 2.调用 start 方法开始执行操作
    [operation start];
}

/**
 * 使用子类 NSBlockOperation
 */
- (void)useBlockOperation {
    
    // 1.创建 NSBlockOperation 对象
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@", [NSThread currentThread]);
        }
    }];
    
    // 2.调用 start 方法开始执行操作
    [op start];
}

/**
 * 使用子类 NSBlockOperation
 * 方法 AddExecutionBlock:
 */
- (void)useBlockOperationAddExecutionBlock {
    
    // 1.创建 NSBlockOperation 对象
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@", [NSThread currentThread]);
        }
    }];
    
    // 2. 添加额外的任务
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@", [NSThread currentThread]);
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3---%@", [NSThread currentThread]);
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"4---%@", [NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"5---%@", [NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"6---%@", [NSThread currentThread]);
        }
    }];

    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"7---%@", [NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"8---%@", [NSThread currentThread]);
        }
    }];
    
    [op start];
}

/**
 * 使用自定义继承自 NSOperation 的子类
 */
- (void)useCustomOperation {
    YSCOperation *operation = [[YSCOperation alloc] init];
    [operation start];
}

/**
 * 使用 addOperation: 将操作加入到操作队列中
 */
- (void)addOperationToQueue {
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2. 创建操作
    // 创建 NSInvocationOperation
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run2) object:nil];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3---%@", [NSThread currentThread]);
        }
    }];
    
    [op3 addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"4---%@", [NSThread currentThread]);
        }
    }];
    
    
    // 3. 添加操作到队列中：addOperation:
    [queue addOperation:op1]; // [op1 start]
    [queue addOperation:op2]; // [op2 start]
    [queue addOperation:op3]; // [op3 start]
}

/**
 * 使用 addOperationWithBlock: 将操作加入到操作队列中
 */
- (void)addOperationWithBlockToQueue {
    // 1. 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2. 添加操作到队列中：addOperationWithBlock:
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@", [NSThread currentThread]);
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@", [NSThread currentThread]);
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3---%@", [NSThread currentThread]);
        }
    }];
}

- (void)setMaxConcurrentOperationCount {
    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 设置最大并发操作数
//    queue.maxConcurrentOperationCount = 2;
//    queue.maxConcurrentOperationCount = 1; // 就变成了串行队列
    
    // 添加操作
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@", [NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@", [NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3---%@", [NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"4---%@", [NSThread currentThread]);
        }
    }];
}

- (void)run
{
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1---%@", [NSThread currentThread]);
    }
    
}

- (void)run2
{
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2---%@", [NSThread currentThread]);
    }
    
}

@end
