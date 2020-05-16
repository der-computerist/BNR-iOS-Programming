//
//  BNRLine.m
//  TouchTracker
//
//  Created by Enrique Aliaga Chavez on 3/13/19.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

#import "BNRLine.h"

@implementation BNRLine

- (UIColor *)getColor
{
    double angle = [self getInclinationAngleInDegrees];
    return [UIColor colorWithRed:angle/255.0
                           green:angle/255.0
                            blue:angle/255.0
                           alpha:1.0];
}

- (double)getInclinationAngleInDegrees
{
    double angle = [self getInclinationAngleInRadians] / (M_PI/180);
    return [self truncate:angle];
}

- (double)truncate:(double)angle
{
    if (angle > 180.0) {
        angle -= 180.0;
    }
    return angle;
}

- (double)getInclinationAngleInRadians
{
    double deltaY = (double)(-self.end.y) - (double)(-self.begin.y);
    double deltaX = (double)(self.end.x) - (double)(self.begin.x);
    return [self normalize:atan2(deltaY, deltaX)];
}

- (double)normalize:(double)angle
{
    while (angle < 0.0) {
        angle += M_PI * 2;
    }
    return angle;
}

@end
