//
//  DetailTaskViewController.m
//  Overdue Task List
//
//  Created by Matthew Linaberry on 11/14/14.
//  Copyright (c) 2014 Matthew Linaberry. All rights reserved.
//

#import "DetailTaskViewController.h"

@interface DetailTaskViewController ()

@end

@implementation DetailTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.taskNameLabel.text = self.taskObject.title;
    self.taskDetailLabel.text = self.taskObject.taskDetail;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.dueDateLabel.text = [formatter stringFromDate:self.taskObject.date];
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

- (IBAction)editButtonClick:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toEditTaskViewSegue" sender:nil];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[EditTaskViewController class]])
    {
        EditTaskViewController *editTaskViewController = segue.destinationViewController;
        editTaskViewController.task = self.taskObject;
        editTaskViewController.delegate = self;
    }
}

-(void) didUpdateTask
{
    self.taskNameLabel.text = self.taskObject.title;
    self.taskDetailLabel.text = self.taskObject.taskDetail;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:self.taskObject.date];
    self.dueDateLabel.text = stringFromDate;
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate updateTask];
}
@end
