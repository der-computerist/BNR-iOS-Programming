//
//  BNRColorDescription.m
//  Colorboard
//
//  Created by Enrique Aliaga on 4/4/20.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

#import "BNRColorDescription.h"

@implementation BNRColorDescription

- (instancetype)init
{
    if (self = [super init]) {
        _color = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
        _name = @"Blue";
    }
    return self;
}

@end
