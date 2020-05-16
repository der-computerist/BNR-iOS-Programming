//
//  BNREmployee.m
//  Objective-C-Playground
//
//  Created by Enrique Aliaga on 12/7/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNREmployee.h"
#import "BNRAsset.h"

typedef void(^MyCompletionBlock)(void);

@interface BNREmployee ()
{
    NSMutableArray *_assets;
}

@property (nonatomic) unsigned int officeAlarmCode;
@property (nonatomic) MyCompletionBlock completionHandler;

@end

@implementation BNREmployee

- (void)setAssets:(NSArray *)assets
{
    _assets = [assets mutableCopy];
}

- (NSArray *)assets
{
    return [_assets copy];
}

- (float)bodyMassIndex
{
    float normalBMI = [super bodyMassIndex];
    return normalBMI * 0.9;
}

- (double)yearsOfEmployment
{
    if (self.hireDate) {
        NSDate *now = [NSDate date];
        NSTimeInterval secs = [now timeIntervalSinceDate:self.hireDate];
        return secs / 31557600.0;
    } else {
        return 0;
    }
}

- (void)addAsset:(BNRAsset *)a
{
    if (!_assets) {
        _assets = [[NSMutableArray alloc] init];
    }
    [_assets addObject:a];
}

- (unsigned int)valueOfAssets
{
    __weak BNREmployee *weakSelf = self;  // a weak reference
    self.completionHandler = ^{
        BNREmployee *innerSelf = weakSelf;  // a block-local strong reference
        NSLog(@"%@", innerSelf);
    };
    
    unsigned int sum = 0;
    for (BNRAsset *a in _assets) {
        sum += a.resaleValue;
    }
    return sum;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<Employee %u: $%u in assets>", self.employeeID,
        self.valueOfAssets];
}

- (void)dealloc
{
    NSLog(@"deallocating %@", self);
}

@end
