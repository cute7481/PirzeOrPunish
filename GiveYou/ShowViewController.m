//
//  ShowViewController.m
//  GiveYou
//
//  Created by SWUCOMPUTER on 2015. 11. 15..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import "ShowViewController.h"
#import <CoreData/CoreData.h>
#import "Prizes.h"
#import "Punishes.h"
#import "AppDelegate.h"

@interface ShowViewController ()

@end

@implementation ShowViewController

@synthesize shChoice, shName, shNumber, shDate;
@synthesize onOffStatus;
@synthesize cChoice, cName, cNumber, cDate;

- (IBAction)savePressed:(UIButton *)sender {
    
    //loginuser save - mysql
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    if (![app.ID isEqualToString:@""]) {
        NSString *rawStr = [NSString stringWithFormat:@"id=%@&name=%@&number=%@&duedate=%@&madedate=%@", app.ID, cName, cNumber, cDate, [NSDate date]];
        NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
        NSURL *url;
        if ([cChoice isEqualToString:@"Prize"]) { //prize save
            url = [NSURL URLWithString:@"http://condi.swu.ac.kr/Prof-Kang/2013111535/pData/insertPrize.php"];
        }
        else { //punish save
            url = [NSURL URLWithString:@"http://condi.swu.ac.kr/Prof-Kang/2013111535/pData/insertPunish.php"];
        }
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:data];
        NSURLResponse *response;
        NSError *err;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
        NSString *responseString =[NSString stringWithUTF8String:[responseData bytes]];
        NSLog(@"%@", responseString);
    }
    
    //nonmember save - coredata
    else if ([cChoice isEqualToString:@"Prize"]) { //prize save
        NSManagedObjectContext *context =nil;
        id delegate = [[UIApplication sharedApplication] delegate];
        if ([delegate performSelector:@selector(managedObjectContext)]) {
            context = [delegate managedObjectContext];
        }
        
        Prizes *newPrize = [NSEntityDescription insertNewObjectForEntityForName:@"Prizes" inManagedObjectContext:context];
        [newPrize setValue:cName forKey:@"name"];
        [newPrize setValue:cDate forKey:@"due"];
        [newPrize setValue:cNumber forKey:@"number"];
        [newPrize setValue:[NSDate date] forKey:@"date"];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
        }
    }
    else { //punish save
        NSManagedObjectContext *context2 =nil;
        id delegate = [[UIApplication sharedApplication] delegate];
        if ([delegate performSelector:@selector(managedObjectContext)]) {
            context2 = [delegate managedObjectContext];
        }
        
        Punishes *newPunish = [NSEntityDescription insertNewObjectForEntityForName:@"Punishes" inManagedObjectContext:context2];
        [newPunish setValue:cName forKey:@"name"];
        [newPunish setValue:cDate forKey:@"due"];
        [newPunish setValue:cNumber forKey:@"number"];
        [newPunish setValue:[NSDate date] forKey:@"date"];
        
        NSError *error2 = nil;
        if (![context2 save:&error2]) {
            NSLog(@"Save Failed! %@ %@", error2, [error2 localizedDescription]);
        }
    }
}

- (BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    shChoice.text = cChoice;
    shName.text = cName;
    shNumber.text = cNumber;
    shDate.text = cDate;
    
    [self.messageView setHidden:!onOffStatus];
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
