//
//  EditTaskViewController.m
//  Overdue Task List
//
//  Created by Matthew Linaberry on 11/14/14.
//  Copyright (c) 2014 Matthew Linaberry. All rights reserved.
//

#import "EditTaskViewController.h"

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.taskNameTextField.text = self.task.title;
    self.taskDetailTextView.text=  self.task.description;
    self.dueDatePicker.date = self.task.date;
    self.taskNameTextField.delegate = self;
    self.taskDetailTextView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) updateTask
{
    self.task.title = self.taskNameTextField.text;
    self.task.taskDetail = self.taskDetailTextView.text;
    self.task.date = self.dueDatePicker.date;
}

- (IBAction)saveButtonClick:(UIBarButtonItem *)sender {
    [self updateTask];
    [self.delegate didUpdateTask];
}

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
@end
