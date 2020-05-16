//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by Enrique Aliaga Chavez on 3/13/19.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"
#import "BNRCircle.h"

const int CIRCLE = 0;
const int POINT = 1;
NSString * const kLabelStartingPoint = @"STARTING_POINT";
NSString * const kLabelEndPoint = @"END_POINT";

@interface BNRDrawView ()

@property (nonatomic, strong) NSMutableArray *currentTouches;
@property (nonatomic, strong) NSMutableDictionary *circlesInProgress;
@property (nonatomic, strong) NSMutableArray *finishedCircles;

@end

@implementation BNRDrawView

# pragma mark - View life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.currentTouches = [[NSMutableArray alloc] init];
        self.circlesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedCircles = [[NSMutableArray alloc] init];
        
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
    }
    return self;
}

# pragma mark - Touch events

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // Let's put in a log statement to see the order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        [self.currentTouches addObject:t];
        
        NSInteger touchCount = self.currentTouches.count;
        if (touchCount % 2) {
            // do nothing; another touch is needed to define a circle
        } else {
            // we have an even number of touches; we can define a circle now
            BNRCircle *circle = [[BNRCircle alloc] init];
            
            UITouch *startingTouch = self.currentTouches[touchCount - 2];
            NSValue *startingTouchRef = [NSValue valueWithNonretainedObject:startingTouch];
            circle.startingPoint = [startingTouch locationInView:self];
            
            UITouch *endTouch = self.currentTouches[touchCount - 1];
            NSValue *endTouchRef = [NSValue valueWithNonretainedObject:endTouch];
            circle.endPoint = [endTouch locationInView:self];

            self.circlesInProgress[startingTouchRef] = @[circle, kLabelStartingPoint];
            self.circlesInProgress[endTouchRef] = @[circle, kLabelEndPoint];
        }
        
        [self setNeedsDisplay];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // Let's put in a log statement to see the order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue *tRef = [NSValue valueWithNonretainedObject:t];
        BNRCircle *circle = self.circlesInProgress[tRef][CIRCLE];
        NSString *label = self.circlesInProgress[tRef][POINT];
        
        if ([label isEqualToString:kLabelStartingPoint]) {
            circle.startingPoint = [t locationInView:self];
        } else {
            circle.endPoint = [t locationInView:self];
        }
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // Let's put in a log statement to see the order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue *tRef = [NSValue valueWithNonretainedObject:t];
        
        [self.currentTouches removeObject:t];
        NSInteger touchCount = self.currentTouches.count;
        
        if (touchCount % 2 == 0) {
            // there's an even number of touches left: one circle has been finalized
            BNRCircle *circle = self.circlesInProgress[tRef][CIRCLE];
            if (circle) {
                [self.finishedCircles addObject:circle];
            }
        }
        
        [self.circlesInProgress removeObjectForKey:tRef];
        [self setNeedsDisplay];
    }
}

# pragma mark - Circle drawing

- (void)strokeCircle:(BNRCircle *)circle
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    
    [bp addArcWithCenter:circle.center
                  radius:circle.radius
              startAngle:0.0
                endAngle:M_PI * 2.0
               clockwise:YES];
    [bp stroke];
}

- (void)drawRect:(CGRect)rect
{
    // Draw finished circles in black
    [[UIColor blackColor] set];
    for (BNRCircle *circle in self.finishedCircles) {
        [self strokeCircle:circle];
    }
    
    // Draw circles in progress in red
    [[UIColor redColor] set];
    for (NSValue *tRef in self.circlesInProgress) {
        BNRCircle *circle = self.circlesInProgress[tRef][CIRCLE];
        [self strokeCircle:circle];
    }
}

@end
