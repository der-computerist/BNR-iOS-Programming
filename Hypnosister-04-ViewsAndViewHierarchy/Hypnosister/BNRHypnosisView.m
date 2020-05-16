//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by Enrique Aliaga on 1/18/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

#import "BNRHypnosisView.h"

@implementation BNRHypnosisView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // All BNRHypnosisViews start with a clear background color
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;

    // ##################################################
    //  Concentric circles
    // ##################################################
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
    [[UIColor lightGrayColor] setStroke];
    
    // Draw the line!
    [path stroke];

    // ##################################################
    //  Gradient Triangle
    // ##################################################
    // Figure out the gradient's three vertices
    CGPoint v1, v2, v3;
    v1.x = bounds.size.width / 9.0;
    v1.y = bounds.size.height * 8.0 / 9.0;
    v2.x = bounds.size.width * 8.0 / 9.0;
    v2.y = v1.y;
    v3.x = bounds.size.width / 2.0;
    v3.y = bounds.size.height / 7.0;

    // Define the gradient's clipping path
    path = [[UIBezierPath alloc] init];
    [path moveToPoint:v1];
    [path addLineToPoint:v2];
    [path addLineToPoint:v3];
    [path addLineToPoint:v1];

    // Save the graphics context state before clipping
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    [path addClip];  // install path as the clipping path
    
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { 0.0, 1.0, 0.0, 1.0,  // Start color is green
                              1.0, 1.0, 0.0, 1.0 };  // End color is yellow
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components,
        locations, 2);

    CGPoint startPoint = v3;
    CGPoint endPoint = CGPointMake(v3.x, v1.y);
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    
    // Restore the graphics context state, to "uninstall" the clipping path
    CGContextRestoreGState(currentContext);

    // ##################################################
    //  Logo
    // ##################################################
    // Get a new rect specifically for the logo
    CGRect logoRect;
    logoRect.origin.x = bounds.size.width / 7.0;
    logoRect.origin.y = bounds.size.height / 6.0;
    logoRect.size.width = bounds.size.width * 5.0 / 7.0;
    logoRect.size.height = bounds.size.height * 2.0 / 3.0;

    // Save the graphics context state before installing the shadow
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, CGSizeMake(4, 7), 3);  // install the shadow
    
    // Draw stuff here, it will appear with a shadow
    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    [logoImage drawInRect:logoRect];
    
    // Restore the graphics context state, to "uninstall" the shadow
    CGContextRestoreGState(currentContext);
}

@end
