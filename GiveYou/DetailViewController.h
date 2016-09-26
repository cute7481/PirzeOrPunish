//
//  DetailViewController.h
//  GiveYou
//
//  Created by SWUCOMPUTER on 2015. 11. 17..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Prizes.h"
#import "Punishes.h"
#import "PrizeData.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dChoice;
@property (strong, nonatomic) IBOutlet UILabel *dName;
@property (strong, nonatomic) IBOutlet UILabel *dNumber;
@property (strong, nonatomic) IBOutlet UILabel *dDue;
@property (strong, nonatomic) IBOutlet UILabel *dDate;

@property (strong, nonatomic) Prizes *detailPrize;
@property (strong, nonatomic) PrizeData *detailPrizeD;

@property (strong, nonatomic) Punishes *detailPunish;

@property (assign, nonatomic) BOOL *cGet;

@end
