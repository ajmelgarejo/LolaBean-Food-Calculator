//
//  LBFTypeTableViewController.m
//  LolaBean Food Calculator
//
//  Created by Antonio Melgarejo on 9/15/14.
//  Copyright (c) 2014 Beans. All rights reserved.
//

#import "LBFTypeTableViewController.h"

@interface LBFTypeTableViewController ()

@end

@implementation LBFTypeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary* food = [_items objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[food valueForKey:@"FoodName"]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *foodtype = [_items objectAtIndex:[indexPath row]];
    [[self delegate] didSelectType:foodtype];
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
