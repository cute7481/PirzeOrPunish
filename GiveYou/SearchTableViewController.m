//
//  SearchTableViewController.m
//  GiveYou
//
//  Created by SWUcomputer on 2015. 12. 4..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import "SearchTableViewController.h"
#import "UserData.h"
#import "DetailSearchViewController.h"

@interface SearchTableViewController ()

@end

@implementation SearchTableViewController

@synthesize searchFriend; //search bar
@synthesize cho; //seg

@synthesize searchFID; //friend list
@synthesize sID;
@synthesize filterFriends; //filter friend

@synthesize searching, letUserSelectRow;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //searchFID = [[NSMutableArray alloc]init];
    //self.tableView.bounces = YES;
    
    self.title = @"Search";
    self.searchFID = [NSArray arrayWithObjects:@"Search your friend's ID", nil];
    [self.tableView reloadData];
    
    filterFriends = [[NSMutableArray alloc] init];
    
    //self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    self.searchFriend = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0, 0.0, 320.0, 30.0)];
    
    searchFriend.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    searchFriend.delegate = self;
    searchFriend.returnKeyType = UIReturnKeyDone;
    
    //searchFriend.showsSearchResultsButton = YES
    //searchFriend.showsCancelButton = YES;
    
    //UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 44.0)];
    //searchBarView.autoresizingMask = 0;
    
    //searchFriend.showsCancelButton = YES;
    //[searchBarView addSubview:searchFriend];
    
    self.navigationItem.titleView = searchFriend;
    
    /*
    NSArray *segItem = [[NSArray alloc] initWithObjects:@"ID", @"Name", nil];
    cho = [[UISegmentedControl alloc] initWithItems:segItem];
    
    [cho setTintColor:[UIColor redColor]];
    [cho setFrame:CGRectMake(0, 0, 200, 50)];
    
    [self.tableView addSubview:cho];
     */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //NSArray *requestFriend = [NSArray arrayWithObject:[FriendList friendWithFriendID: i friendName:<#(NSString *)#>]]
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchBar.text];
    filterFriends = [searchFID filteredArrayUsingPredicate:resultPredicate];
}
*/

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    fetchedArray = [[NSArray alloc] init];
    [self getUserFriendList];
    
}

- (void) getUserFriendList {
    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://condi.swu.ac.kr/Prof-Kang/2013111535/friend/friendList.php"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    
    //Create the NSURLConnection
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    NSData *fromServerData = [[NSData alloc] init];
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    fromServerData = [NSURLConnection sendSynchronousRequest:urlRequest
                                           returningResponse:&response error:&error];
    
    // Create an array to store the locations
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    // Parse the JSON that came in
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:fromServerData
                                                         options:NSJSONReadingAllowFragments error:&error];
    for (int i = 0; i < jsonArray.count; i++) {
        NSDictionary *jsonElement = jsonArray[i];
        
        // Create a new UserData object and set its props to JsonElement properties
        UserData *newData = [[UserData alloc] init];
        newData.userid = jsonElement[@"userid"];
        newData.name = jsonElement[@"name"];
        
        // Add this question to the FavoriteData array
        [tempArray addObject:newData];
    }
    
    fetchedArray = tempArray;
    [self.tableView reloadData];
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
     
     //self.searchFriend.frame = CGRectMake(40.0, 0.0, 20.0, 20.0);
     //self.searchFriend.bounds = UIEdge;// = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0);
     
     self.searching = YES;
     self.letUserSelectRow = NO;
     self.tableView.scrollEnabled = NO;
 
 //self.navigationItem.rightBarButtonItem
 }


- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [filterFriends removeAllObjects];
    
    self.searchFriend = searchBar;
    self.searchFriend.text = searchText;
    
    if ([searchText length] > 0) {
        searching = true;
        letUserSelectRow = true;
        self.tableView.scrollEnabled = YES;
        [self searchTableView];
    }
    else {
        searching = NO;
        letUserSelectRow = NO;
        self.tableView.scrollEnabled = NO;
    }
    
    [self.tableView reloadData];
}

- (void) searchTableView {
    
    NSString *searchText = self.searchFriend.text;
    
    for (int i = 0; i < fetchedArray.count; i++) {
        
        UserData *item;
        item = fetchedArray[i];
        NSString *sTemp = item.userid;
        
        if ([sTemp length]) {
            NSRange titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (titleResultsRange.length > 0) {
                [filterFriends addObject:sTemp];
            }
        }
    }
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchFriend resignFirstResponder];
}

/*

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //filterFriends = nil;
    [filterFriends removeAllObjects];
    
    NSString * searchText = self.searchFriend.text;
    
    if ([searchText length] > 0) {
        searching = true;
        letUserSelectRow = true;
        //self.tableView.scrollEnabled = YES;
        [self searchTableView];
    }
    else {
        searching = NO;
        letUserSelectRow = NO;
        //self.tableView.scrollEnabled = NO;
    }
    
    [self.tableView reloadData];

    
}
*/

/*

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    //self.filterFriends = self.searchFID.fi
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    filterFriends = [searchFID filteredArrayUsingPredicate:resultPredicate];
}



- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    [self filterContentForSearchText:searchFriend.text
                               scope:[[self.searchFriend scopeButtonTitles]
                                      objectAtIndex:[self.searchFriend selectedScopeButtonIndex]]];
    return YES;
}

 - (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
     [self filterContentForSearchText:searchString
                                scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                       objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
     return YES;
 }
*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if (searching) {
        return [filterFriends count];
    }
    else {
        return [searchFID count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Match Friend";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];// forIndexPath:indexPath];
    
    if (cell == nil) {
        NSLog(@"cell nill");
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    /*
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    }
     */
    // Configure the cell...
    
    /*
    FriendList *friend = nil;
    if (searching) {
        friend = [self.filterFriends objectAtIndex:indexPath.row];
    } else {
        friend = [self.searchFID objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = friend.friendID;
     */
    //if (cell != nil) {
        if (searching) {
            cell.textLabel.text = [self.filterFriends objectAtIndex:indexPath.row];
        }
        else {
            cell.textLabel.text = [self.searchFID objectAtIndex:indexPath.row];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //}
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"toFriendView"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *selectedFriend = [filterFriends objectAtIndex:indexPath.row];
        DetailSearchViewController *destVC = segue.destinationViewController;
        destVC.friendInfo = selectedFriend;
    }
    
}


@end
