//
//  BNRAsset.m
//  Objective-C-Playground
//
//  Created by Enrique Aliaga on 12/7/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRAsset.h"

@implementation BNRAsset

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: $%u>", self.label, self.resaleValue];
}

- (void)dealloc
{
    NSLog(@"deallocating %@", self);
}

@end
