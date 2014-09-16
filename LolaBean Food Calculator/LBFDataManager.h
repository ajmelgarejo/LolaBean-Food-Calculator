//
//  LBFDataManager.h
//  LolaBean Food Calculator
//
//  Created by Antonio Melgarejo on 9/15/14.
//  Copyright (c) 2014 Beans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBFDataManager : NSObject

+ (id)sharedInstance;

// Data lookups
- (NSArray*)Brands;
- (NSArray*)Foods;
- (NSArray*)foodsforBrand:(NSString*)brand;


@end
