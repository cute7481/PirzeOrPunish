//
//  ViewController.h
//  GiveYou
//
//  Created by SWUCOMPUTER on 2015. 11. 15..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    UIImageView * SnowImageView;
    UIImage *snowimage;
}

@property (strong, nonatomic) IBOutlet UIImageView *snowAnim;

- (IBAction)startPressed:(UIButton *)sender;

- (void) StartSnowAnimation:(float) Duration;
- (void) animationTimerHandler:(NSTimer*)theTimer;

@end

