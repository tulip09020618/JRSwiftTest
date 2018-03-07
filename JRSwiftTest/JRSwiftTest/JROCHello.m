//
//  JROCHello.m
//  JRSwiftTest
//
//  Created by hqtech on 2018/3/7.
//  Copyright © 2018年 tulip. All rights reserved.
//

#import "JROCHello.h"
#import "JRSwiftTest-Swift.h"

@implementation JROCHello

- (void)test {
    NSLog(@"hello Objective-C!");
    
    NSLog(@"===========OC调用Swift===========");
    JRSwiftHello *swift = [[JRSwiftHello alloc] init];
    [swift printHello]; // 调用Swift中方法报错
}

@end
