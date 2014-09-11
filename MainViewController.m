//
//  MainViewController.m
//  Objective-C Example
//
//  Created by Vijay Jain on 9/4/14.
//  Copyright (c) 2014 Vijay Jain. All rights reserved.
//

#import "MainViewController.h"
#import "SettingsViewController.h"


@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipController;
@property NSUserDefaults *defaults;

-(IBAction)HideKeyboard:(id)sender;
-(void)updateValues;
-(void)onSettingsButton;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title  = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateValues];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];

    

    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [self updateValues];
}
- (IBAction)HideKeyboard:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void) updateValues {
    float billAmount = [self.billTextField.text floatValue];
    
    self.defaults  = [NSUserDefaults standardUserDefaults];
    
    //NSMutableArray *tipArray = [[NSMutableArray alloc] init];
    float tip1 = [self.defaults floatForKey:@"defaultTip1"];
    float tip2 = [self.defaults floatForKey:@"defaultTip2"];
    float tip3 = [self.defaults floatForKey:@"defaultTip3"];
    
    if(!tip1) {
        tip1 = 0.10;
    }
    if(!tip2) {
        tip2 = 0.15;
    }
    if(!tip3) {
        tip3 = 0.20;
    }
    NSNumber *tip1Num = [NSNumber numberWithFloat:tip1];
    NSNumber *tip2Num = [NSNumber numberWithFloat:tip2];
    NSNumber *tip3Num = [NSNumber numberWithFloat:tip3];
    NSArray *tipArray = @[tip1Num,tip2Num,tip3Num];

    int selectedIndex = self.tipController.selectedSegmentIndex ;
    
    while(self.tipController.numberOfSegments > 0)
    {
        [self.tipController removeSegmentAtIndex:0 animated:NO];
    }
    
    NSArray *segements = @[
                          [NSString stringWithFormat:@"$%0.0f%%", tip1*100],
                          [NSString stringWithFormat:@"$%0.0f%%", tip2*100],
                          [NSString stringWithFormat:@"$%0.0f%%", tip3*100]
                          ];
    for (NSString *segment in segements)
    {
        [self.tipController insertSegmentWithTitle:segment atIndex:self.tipController.numberOfSegments  animated:NO];
    }
    self.tipController.selectedSegmentIndex = selectedIndex;

    
    float tipAmount = billAmount *  (roundf ([tipArray[self.tipController.selectedSegmentIndex] floatValue] * 100) / 100.0);
    float totalAmount = billAmount + tipAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

@end
