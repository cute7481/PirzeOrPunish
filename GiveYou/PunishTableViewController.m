//
//  PunishTableViewController.m
//  GiveYou
//
//  Created by SWUCOMPUTER on 2015. 11. 15..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import "PunishTableViewController.h"
#import "DetailViewController.h"
#import <CoreData/CoreData.h>
#import "Punishes.h"
#import "AppDelegate.h"
#import "PrizeData.h"

@interface PunishTableViewController ()

@end

@implementation PunishTableViewController

@synthesize punishes;

- (NSManagedObjectContext *) managedObjectContext {
    NSManagedObjectContext *context2 = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context2 = [delegate managedObjectContext];
    }
    return context2;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // here we get the friends from the persistent data store (or the database)
    NSManagedObjectContext *moc2 = [self managedObjectContext];
    NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] initWithEntityName:@"Punishes"];
    punishes = [[moc2 executeFetchRequest:fetchRequest2 error:nil] mutableCopy];
    
    fetchedArray = [[NSArray alloc] init]; //for loginuser tableview
    
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    if (![app.ID isEqualToString:@""]) {
        [self downloadDataFromServer];
    }

    [self.tableView reloadData];
}

-(void) downloadDataFromServer {
    
    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://condi.swu.ac.kr/Prof-Kang/2013111535/pData/punishTable.php"];
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
        
        AppDelegate *app2 = [[UIApplication sharedApplication]delegate];
        if ([app2.ID isEqualToString:jsonElement[@"userid"]]) {
            PrizeData *newData = [[PrizeData alloc] init];
            newData.userid = jsonElement[@"userid"];
            newData.name = jsonElement[@"name"];
            newData.number = jsonElement[@"number"];
            newData.duedate = jsonElement[@"duedate"];
            newData.madedate = jsonElement[@"madedate"];
            
            [tempArray addObject:newData];
        }
    }
    
    fetchedArray = tempArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = YES;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
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
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    if (![app.ID isEqualToString:@""]) {
        return fetchedArray.count;
    }
    else {
        return punishes.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Punish Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    if (![app.ID isEqualToString:@""]) {
        PrizeData *item = fetchedArray[indexPath.row];
        [cell.textLabel setText:[NSString stringWithFormat:@"%@ #%@", item.name, item.number]];
        [cell.detailTextLabel setText:item.duedate];
    }
    
    else {
        Punishes *punish = [punishes objectAtIndex:indexPath.row];
        [cell.textLabel setText:[NSString stringWithFormat:@"%@ #%@", [punish valueForKey:@"name"], [punish valueForKey:@"number"]]];
        [cell.detailTextLabel setText:[punish valueForKey:@"due"]];
    }
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        NSManagedObjectContext *context = [self managedObjectContext];
        [context deleteObject:[punishes objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]); }
        // Remove friend from table view
        
        [punishes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
    if ([[segue identifier] isEqualToString:@"toDetailPunish"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Punishes *selectedPunish = [punishes objectAtIndex:indexPath.row];
        DetailViewController *destVC = segue.destinationViewController;
        destVC.detailPunish = selectedPunish;
    }
}


@end
