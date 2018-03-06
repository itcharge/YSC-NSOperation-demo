//
//  YSCOperation.m
//  YSC-NSOperation-demo
//
//  Created by WalkingBoy on 2018/3/2.
//  Copyright © 2018年 Walking Boy. All rights reserved.
//

#import "YSCOperation.h"

@implementation YSCOperation

- (void)main {
    if (!self.isCancelled) {
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@", [NSThread currentThread]);
        }
    }
}

@end
