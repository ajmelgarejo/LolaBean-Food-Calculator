//
//  LBFTypeTableViewController.h
//  LolaBean Food Calculator
//
//  Created by Antonio Melgarejo on 9/15/14.
//  Copyright (c) 2014 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LBFTypeSelectorDelegate <NSObject>

- (void)didSelectType:(NSDictionary*)type;

@end

@interface LBFTypeTableViewController : UITableViewController

@property (nonatomic, weak) id<LBFTypeSelectorDelegate> delegate;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) NSString *tableselectedBrand;

@end
