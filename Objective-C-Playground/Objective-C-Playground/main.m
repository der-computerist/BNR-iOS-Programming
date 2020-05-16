//
//  main.m
//  Objective-C-Playground
//
//  Created by Enrique Aliaga on 11/28/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNROwnedAppliance.h"

typedef void(^ArrayEnumerationBlock)(id, NSUInteger, BOOL *);

int main(int argc, const char * argv[])
{
    @autoreleasepool {

        BNRAppliance *a = [[BNRAppliance alloc] initWithProductName:@"Toaster"];
        NSLog(@"a is %@", a);

        BNROwnedAppliance *oa = [[BNROwnedAppliance alloc] init];
        NSLog(@"owned appliance is %@", oa);

//        [oa addOwnerName:@"Diego Alminagorta"];
//        [oa removeOwnerName:@"Enrique Aliaga"];
        

        /*
        NSMutableArray *stocks = [[NSMutableArray alloc] init];
        
        NSMutableDictionary *stock;
        
        stock = [NSMutableDictionary dictionary];
        [stock setObject:@"AAPL" forKey:@"symbol"];
        [stock setObject:[NSNumber numberWithInt:200] forKey:@"shares"];
        [stocks addObject:stock];
        
        stock = [NSMutableDictionary dictionary];
        [stock setObject:@"GOOG" forKey:@"symbol"];
        [stock setObject:[NSNumber numberWithInt:160] forKey:@"shares"];
        [stocks addObject:stock];
        
        [stocks writeToFile:@"/tmp/stocks.plist" atomically:YES];
        
        NSArray *stockList = [NSArray arrayWithContentsOfFile:@"/tmp/stocks.plist"];
        
        for (NSDictionary *d in stockList) {
            NSLog(@"I have %@ shares of %@",
                [d objectForKey:@"shares"], [d objectForKey:@"symbol"]);
        }
         */

        /*
        BNREmployee *mikey = [[BNREmployee alloc] init];
        mikey.weightInKilos = 90;
        mikey.heightInMeters = 1.8;
        mikey.employeeID = 0;
        
        for (int i = 0; i < 10; i++) {
            BNRAsset *asset = [[BNRAsset alloc] init];
            
            NSString *currentLabel = [NSString stringWithFormat:@"Laptop %d", i];
            asset.label = currentLabel;
            asset.resaleValue = 350 + i * 17;
            
            [mikey addAsset:asset];
        }

        NSLog(@"Value of assets: %d", [mikey valueOfAssets]);
        sleep(100);
        */
        /*
        // Declare divBlock variable
        double (^divBlock)(double, double);
        
        // Assign block to variable
        divBlock = ^(double dividend, double divisor) {
            double quotient = dividend / divisor;
            return quotient;
        };
        
        double myQuotient = divBlock(42.0, 12.5);
        NSLog(@"myQuotient: %.2f", myQuotient);
         */
        
        /*
        // Create array of strings and a container for devowelized ones
        NSArray *originalStrings = @[@"Sauerkraut", @"Raygun", @"Big Nerd Ranch", @"Mississippi"];
        
        NSLog(@"original strings: %@", originalStrings);
        
        NSMutableArray *devowelizedStrings = [NSMutableArray array];
        
        // Create a list of characters to be removed from the string
        NSArray *vowels = @[@"a", @"e", @"i", @"o", @"u"];
        
        ArrayEnumerationBlock devowelizer;
        
        devowelizer = ^(id string, NSUInteger i, BOOL *stop) {
            
            NSRange yRange = [string rangeOfString:@"y" options:NSCaseInsensitiveSearch];
            
            // Did I find a y?
            if (yRange.location != NSNotFound) {
                *stop = YES;  // prevent further iterations
                return;       // end this iteration
            }
            
            NSMutableString *newString = [NSMutableString stringWithString:string];
            
            // Iterate over the array of vowels, replacing occurrences of each
            // with an empty string
            for (NSString *s in vowels) {
                NSRange fullRange = NSMakeRange(0, [newString length]);
                [newString replaceOccurrencesOfString:s withString:@""
                    options:NSCaseInsensitiveSearch range:fullRange];
            }
            
            [devowelizedStrings addObject:newString];
        };  // end of block assignment
        
        // Iterate over the array with your block
        [originalStrings enumerateObjectsUsingBlock:devowelizer];
        NSLog(@"devowelized strings: %@", devowelizedStrings);
         */
    }
    return 0;
}

