//
//  PrizeTableViewController.h
//  GiveYou
//
//  Created by SWUCOMPUTER on 2015. 11. 15..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrizeTableViewController : UITableViewController {
    NSArray *fetchedArray;
}

@property (strong, nonatomic) NSMutableArray *prizes;

@end
