//
//  BNRItemCell.m
//  Homepwner
//
//  Created by Enrique Aliaga Chavez on 10/2/19.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemCell.h"

@interface BNRItemCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;

@end


@implementation BNRItemCell

#pragma mark - View life cycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self updateInterfaceForDynamicTypeSize];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(updateInterfaceForDynamicTypeSize)
                          name:UIContentSizeCategoryDidChangeNotification
                        object:nil];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.thumbnailView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.thumbnailView
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1
                                                                   constant:0];
    [self.thumbnailView addConstraint:constraint];
}

- (void)dealloc
{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
}

#pragma mark - Actions

- (IBAction)showImage:(id)sender
{
    if (self.actionBlock) {
        self.actionBlock();
    }
}

#pragma mark - Dynamic Type

- (void)updateInterfaceForDynamicTypeSize
{
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    self.nameLabel.font = font;
    self.serialNumberLabel.font = font;
    self.valueLabel.font = font;
    
    static NSDictionary *imageSizeDictionary;
    if (!imageSizeDictionary) {
        imageSizeDictionary = @{ UIContentSizeCategoryExtraSmall : @40,
                                 UIContentSizeCategorySmall : @40,
                                 UIContentSizeCategoryMedium : @40,
                                 UIContentSizeCategoryLarge : @40,
                                 UIContentSizeCategoryExtraLarge: @45,
                                 UIContentSizeCategoryExtraExtraLarge: @55,
                                 UIContentSizeCategoryExtraExtraExtraLarge: @65 };
    }
    
    NSString *userSize = [[UIApplication sharedApplication] preferredContentSizeCategory];
    
    NSNumber *imageSize = imageSizeDictionary[userSize];
    self.imageViewHeightConstraint.constant = imageSize.floatValue;
}

@end
