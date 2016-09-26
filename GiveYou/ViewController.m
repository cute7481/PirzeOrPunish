//
//  ViewController.m
//  GiveYou
//
//  Created by SWUCOMPUTER on 2015. 11. 15..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize snowAnim;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Start";
    
    [self StartSnowAnimation:0.25]; // 눈이 내리는 효과 애니메이션 시작
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:animated];
}

//animation background
- (IBAction)startPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"toStart" sender:self];
}

- (void) StartSnowAnimation:(float)Duration {
    snowimage = [UIImage imageNamed:@"snow.jpeg"];
    [NSTimer scheduledTimerWithTimeInterval:(0.4) target:self selector:@selector(animationTimerHandler:) userInfo:nil repeats:YES];
}

- (void) animationTimerHandler:(NSTimer *)theTimer {
    UIImageView *snowView = [[UIImageView alloc] initWithImage:snowimage];
    
    int startS = round(random() % 360);
    int endS = round(random() % 360);
    double snowSpeed = 25 + (random() % 10)/10.0;
    
    snowView.alpha = 0.4;
    snowView.frame = CGRectMake(startS, -10, 20, 20);
    
    [UIImageView beginAnimations:nil context:(__bridge void *)(snowView)];
    [UIImageView setAnimationDuration:snowSpeed];
    
    snowView.frame = CGRectMake(endS, 560.0, 20, 20);
    [UIImageView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIImageView setAnimationDelegate:self];
    [snowAnim addSubview:snowView];
    [UIImageView commitAnimations];
}

- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    [(__bridge UIImageView *)context removeFromSuperview];
}

/*

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [[self navigationController] setNavigationBarHidden:NO];
}
 */

@end
