//
//  PrizeData.h
//  GiveYou
//
//  Created by SWUcomputer on 2015. 12. 13..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrizeData : NSObject

@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *duedate;
@property (nonatomic, strong) NSDate *madedate;

@end
