//
//  MakeViewController.m
//  GiveYou
//
//  Created by SWUCOMPUTER on 2015. 11. 15..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import "MakeViewController.h"
#import "ShowViewController.h"

@interface MakeViewController ()

@end

@implementation MakeViewController

@synthesize sNumber, sDate, sChoice, sName, sSwitch;

- (BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)getNumber:(UIStepper *)sender {
    if (sender.value == 1) {
        sNumber.text = @"1 time";
    }
    else {
        sNumber.text = [NSString stringWithFormat:@"%d times", (int)sender.value];
    }
    
}

- (IBAction)getDate:(UIDatePicker *)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle: NSDateFormatterShortStyle];
    [dateFormatter setDateStyle: NSDateFormatterMediumStyle];
    self.sDate.text = [dateFormatter stringFromDate: sender.date];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ShowViewController *vc = [segue destinationViewController];
    
    NSString *selected = [sChoice titleForSegmentAtIndex:[sChoice selectedSegmentIndex]];
    
    vc.title = [selected stringByAppendingString:@" For You"];
    
    vc.cChoice = selected;
    vc.cNumber = sNumber.text;
    vc.cName = sName.text;
    vc.cDate = sDate.text;
    
    if (sSwitch.isOn)
        vc.onOffStatus = true;
    else
        vc.onOffStatus = false;

}

@end
