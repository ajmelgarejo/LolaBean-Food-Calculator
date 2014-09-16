//
//  LBFViewController.h
//  LolaBean Food Calculator
//
//  Created by Antonio Melgarejo on 9/14/14.
//  Copyright (c) 2014 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBFBrandsTableViewController.h"
#import "LBFTypeTableViewController.h"

@interface LBFViewController : UIViewController<LBFBrandsSelectorDelegate, LBFTypeSelectorDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *ImageFood1;
@property (weak, nonatomic) IBOutlet UIImageView *ImageFood2;
@property (weak, nonatomic) IBOutlet UITextField *txtCaloryGoal;
@property (weak, nonatomic) IBOutlet UITextField *txtAmountFed1;
@property (weak, nonatomic) IBOutlet UITextField *txtAmountFed2;
@property (weak, nonatomic) IBOutlet UISwitch *foodSwitch;

@property (weak, nonatomic) IBOutlet UILabel *labelFed1;
@property (weak, nonatomic) IBOutlet UILabel *labelFed2;
@property (weak, nonatomic) IBOutlet UILabel *labelBrand1;
@property (weak, nonatomic) IBOutlet UILabel *labelBrand2;

@property CGFloat calorygoal;
@property CGFloat food1amount;
@property CGFloat food2amount;
@property CGFloat food1calories;
@property CGFloat food2calories;
@property BOOL justonefood;

@property int activebutton;

@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
@property (nonatomic, strong)  NSCharacterSet *chartoremove;

@property (nonatomic, weak) NSString *selectedBrand1;
@property (nonatomic, weak) NSString *selectedType1;
@property (nonatomic, weak) NSString *selectedBrand2;
@property (nonatomic, weak) NSString *selectedType2;
@property (weak, nonatomic) IBOutlet UIButton *buttonBrand1;
@property (weak, nonatomic) IBOutlet UIButton *buttonType1;
@property (weak, nonatomic) IBOutlet UIButton *buttonType2;

@property (weak, nonatomic) IBOutlet UIButton *buttonBrand2;
@property (weak, nonatomic) IBOutlet UILabel *labelType2;

@end
