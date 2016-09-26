//
//  JoinViewController.m
//  GiveYou
//
//  Created by SWUCOMPUTER on 2015. 11. 17..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import "JoinViewController.h"
#import "AppDelegate.h"

@interface JoinViewController ()

@end

@implementation JoinViewController

@synthesize jID, jPW, jRPW, jName;
@synthesize confirmB, check;
@synthesize status;

- (BOOL) textFieldShouldReturn: (UITextField *) textField {
    if (textField == self.jID) {
        [textField resignFirstResponder];
        [self.jPW becomeFirstResponder];
    }
    if (textField == self.jPW) {
        [textField resignFirstResponder];
        [self.jRPW becomeFirstResponder];
    }
    if (textField == self.jRPW) {
        [textField resignFirstResponder];
        [self.jName becomeFirstResponder];
    }
    [textField resignFirstResponder];
    return YES;
}

- (void) alertStatus:(NSString *)msg :(NSString *)title {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Join";
    self.check = YES;
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

- (IBAction)confirmID:(UIButton *)sender {
    NSString *rawStr = [NSString stringWithFormat:@"id=%@", self.jID.text];
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
    NSLog(@"%@",responseString);
    
    if (![responseString isEqualToString:@""]) {
        [confirmB setTitle:@"Can't use" forState:UIControlStateNormal];
        self.check = YES;
        responseString = nil;
    }
    else {
        [confirmB setTitle:@"Can use" forState:UIControlStateNormal];
        self.check = NO;
    }
}

- (IBAction)buttonBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)joinPressed:(UIButton *)sender {
    NSString *userID = self.jID.text;
    NSString *password = self.jPW.text;
    NSString *name = self.jName.text;
    
    if ([userID isEqualToString:@""] || [password isEqualToString:@""] || [name isEqualToString:@""] || [jRPW.text isEqualToString:@""]) {
        //status.text = [NSString stringWithFormat:@"%@", @"내용을 입력하세요"];
        [self alertStatus:@"Please fill in the blanks" :@"Join Failed!"];
    }
    else if (check){
        [self alertStatus:@"Please check your ID" :@"Join Failed!"];
    }
    else if (![jRPW.text isEqualToString:password]) {
        [self alertStatus:@"Your password Not Same" :@"Join Failed!"];
    }
    else {
        NSString *rawStr = [NSString stringWithFormat:@"id=%@&password=%@&name=%@", userID, password, name];
        NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:@"http://condi.swu.ac.kr/Prof-Kang/2013111535/login/insertUser.php"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:data];
        NSURLResponse *response;
        NSError *err;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
        NSString *responseString =[NSString stringWithUTF8String:[responseData bytes]];
        NSLog(@"%@", responseString);
        
        status.text = @"Join Success!";
    }

}

- (IBAction)changeID:(UITextField *)sender {
    self.check = YES;
    [confirmB setTitle:@"Confirm" forState:UIControlStateNormal];
}

@end
