//
//  BNRItem+CoreDataProperties.m
//  Homepwner
//
//  Created by Enrique Aliaga Chavez on 1/9/20.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//
//

#import "BNRItem+CoreDataProperties.h"

@implementation BNRItem (CoreDataProperties)

+ (NSFetchRequest<BNRItem *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"BNRItem"];
}

@dynamic dateCreated;
@dynamic imageKey;
@dynamic itemName;
@dynamic orderingValue;
@dynamic serialNumber;
@dynamic thumbnail;
@dynamic valueInDollars;
@dynamic assetType;

@end
