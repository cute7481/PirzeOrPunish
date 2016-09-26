//
//  SearchTableViewController.h
//  GiveYou
//
//  Created by SWUcomputer on 2015. 12. 4..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewController : UITableViewController <UISearchBarDelegate> {
    NSArray *fetchedArray;
}

@property (strong, nonatomic) NSArray *searchFID;
@property (strong, nonatomic) NSMutableArray *filterFriends;

@property (strong, nonatomic) NSString *sID;

@property (strong, nonatomic) UISearchBar * searchFriend;
@property (strong, nonatomic) UISegmentedControl *cho;

@property (assign, nonatomic) BOOL searching;
@property (assign, nonatomic) BOOL letUserSelectRow;

- (void) getUserFriendList;
- (void) searchTableView;

@end
