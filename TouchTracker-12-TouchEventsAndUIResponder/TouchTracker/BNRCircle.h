//
//  BNRCircle.h
//  TouchTracker
//
//  Created by Enrique Aliaga Chavez on 4/3/19.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRCircle : NSObject

@property (nonatomic) CGPoint startingPoint;
@property (nonatomic) CGPoint endPoint;

@property (nonatomic, readonly) CGPoint center;
@property (nonatomic, readonly) CGFloat radius;

@end
