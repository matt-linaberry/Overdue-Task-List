//
//  AddTaskViewController.m
//  Overdue Task List
//
//  Created by Matthew Linaberry on 11/14/14.
//  Copyright (c) 2014 Matthew Linaberry. All rights reserved.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(Task *) getTask
{
    Task *aTask = [[Task alloc] init];
    aTask.title = self.taskNameTextField.text;
    aTask.taskDetail = self.taskDetailTextView.text;
    aTask.date = self.dueDatePicker.date;
    aTask.isComplete = NO;
    return aTask;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addTaskClick:(UIButton *)sender {
    [self.delegate didAddTask:[self getTask]];
}

- (IBAction)cancelButtonClick:(UIButton *)sender {
    [self.delegate didCancel];
}
@end
