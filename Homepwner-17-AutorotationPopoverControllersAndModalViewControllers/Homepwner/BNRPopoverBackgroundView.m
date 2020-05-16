//
//  BNRPopoverBackgroundView.m
//  Homepwner
//
//  Created by Enrique Aliaga Chavez on 8/15/19.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

#import "BNRPopoverBackgroundView.h"

@implementation BNRPopoverBackgroundView {
    UIPopoverArrowDirection _arrowDirection;
    CGFloat _arrowOffset;
    UIImageView *_backgroundImageView;
    UIImageView *_arrowImageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // background (for demo only, we don't actually need this for our background)
        UIImage *backgroundImage = [UIImage imageNamed:@"bubble-rect"];
        UIImage *resizableBackgroundImage =
        [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(40, 40, 40, 40)
                                        resizingMode:UIImageResizingModeStretch];
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:resizableBackgroundImage];
        _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
        
        // round those corners!
        _backgroundImageView.layer.cornerRadius = 15;
        _backgroundImageView.layer.masksToBounds = YES;
        
        // arrow
        UIImage *arrowImage = [UIImage imageNamed:@"bubble-triangle"];
        
        _arrowImageView = [[UIImageView alloc] initWithImage:arrowImage];
        
        // make sure the arrow is on top of the background
        [self addSubview:_backgroundImageView];
        [self addSubview:_arrowImageView];
    }
    
    return self;
}

# pragma mark - Accessors

- (CGFloat)arrowOffset
{
    return _arrowOffset;
}

- (void)setArrowOffset:(CGFloat)arrowOffset
{
    _arrowOffset = arrowOffset;
    [self setNeedsLayout];
}

- (UIPopoverArrowDirection)arrowDirection
{
    return _arrowDirection;
}

- (void)setArrowDirection:(UIPopoverArrowDirection)arrowDirection
{
    _arrowDirection = arrowDirection;
    [self setNeedsLayout];
}

+ (BOOL)wantsDefaultContentAppearance
{
    return YES;
}

# pragma mark - UIPopOverBackgroundViewMethods

+ (CGFloat)arrowBase
{
    return 31.0;
}

+ (CGFloat)arrowHeight
{
    return 70.0;
}

+ (UIEdgeInsets)contentViewInsets
{
    return UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
}

# pragma mark - View lifecycle

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat arrowHeight = [self.class arrowHeight];
    
    CGRect backgroundFrame = self.frame;
    CGPoint arrowCenter = CGPointZero;
    CGFloat arrowTransformInRadians = 0;
    
    if (self.arrowDirection == UIPopoverArrowDirectionUp) {
        backgroundFrame.origin.y += arrowHeight;
        backgroundFrame.size.height -= arrowHeight;
        arrowTransformInRadians = 0;
        arrowCenter = CGPointMake(backgroundFrame.size.width/2 + self.arrowOffset, arrowHeight/2);
    } else if (self.arrowDirection == UIPopoverArrowDirectionDown) {
        backgroundFrame.size.height -= arrowHeight;
        arrowTransformInRadians = M_PI;
        arrowCenter = CGPointMake(backgroundFrame.size.width/2 + self.arrowOffset,
                                  backgroundFrame.size.height + arrowHeight/2);
    } else if (self.arrowDirection == UIPopoverArrowDirectionLeft) {
        backgroundFrame.origin.x += arrowHeight;
        backgroundFrame.size.width -= arrowHeight;
        arrowTransformInRadians = M_PI_2 * 3.0;
        arrowCenter = CGPointMake(arrowHeight/2, backgroundFrame.size.height/2 + self.arrowOffset);
    } else if (self.arrowDirection == UIPopoverArrowDirectionRight) {
        backgroundFrame.size.width -= arrowHeight;
        arrowTransformInRadians = M_PI_2;
        arrowCenter = CGPointMake(backgroundFrame.size.width + arrowHeight/2,
                                  backgroundFrame.size.height/2 + self.arrowOffset);
    }
    
    _backgroundImageView.frame = backgroundFrame;
    _arrowImageView.center = arrowCenter;
    _arrowImageView.transform = CGAffineTransformMakeRotation(arrowTransformInRadians);
}

@end
