//
//  AddTaskViewController.h
//  Overdue Task List
//
//  Created by Matthew Linaberry on 11/14/14.
//  Copyright (c) 2014 Matthew Linaberry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
@protocol AddTaskViewControllerDelegate <NSObject>
@required
- (void) didCancel;
- (void) didAddTask:(Task *)task;

@end

@interface AddTaskViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) id <AddTaskViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDetailTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *dueDatePicker;
- (IBAction)addTaskClick:(UIButton *)sender;
- (IBAction)cancelButtonClick:(UIButton *)sender;

@end
