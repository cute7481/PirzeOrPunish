//
//  DetailSearchViewController.m
//  GiveYou
//
//  Created by SWUcomputer on 2015. 12. 17..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import "DetailSearchViewController.h"
#import "UserData.h"
#import "AppDelegate.h"

@interface DetailSearchViewController ()

@end

@implementation DetailSearchViewController

@synthesize detailFID, detailFName;
@synthesize detailFImage;
@synthesize insertStatus;

@synthesize detailFriend;
@synthesize friendInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.detailFID.text = friendInfo;
    if (friendInfo) {
        [self findFriendInfo];
    }
}

- (void)findFriendInfo {
    NSString *rawStr = [NSString stringWithFormat:@"id=%@", detailFID.text];
    NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:@"http://condi.swu.ac.kr/Prof-Kang/2013111535/login/findInfo.php"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest: request returningResponse:&response error:&err];
    NSString *responseString = [[NSString alloc] initWithBytes:[responseData bytes]
                                                        length:[responseData length] encoding:NSUTF8StringEncoding];
    
    detailFName.text = responseString;
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

- (IBAction)addFriend:(UIButton *)sender {
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    
    NSString *ID = self.detailFID.text;
    NSString *name = self.detailFName.text;
    NSString *image = nil;
    
    NSString *rawStr = [NSString stringWithFormat:@"id=%@&frdid=%@&frdname=%@&frdimage=%@", app.ID, ID, name, image];
    NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:@"http://condi.swu.ac.kr/Prof-Kang/2013111535/friend/insertFriend.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSString *responseString =[NSString stringWithUTF8String:[responseData bytes]];
    NSLog(@"%@", responseString);
    
    self.insertStatus.text = @"Add Success!";
}

- (IBAction)goBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
