//
//  DetailViewController.m
//  GiveYou
//
//  Created by SWUCOMPUTER on 2015. 11. 17..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize dChoice, dName, dNumber, dDue, dDate;
@synthesize detailPrize, detailPunish;
@synthesize detailPrizeD;
@synthesize cGet;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (detailPrize) {
        dChoice.text = @"Prize";
        dName.text = [detailPrize valueForKey:@"name"];
        dNumber.text = [detailPrize valueForKey:@"number"];
        dDue.text = [detailPrize valueForKey:@"due"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle: NSDateFormatterShortStyle];
        [dateFormatter setDateStyle: NSDateFormatterMediumStyle];
        dDate.text = [dateFormatter stringFromDate:[detailPrize valueForKey:@"date"]];
        
        //dDate.text = [detailPrize valueForKey:@"date"];
    }
    else if (detailPunish) {
        dChoice.text = @"Punish";
        dName.text = [detailPunish valueForKey:@"name"];
        dNumber.text = [detailPunish valueForKey:@"number"];
        dDue.text = [detailPunish valueForKey:@"due"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle: NSDateFormatterShortStyle];
        [dateFormatter setDateStyle: NSDateFormatterMediumStyle];
        dDate.text = [dateFormatter stringFromDate:[detailPunish valueForKey:@"date"]];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
