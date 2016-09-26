//
//  Punishes.h
//  GiveYou
//
//  Created by SWUCOMPUTER on 2015. 11. 17..
//  Copyright (c) 2015년 SWUCOMPUTER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Punishes : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * due;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * number;

@end
