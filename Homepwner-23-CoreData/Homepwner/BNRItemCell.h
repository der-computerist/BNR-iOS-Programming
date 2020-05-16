//
//  BNRItemCell.h
//  Homepwner
//
//  Created by Enrique Aliaga Chavez on 10/2/19.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@property (nonatomic, copy) void (^actionBlock)(void);

@end
