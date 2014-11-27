//
//  Task.h
//  Overdue Task List
//
//  Created by Matthew Linaberry on 11/26/14.
//  Copyright (c) 2014 Matthew Linaberry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *taskDetail;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL isComplete;

-(id) initWithData:(NSDictionary *)data;

@end
