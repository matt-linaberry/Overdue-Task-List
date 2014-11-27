//
//  Task.m
//  Overdue Task List
//
//  Created by Matthew Linaberry on 11/26/14.
//  Copyright (c) 2014 Matthew Linaberry. All rights reserved.
//

#import "Task.h"

@implementation Task

#pragma mark - initializers.
-(id) initWithData:(NSDictionary *)data
{
    self = [super init];
    
    if(self)
    {
        self.title = data[TASK_TITLE];
        self.taskDetail = data[TASK_DESC];
        self.date = data[TASK_DUE_DATE];
        self.isComplete = [data[TASK_COMPLETION] boolValue];
    }
    return self;
}

-(id) init
{
    self = [self initWithData:nil];
    return self;
}
@end
