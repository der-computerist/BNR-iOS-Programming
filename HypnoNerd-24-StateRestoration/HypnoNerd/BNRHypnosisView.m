//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by Enrique Aliaga on 1/18/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

#import "BNRHypnosisView.h"

static NSString * const kCircleColor = @"BNRHypnosisViewCircleColor";
static NSString * const kSubviewCount = @"subviews.count";
static NSString * const kLabelKeyFormat = @"UILabel%d";

@interface BNRHypnosisView ()

@property (nonatomic, strong) UIColor *circleColor;

@end

@implementation BNRHypnosisView

#pragma mark - View life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
        self.restorationIdentifier = NSStringFromClass([self class]);
    }
    return self;
}

#pragma mark - Accessors

- (void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

#pragma mark - Custom drawing

- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    
    // Figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    // The largest circle will circumscribe the view
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];

    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
    }
    
    // Configure line width to 10 points
    path.lineWidth = 10;
    
    // Configure the drawing color to light gray
    [self.circleColor setStroke];

    // Draw the line!
    [path stroke];
}

#pragma mark - Touch events

// When a finger touches the screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched", self);

    // Get 3 random numbers between 0 and 1
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;

    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.circleColor = randomColor;
}

#pragma mark - State restoration

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.circleColor forKey:kCircleColor];
    [self encodeLabelsWithCoder:coder];

    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    self.circleColor = [coder decodeObjectForKey:kCircleColor];
    [self decodeLabelsWithCoder:coder];

    [super decodeRestorableStateWithCoder:coder];
}

#pragma mark - Internal

- (void)encodeLabelsWithCoder:(NSCoder *)coder
{
    NSInteger numberOfSubviews = [self.subviews count];
    [coder encodeInteger:numberOfSubviews forKey:kSubviewCount];
    
    for (int i = 0; i < numberOfSubviews; i++) {
        UIView *subview = self.subviews[i];
        if ([subview isKindOfClass:[UILabel class]]) {
            NSString *encodeKey = [NSString stringWithFormat:kLabelKeyFormat, i];
            NSData *labelData = [NSKeyedArchiver archivedDataWithRootObject:subview];
            
            [coder encodeObject:labelData forKey:encodeKey];
        }
    }
}

- (void)decodeLabelsWithCoder:(NSCoder *)coder
{
    NSInteger numberOfSubviews = [coder decodeIntegerForKey:kSubviewCount];
    
    for (int i = 0; i < numberOfSubviews; i++) {
        NSString *encodeKey = [NSString stringWithFormat:kLabelKeyFormat, i];
        NSData *labelData = [coder decodeObjectForKey:encodeKey];
        
        if (labelData) {
            UILabel *label = (UILabel *)[NSKeyedUnarchiver unarchiveObjectWithData:labelData];
            [self addSubview:label];
        }
    }
}

@end
