//
//  MakeViewController.h
//  GiveYou
//
//  Created by SWUCOMPUTER on 2015. 11. 15..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakeViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *sNumber;
@property (strong, nonatomic) IBOutlet UILabel *sDate;

@property (strong, nonatomic) IBOutlet UISegmentedControl *sChoice;
@property (strong, nonatomic) IBOutlet UITextField *sName;
@property (strong, nonatomic) IBOutlet UISwitch *sSwitch;

- (IBAction)getNumber:(UIStepper *)sender;
- (IBAction)getDate:(UIDatePicker *)sender;


- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end
