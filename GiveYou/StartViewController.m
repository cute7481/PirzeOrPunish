//
//  StartViewController.m
//  GiveYou
//
//  Created by SWUCOMPUTER on 2015. 11. 15..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import "StartViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

@synthesize member, sMem;
@synthesize imageView;
@synthesize leftButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    
    if (![app.ID isEqualToString:@""]) {
        self.title = [app.ID stringByAppendingString:@"'s Home"];
        self.member.text = [app.name stringByAppendingString:@", Welcome"];
        leftButton.title = @"Logout";
    }
    
    else {
        self.title = @"Home";
        self.member.text = @"Welcome";
        leftButton.title = @"Back";
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    if (![app.ID isEqualToString:@""]) {
        //[self showUserImage];
    }
    else {
        if (app.choImage != NULL) {
            imageView.image = app.choImage;
        }
    }
}

- (void) showUserImage {
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    NSString *rawStr = [NSString stringWithFormat:@"id=%@", app.ID];
    NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:@"http://condi.swu.ac.kr/Prof-Kang/2013111535/image/findImage.php"];
    NSMutableURLRequest *request =
    [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    NSString *responseString = [[NSString alloc] initWithBytes:[responseData bytes]
                                                        length:[responseData length]
                                                      encoding:NSUTF8StringEncoding];
    NSLog(@"%@", responseString);
    
    NSString *imageName = [NSString stringWithFormat:@"%@", responseString];
    UIImage *image = [UIImage imageNamed:imageName];
    self.imageView.image = image;
    
    if (self.imageView.image != nil) {
        NSString *urlString = @"http://condi.swu.ac.kr/Prof-Kang/2013111535/image/";
        imageName = [urlString stringByAppendingString:imageName];
        NSURL *url = [[NSURL alloc] initWithString:imageName];
        self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    }
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
}


- (IBAction)buttonLogout:(UIBarButtonItem *)sender {
    if ([self.leftButton.title isEqualToString:@"Logout"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Are you sure you want to logout?"
                                                            message: @""
                                                           delegate: self
                                                  cancelButtonTitle: @"Cancel"
                                                  otherButtonTitles: @"Logout", nil];
        [alertView show];
    }
    else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *view = [storyboard instantiateViewControllerWithIdentifier:@"FirstView"];
        [self presentViewController:view animated:YES completion:nil];
    }
}

- (IBAction)selectPicture:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)buttonFriends:(UIButton *)sender {
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    
    if (![app.ID isEqualToString:@""]) {
        [self performSegueWithIdentifier:@"toFriendSuccess" sender:self];
    }
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //UIImage *chosenImage = [info objectForKey:UIImagePickerControllerEditedImage];
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    app.choImage = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    if (![app.ID isEqualToString:@""]) {
        [self saveImage];
    }
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void) saveImage {
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    UIImage *image = self.imageView.image;
    NSString *imageRoute;
    
    if (image != nil) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.9);
        NSString *urlString = @"http://condi.swu.ac.kr/Prof-Kang/2013111535/image/upload.php";
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\".jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:body];
        
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        imageRoute = [[NSString alloc] initWithData:returnData
                                           encoding:NSUTF8StringEncoding];
    }
    
    if (image != nil) {
        NSString *rawStr = [NSString stringWithFormat: @"id=%@&image=%@", app.ID, imageRoute];
        
        NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:@"http://condi.swu.ac.kr/Prof-Kang/2013111535/image/insertImage.php"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:data];
        NSURLResponse *response;
        NSError *err;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
        NSString *responseString =[NSString stringWithUTF8String:[responseData bytes]];
        NSLog(@"%@", responseString);
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSData *logoutData;
    NSInteger success;
    
    if (buttonIndex==1) {
        //Download the json file
        NSURL *jsonFileUrl = [NSURL URLWithString:@"http://condi.swu.ac.kr/Prof-Kang/2013111535/login/logout.php"];
        //Create the request
        NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
        //Create the NSURLConnection
        [NSURLConnection connectionWithRequest:urlRequest delegate:self];
        // Initialize the data object
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        logoutData = [[NSMutableData alloc] init];
        logoutData = [NSURLConnection sendSynchronousRequest:urlRequest
                                           returningResponse:&response error:&error];
        NSDictionary *jsonData = [NSJSONSerialization
                                  JSONObjectWithData:logoutData options:NSJSONReadingMutableContainers error:&error];
        success = [jsonData[@"success"] integerValue];
        NSLog(@"logoutSuccess=%ld",(long)success);
        
        if (success == 1) {
            AppDelegate *app = [[UIApplication sharedApplication]delegate];
            app.ID = @"";
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ViewController *view = [storyboard instantiateViewControllerWithIdentifier:@"FirstView"];
            //LoginViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
            [self presentViewController:view animated:YES completion:nil];
        }
    }
}

@end
