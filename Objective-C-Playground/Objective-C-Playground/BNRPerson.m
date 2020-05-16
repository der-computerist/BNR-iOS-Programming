//
//  BNRPerson.m
//  Objective-C-Playground
//
//  Created by Enrique Aliaga on 11/29/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRPerson.h"

@implementation BNRPerson

- (float)bodyMassIndex
{
    return self.weightInKilos / (self.heightInMeters * self.heightInMeters);
}

@end
