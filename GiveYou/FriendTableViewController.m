//
//  FriendTableViewController.m
//  GiveYou
//
//  Created by SWUcomputer on 2015. 12. 6..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import "FriendTableViewController.h"
#import "AppDelegate.h"
#import "FriendData.h"

@interface FriendTableViewController ()

@end

@implementation FriendTableViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    friends = [[NSArray alloc] init];
    fFriends = [[NSArray alloc] init];
    
    [self getFriendList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)getFriendList {
    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://condi.swu.ac.kr/Prof-Kang/2013111535/friend/userFList.php"];
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
        FriendData *friendData = [[FriendData alloc] init];
        friendData.userid = jsonElement[@"userid"];
        friendData.frdid = jsonElement[@"frdid"];
        friendData.frdname = jsonElement[@"frdname"];
        
        // Add this question to the FavoriteData array
        [tempArray addObject:friendData];
    }
    
    friends = tempArray;
    
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < friends.count; i++) {
        FriendData *item;
        item = friends[i];
        
        if ([item.userid isEqualToString:app.ID]) {
            [temp addObject:item];
        }
    }
    
    fFriends = temp;
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return fFriends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Friend Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    FriendData *items;
    items = fFriends[indexPath.row];
    
    cell.textLabel.text = items.frdid;
    cell.detailTextLabel.text = items.frdname;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
