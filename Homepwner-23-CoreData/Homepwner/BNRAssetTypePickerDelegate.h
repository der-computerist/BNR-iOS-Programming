//
//  BNRAssetTypePickerDelegate.h
//  Homepwner
//
//  Created by Enrique Aliaga Chavez on 1/24/20.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

#import <CoreData/CoreData.h>

@class BNRAssetTypeViewController;

@protocol BNRAssetTypePickerDelegate <NSObject>

@optional

- (void)assetTypePickerController:(BNRAssetTypeViewController *)picker
        didFinishPickingAssetType:(NSManagedObject *)assetType;

@end
