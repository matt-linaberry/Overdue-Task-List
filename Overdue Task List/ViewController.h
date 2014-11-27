//
//  ViewController.h
//  Overdue Task List
//
//  Created by Matthew Linaberry on 11/14/14.
//  Copyright (c) 2014 Matthew Linaberry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *taskTableView;
- (IBAction)reorderButtonClick:(UIBarButtonItem *)sender;
- (IBAction)addTaskButtonClick:(UIBarButtonItem *)sender;


@end

