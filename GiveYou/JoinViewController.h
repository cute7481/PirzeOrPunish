//
//  JoinViewController.h
//  GiveYou
//
//  Created by SWUCOMPUTER on 2015. 11. 17..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoinViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *jID;
@property (strong, nonatomic) IBOutlet UITextField *jPW;
@property (strong, nonatomic) IBOutlet UITextField *jRPW;
@property (strong, nonatomic) IBOutlet UITextField *jName;

@property (strong, nonatomic) IBOutlet UIButton *confirmB;
@property (assign, nonatomic) BOOL check;

@property (strong, nonatomic) IBOutlet UILabel *status;


- (IBAction)confirmID:(UIButton *)sender;
- (IBAction)buttonBack:(UIButton *)sender;
- (IBAction)joinPressed:(UIButton *)sender;
- (IBAction)changeID:(UITextField *)sender;

- (BOOL) textFieldShouldReturn:(UITextField *)textField;

@end
