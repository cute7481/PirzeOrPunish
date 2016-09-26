//
//  LoginViewController.h
//  GiveYou
//
//  Created by SWUCOMPUTER on 2015. 11. 17..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *lID;
@property (strong, nonatomic) IBOutlet UITextField *lPW;

- (IBAction)loginPressed:(UIButton *)sender;

- (BOOL) textFieldShouldReturn:(UITextField *)textField;

@end
