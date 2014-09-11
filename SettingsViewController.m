//
//  SettingsViewController.m
//  Objective-C Example
//
//  Created by Vijay Jain on 9/10/14.
//  Copyright (c) 2014 Vijay Jain. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISlider *tip1Slider;
@property (weak, nonatomic) IBOutlet UISlider *tip2Slider;
@property (weak, nonatomic) IBOutlet UISlider *tip3Slider;
@property (weak, nonatomic) IBOutlet UILabel *tip1Label;
@property (weak, nonatomic) IBOutlet UILabel *tip2Label;
@property (weak, nonatomic) IBOutlet UILabel *tip3Label;

@property NSUserDefaults *defaults;

@end

@implementation SettingsViewController




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.defaults = [NSUserDefaults standardUserDefaults];

    float tip1 = [self.defaults floatForKey:@"defaultTip1"];
    if(!tip1) {
        tip1=0.10;
    }
    float tip2 = [self.defaults floatForKey:@"defaultTip2"];
    if(!tip2) {
        tip2=0.15;
    }
    float tip3 = [self.defaults floatForKey:@"defaultTip3"];
    if(!tip3) {
        tip3=.20;
    }
    self.tip1Label.text = [NSString stringWithFormat:@"Tip %0.0f%%", tip1*100];
    self.tip2Label.text = [NSString stringWithFormat:@"Tip %0.0f%%", tip2*100];
    self.tip3Label.text = [NSString stringWithFormat:@"Tip %0.0f%%", tip3*100];
    self.tip1Slider.value = tip1;
    self.tip2Slider.value = tip2;
    self.tip3Slider.value = tip3;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeTip1Slider:(id)sender {
    float tip1Amount = self.tip1Slider.value;
    
    self.tip1Label.text = [NSString stringWithFormat:@"Tip %0.0f%%", tip1Amount*100];
    [self.defaults setFloat:tip1Amount  forKey:@"defaultTip1"];
}

- (IBAction)changeTip2Slider:(id)sender {
    float tip2Amount = self.tip2Slider.value;
    
    self.tip2Label.text = [NSString stringWithFormat:@"Tip %0.0f%%", tip2Amount*100];
    [self.defaults setFloat:tip2Amount  forKey:@"defaultTip2"];
}


- (IBAction)changeTip3Slider:(id)sender {
    float tip3Amount = self.tip3Slider.value;
    
    self.tip3Label.text = [NSString stringWithFormat:@"Tip %0.0f%%", tip3Amount*100];
    [self.defaults setFloat:tip3Amount  forKey:@"defaultTip3"];
}








@end
