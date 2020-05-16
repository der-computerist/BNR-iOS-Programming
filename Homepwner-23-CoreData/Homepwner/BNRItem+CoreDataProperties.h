//
//  BNRItem+CoreDataProperties.h
//  Homepwner
//
//  Created by Enrique Aliaga Chavez on 1/9/20.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//
//

#import "BNRItem+CoreDataClass.h"

@interface BNRItem (CoreDataProperties)

+ (NSFetchRequest<BNRItem *> *)fetchRequest;

@property (nonatomic) NSDate *dateCreated;
@property (nonatomic, copy) NSString *imageKey;
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic) double orderingValue;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) UIImage *thumbnail;
@property (nonatomic) int valueInDollars;
@property (nonatomic) NSManagedObject *assetType;

@end
