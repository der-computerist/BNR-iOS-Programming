//
//  BNREmployee.h
//  Objective-C-Playground
//
//  Created by Enrique Aliaga on 12/7/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRPerson.h"
@class BNRAsset;

@interface BNREmployee : BNRPerson

@property (nonatomic) unsigned int employeeID;
@property (nonatomic) NSDate *hireDate;
@property (nonatomic, copy) NSArray *assets;

- (double)yearsOfEmployment;
- (void)addAsset:(BNRAsset *)a;
- (unsigned int)valueOfAssets;

@end
