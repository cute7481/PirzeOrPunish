//
//  LoginViewController.m
//  GiveYou
//
//  Created by SWUCOMPUTER on 2015. 11. 17..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize lID, lPW;

- (BOOL) textFieldShouldReturn: (UITextField *) textField {
    
    if (textField == self.lID) {
        [textField resignFirstResponder];
        [self.lPW becomeFirstResponder];
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
    self.title = @"Login";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"toCreateID"]) {
        
        
    }
        //LogoutViewController *vc = [segue destinationViewController];
       // vc.message = message;
      //  vc.reason = reason;
     //   vc.success = success;
        
   // } // else of if ([segue identifier])
}

- (IBAction)loginPressed:(UIButton *)sender {
        
        NSInteger success = 0;
        
        @try {
            
            // ID/PW가 빈칸일 때
            if ([[self.lID text] isEqualToString:@""] || [[self.lPW text] isEqualToString:@""] ) {
                [self alertStatus:@"Please enter ID and/or Password" :@"Sign in Failed!"];
            }
            
            else {
                
                // ID/PW 넘기는 형식
                NSString *post =[[NSString alloc] initWithFormat:@"userid=%@&password=%@", [self.lID text], [self.lPW text]];
                NSLog(@"%@", post);
                
                
                // 리소스를 가져오기 위한 객체
                NSURL *url = [NSURL URLWithString:@"http://condi.swu.ac.kr/Prof-Kang/2013111535/login/login.php"];
                NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
                NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                [request setURL:url];
                [request setHTTPMethod:@"POST"];
                [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
                [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
                [request setHTTPBody:postData];
                
                NSError *error = [[NSError alloc] init];
                NSHTTPURLResponse *response = nil;
                NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                
                if ([response statusCode] >= 200 && [response statusCode] < 300) {
                    NSError *error = nil;
                    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error:&error];
                    success = [jsonData[@"success"] integerValue];
                    
                    if(success == 1) {
                        //send ID
                        NSString *rawStr = [NSString stringWithFormat:@"id=%@", self.lID.text];
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
                        
                        AppDelegate *app = [[UIApplication sharedApplication]delegate];
                        app.ID = [NSString stringWithFormat:@"%@", [self.lID text]];
                        app.name = responseString;
                    }
                    
                    else {
                        NSString *error_msg = (NSString *) jsonData[@"error_message"];
                        //NSLog(error_msg);
                        [self alertStatus:error_msg :@"Sign in Failed!"];
                    }
                }
                
                else { // if ([response statusCode]
                    [self alertStatus:@"Connection Failed" :@"Sign in Failed!"];
                }
                // else of if [.. isEqualToString ..] // try
            }
        }
        
        @catch (NSException * e) {
            NSLog(@"Exception: %@", e);
            
            [self alertStatus:@"Sign in Failed." :@"Error!"];
        }
        
        if (success) {
            [self performSegueWithIdentifier:@"toLoginSuccess" sender:self];
        }
}

@end
