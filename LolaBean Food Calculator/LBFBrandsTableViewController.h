//
//  LBFBrandsTableViewController.h
//  LolaBean Food Calculator
//
//  Created by Antonio Melgarejo on 9/15/14.
//  Copyright (c) 2014 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LBFBrandsSelectorDelegate <NSObject>

- (void)didSelectBrand:(NSString*)brand;

@end

@interface LBFBrandsTableViewController : UITableViewController

@property (nonatomic, weak) id<LBFBrandsSelectorDelegate> delegate;
@property (nonatomic, strong) NSArray *items;

@end
