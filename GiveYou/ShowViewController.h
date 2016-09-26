//
//  ShowViewController.h
//  GiveYou
//
//  Created by SWUCOMPUTER on 2015. 11. 15..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *shChoice;
@property (strong, nonatomic) IBOutlet UILabel *shName;
@property (strong, nonatomic) IBOutlet UILabel *shNumber;
@property (strong, nonatomic) IBOutlet UILabel *shDate;

@property (assign, nonatomic) BOOL onOffStatus;

@property (strong, nonatomic) NSString *cChoice;
@property (strong, nonatomic) NSString *cName;
@property (strong, nonatomic) NSString *cNumber;
@property (strong, nonatomic) NSString *cDate;

@property (strong, nonatomic) IBOutlet UIView *messageView;

- (IBAction)savePressed:(UIButton *)sender;

- (BOOL) textFieldShouldReturn:(UITextField *)textField;

@end
