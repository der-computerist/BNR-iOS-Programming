//
//  BNRAppliance.m
//  Objective-C-Playground
//
//  Created by Enrique Aliaga on 12/21/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRAppliance.h"

@interface BNRAppliance ()

@property (strong, nonatomic) NSString *circlecolor;

@end

@implementation BNRAppliance

- (instancetype)init
{
    return [self initWithProductName:@"Unkown"];
}

- (instancetype)initWithProductName:(NSString *)pn
{
    if (self = [super init]) {
        _productName = [pn copy];
        _voltage = 120;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %d volts>", self.productName, self.voltage];
}

@end
