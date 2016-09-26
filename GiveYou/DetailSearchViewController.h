//
//  DetailSearchViewController.h
//  GiveYou
//
//  Created by SWUcomputer on 2015. 12. 17..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailSearchViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *detailFID;
@property (strong, nonatomic) IBOutlet UILabel *detailFName;
@property (strong, nonatomic) IBOutlet UIImageView *detailFImage;
@property (strong, nonatomic) IBOutlet UILabel *insertStatus;


@property (strong, nonatomic) NSMutableArray *detailFriend;
@property (strong, nonatomic) NSString * friendInfo;


- (IBAction)addFriend:(UIButton *)sender;
- (IBAction)goBack:(UIButton *)sender;

@end
