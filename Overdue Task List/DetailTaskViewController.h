//
//  DetailTaskViewController.h
//  Overdue Task List
//
//  Created by Matthew Linaberry on 11/14/14.
//  Copyright (c) 2014 Matthew Linaberry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface DetailTaskViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *dueDateLabel;
@property (strong, nonatomic) Task *taskObject;
- (IBAction)editButtonClick:(UIBarButtonItem *)sender;

@end
