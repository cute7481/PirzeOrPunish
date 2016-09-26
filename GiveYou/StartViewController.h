//
//  StartViewController.h
//  GiveYou
//
//  Created by SWUCOMPUTER on 2015. 11. 15..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartViewController : UIViewController <
UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *member;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *leftButton;

@property (strong, nonatomic) NSString *sMem;

- (IBAction)buttonLogout:(UIBarButtonItem *)sender;
- (IBAction)selectPicture:(UIButton *)sender;

- (IBAction)buttonFriends:(UIButton *)sender;

- (void) showUserImage;



@end
