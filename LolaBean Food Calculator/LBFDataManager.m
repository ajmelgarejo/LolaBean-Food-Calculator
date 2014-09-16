//
//  LBFDataManager.m
//  LolaBean Food Calculator
//
//  Created by Antonio Melgarejo on 9/15/14.
//  Copyright (c) 2014 Beans. All rights reserved.
//

#import "LBFDataManager.h"

@implementation LBFDataManager

+ (id)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}


- (NSArray*)Brands
{
    static NSArray* brandArray;
    if (!brandArray) {
        brandArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Brands" ofType:@"plist"]];
    }
    return brandArray;
}

- (NSArray*)Foods
{
    static NSArray *foodArray;
    if (!foodArray) {
        foodArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"foods" ofType:@"plist"]];
    }
    return foodArray;
}

- (NSArray*) foodsforBrand:(NSString *)brand
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Brand LIKE[c] %@", brand];
    return [[[self Foods] filteredArrayUsingPredicate:predicate] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"FoodName" ascending:YES]]];

}

@end
