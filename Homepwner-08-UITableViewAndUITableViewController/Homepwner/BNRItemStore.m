//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Enrique Aliaga on 11/14/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@property (nonatomic) NSMutableArray *itemsOver50;
@property (nonatomic) NSMutableArray *itemsUnder50;

@end

@implementation BNRItemStore

+ (instancetype)sharedStore
{
    static BNRItemStore *sharedStore = nil;

    // Do I need to create a sharedStore?
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }

    return sharedStore;
}

// If a programmer calls [[BNRItemStore alloc] init], let him
// know the error of his ways
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[BNRItemStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

// Here is the real (secret) initializer
- (instancetype)initPrivate
{
    if (self = [super init]) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allItems
{
    return self.privateItems;
}

- (BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];

    if (item.valueInDollars > 50) {

        if ([self.itemsOver50 count] == 0) {
            [self.privateItems addObject:self.itemsOver50];
        }
        [self.itemsOver50 addObject:item];

    } else {

        if ([self.itemsUnder50 count] == 0) {
            [self.privateItems addObject:self.itemsUnder50];
        }
        [self.itemsUnder50 addObject:item];

    }
    
    return item;
}

- (NSMutableArray *)itemsOver50
{
    if (!_itemsOver50) {
        _itemsOver50 = [[NSMutableArray alloc] init];
    }
    return _itemsOver50;
}

- (NSMutableArray *)itemsUnder50
{
    if (!_itemsUnder50) {
        _itemsUnder50 = [[NSMutableArray alloc] init];
    }
    return _itemsUnder50;
}

@end
