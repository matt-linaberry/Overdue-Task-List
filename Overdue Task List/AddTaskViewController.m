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
    self.taskNameTextField.delegate = self;
    self.taskDetailTextView.delegate = self;
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.taskNameTextField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        // this works when you put a carriage return in the string.
        [self.taskDetailTextView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (IBAction)addTaskClick:(UIButton *)sender {
    [self.delegate didAddTask:[self getTask]];
}

- (IBAction)cancelButtonClick:(UIButton *)sender {
    [self.delegate didCancel];
}
@end
