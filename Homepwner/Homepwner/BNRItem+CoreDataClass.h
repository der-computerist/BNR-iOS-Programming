//
//  BNRItem+CoreDataClass.h
//  Homepwner
//
//  Created by Enrique Aliaga Chavez on 1/9/20.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class BNRAssetType, NSObject;

@interface BNRItem : NSManagedObject

- (void)setThumbnailFromImage:(UIImage *)image;

@end

#import "BNRItem+CoreDataProperties.h"
