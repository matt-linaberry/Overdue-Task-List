//
//  ViewController.h
//  Overdue Task List
//
//  Created by Matthew Linaberry on 11/14/14.
//  Copyright (c) 2014 Matthew Linaberry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTaskViewController.h"
#import "Task.h"

@interface ViewController : UIViewController <AddTaskViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *taskTableView;
@property (strong, nonatomic) NSMutableArray *taskObjects;

- (IBAction)reorderButtonClick:(UIBarButtonItem *)sender;
- (IBAction)addTaskButtonClick:(UIBarButtonItem *)sender;


@end

