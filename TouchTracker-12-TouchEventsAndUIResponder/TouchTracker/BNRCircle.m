//
//  BNRCircle.m
//  TouchTracker
//
//  Created by Enrique Aliaga Chavez on 4/3/19.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

#import "BNRCircle.h"

@implementation BNRCircle

@synthesize center = _center;
@synthesize radius = _radius;

- (CGPoint)center
{
    CGFloat x = (self.startingPoint.x + self.endPoint.x) / 2;
    CGFloat y = (self.startingPoint.y + self.endPoint.y) / 2;
    return CGPointMake(x, y);
}

- (CGFloat)radius
{
    CGFloat deltaX = self.endPoint.x - self.startingPoint.x;
    CGFloat deltaY = self.endPoint.y - self.startingPoint.y;
    CGFloat distance = sqrt(deltaX * deltaX + deltaY * deltaY);
    return (distance / 2) / sqrt(2);
}

@end
