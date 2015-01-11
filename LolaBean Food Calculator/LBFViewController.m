//
//  LBFViewController.m
//  LolaBean Food Calculator
//
//  Created by Antonio Melgarejo on 9/14/14.
//  Copyright (c) 2014 Beans. All rights reserved.
//

#import "LBFViewController.h"
#import "LBFDataManager.h"

@interface LBFViewController ()

@end

@implementation LBFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _numberFormatter = [[NSNumberFormatter alloc] init];
	_numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
	_numberFormatter.maximumFractionDigits = 0;
    
    NSMutableCharacterSet *chartokeep = [NSMutableCharacterSet characterSetWithCharactersInString:@".-"];
    [chartokeep formUnionWithCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
    _chartoremove = [chartokeep invertedSet];

	
	// Do any additional setup after loading the view, typically from a nib.
    [self initialize];
    [self displayFoods];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initialize
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    if ([userdefaults objectForKey:@"calorygoal"])
         _calorygoal = [[userdefaults objectForKey:@"calorygoal"] doubleValue];
    else
        _calorygoal = 100;
    [_txtCaloryGoal setText:[_numberFormatter stringFromNumber:[NSNumber numberWithDouble:_calorygoal]]];
    _justonefood = false;
    _food1calories = 0;
    _food2calories = 0;
    _totalweight = 0;
    [[self ImageFood1] setImage:[UIImage imageNamed:@"generic_can"]];
    [[self ImageFood2] setImage:[UIImage imageNamed:@"generic_can"]];
    [[self ImageFood2] setHidden:true];
    [_labelCarbPerc setHidden:true];
    [_labelCarbTitle setHidden:true];
    [_buttonType1 setEnabled:false];

    
}

#pragma mark Sequges
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"PresentBrandSelectorSegue1"]) {
        LBFBrandsTableViewController *destination = [segue destinationViewController];
        [destination setDelegate:self];
        [destination setItems:[[LBFDataManager sharedInstance] Brands]];
        _activebutton = 1;
        
    }

    else if ([[segue identifier] isEqualToString:@"PresentBrandSelectorSegue2"]) {
        LBFBrandsTableViewController *destination = [segue destinationViewController];
        [destination setDelegate:self];
        [destination setItems:[[LBFDataManager sharedInstance] Brands]];
        _activebutton = 2;
        
    }

    else if ([[segue identifier] isEqualToString:@"PresentTypeSelectorSegue1"]) {
        LBFTypeTableViewController *destination = [segue destinationViewController];
        [destination setDelegate:self];
        [destination setItems:[[LBFDataManager sharedInstance] foodsforBrand:[self selectedBrand1]]];
        [destination setTableselectedBrand:[self selectedBrand1]];
         _activebutton = 1;
    }

    else if ([[segue identifier] isEqualToString:@"PresentTypeSelectorSegue2"]) {
        LBFTypeTableViewController *destination = [segue destinationViewController];
        [destination setDelegate:self];
        [destination setItems:[[LBFDataManager sharedInstance] foodsforBrand:[self selectedBrand2]]];
        [destination setTableselectedBrand:[self selectedBrand2]];
         _activebutton = 2;
    }
}




- (IBAction)caloryGoalModified:(id)sender {
    NSString *cleanstring = [[[sender text] componentsSeparatedByCharactersInSet:_chartoremove] componentsJoinedByString:@""];
    [sender setText:cleanstring];
    _calorygoal = [[_numberFormatter numberFromString:cleanstring] doubleValue];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithDouble:_calorygoal] forKey:@"calorygoal"];
    [self displayFoods];

}

- (IBAction)didChangeFoodSwitch:(id)sender {
    _justonefood = [_foodSwitch isOn];
    if (!_justonefood)
    {
        _food1amount = 0;
        [_txtAmountFed1 setText:@"0"];
    }
    else
    {
        _food2amount = 0;
        [_txtAmountFed2 setText:@"0"];
        _food2calories = 0;
        _totalweight = 0;
        [_txtTotalWeight setText:@""];
        [_buttonBrand2 setTitle:@"Brand" forState:UIControlStateNormal];
        [_buttonType2 setTitle:@"Type" forState:UIControlStateNormal];
        [[self ImageFood2] setImage:[UIImage imageNamed:@"generic_can"]];

    }
    [self displayFoods];
}

- (void) displayFoods
{
    if (!_justonefood)
    {
        [self hideFood2];
        if (_food1calories > 0)
        {
            _food1amount = _calorygoal/_food1calories * 100;
            [_txtAmountFed1 setText:[_numberFormatter stringFromNumber:[NSNumber numberWithDouble:_food1amount]]];
        }
        else
        {
            [_txtAmountFed1 setText:@""];
        }
    }
    else
    {
        [self showFood2];
        if (_food1calories > 0 && _food2calories > 0 && _food1amount > 0)
        {
            _food2amount = (_calorygoal - _food1amount / 100 * _food1calories)/_food2calories * 100;
            [_txtAmountFed2 setText:[_numberFormatter stringFromNumber:[NSNumber numberWithDouble:_food2amount]]];
            _totalweight = _food1amount + _food2amount;
            [_txtTotalWeight setText:[_numberFormatter stringFromNumber:[NSNumber numberWithDouble:_totalweight]]];
        }
        else
        {
            [_txtAmountFed2 setText:@""];
            [_txtTotalWeight setText:@""];
        }
    }

}

- (void) hideFood2
{
    [[self ImageFood2] setHidden:true];
    [[self labelBrand2] setHidden:true];
    [[self labelFed2] setHidden:true];
    [[self txtAmountFed2] setHidden:true];
    [[self labelFed1] setText:@"Amount Required"];
    [[self txtAmountFed1] setUserInteractionEnabled:false];
    [[self txtAmountFed1] setText:@""];
    [[self labelBrand1] setText:@"Food Brand"];
    [[self buttonBrand2] setHidden:true];
    [[self buttonType2] setHidden:true];
    [[self labelType2] setHidden:true];
    [[self labelTotalWeight] setHidden:true];
    [[self txtTotalWeight] setHidden:true];

}


- (void) showFood2
{
    [[self ImageFood2] setHidden:false];
    [[self labelBrand2] setHidden:false];
    [[self labelFed2] setHidden:false];
    [[self txtAmountFed2] setHidden:false];
    [[self labelFed1] setText:@"Amount Fed"];
    [[self txtAmountFed1] setUserInteractionEnabled:true];
    [[self labelBrand1] setText:@"Food 1 Brand"];
    [[self buttonBrand2] setHidden:false];
    [[self buttonType2] setHidden:false];
    [[self labelType2] setHidden:false];
    [[self labelTotalWeight] setHidden:false];
    [[self txtTotalWeight] setHidden:false];
}

- (void) didSelectBrand:(NSString *)brand
{
    if (_activebutton == 1)
    {
        [self setSelectedBrand1:brand];
        [_buttonBrand1 setTitle:brand forState:UIControlStateNormal];
        [self setSelectedType1:@""];
        [_buttonType1 setTitle:@"Type" forState:UIControlStateNormal];
        _food1calories = 0;
        [[self ImageFood1] setImage:[UIImage imageNamed:@"generic_can"]];
        [_labelCarbTitle setHidden:true];
        [_labelCarbPerc setHidden:true];
        [_buttonType1 setEnabled:true];
    }
    else{
        [self setSelectedBrand2:brand];
        [_buttonBrand2 setTitle:brand forState:UIControlStateNormal];
        [_buttonType2 setTitle:@"Type" forState:UIControlStateNormal];
        _food2calories = 0;
        [[self ImageFood2] setImage:[UIImage imageNamed:@"generic_can"]];
    }
    [self displayFoods];
}

-(void) didSelectType:(NSDictionary *)type
{
    if (_activebutton == 1)
    {
        [_buttonType1 setTitle:[type objectForKey:@"FoodName"] forState:UIControlStateNormal];
        [[self ImageFood1] setImage:[UIImage imageNamed:[type objectForKey:@"ImageName"]]];
        _food1calories = [[_numberFormatter numberFromString:[type objectForKey:@"Caloriesper100g"]] doubleValue];
            if (_food1amount > _calorygoal/_food1calories * 100)
            {
                _food1amount = _calorygoal/_food1calories * 100;
                [_txtAmountFed1 setText:[_numberFormatter stringFromNumber:[NSNumber numberWithDouble:_food1amount]]];
            }
        if([type objectForKey:@"Carbs"] != nil)
        {
            [_labelCarbTitle setHidden:false];
            [_labelCarbPerc setHidden:false];
            [_labelCarbPerc setText:[type objectForKey:@"Carbs"]];
        }
        else
        {
            [_labelCarbTitle setHidden:true];
            [_labelCarbPerc setHidden:true];
        }
            
    }

    if (_activebutton == 2)
    {
        [_buttonType2 setTitle:[type objectForKey:@"FoodName"] forState:UIControlStateNormal];
        [[self ImageFood2] setImage:[UIImage imageNamed:[type objectForKey:@"ImageName"]]];
        _food2calories = [[_numberFormatter numberFromString:[type objectForKey:@"Caloriesper100g"]] doubleValue];
    }

    [self displayFoods];
}


- (IBAction)didChangeFoodFed1:(id)sender {
    NSString *cleanstring = [[[sender text] componentsSeparatedByCharactersInSet:_chartoremove] componentsJoinedByString:@""];
    [sender setText:cleanstring];
    _food1amount = [[_numberFormatter numberFromString:cleanstring] doubleValue];
    if (_food1calories > 0)
    {
        if (_food1amount > _calorygoal/_food1calories * 100)
        {
            _food1amount = _calorygoal/_food1calories * 100;
            [sender setText:[_numberFormatter stringFromNumber:[NSNumber numberWithDouble:_food1amount]]];
        }
    }
    [self displayFoods];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _txtCaloryGoal) {
        [textField resignFirstResponder];
    }
    return NO;
}

@end
