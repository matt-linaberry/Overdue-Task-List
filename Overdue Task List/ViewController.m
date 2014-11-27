//
//  ViewController.m
//  Overdue Task List
//
//  Created by Matthew Linaberry on 11/14/14.
//  Copyright (c) 2014 Matthew Linaberry. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)reorderButtonClick:(UIBarButtonItem *)sender {
}

- (IBAction)addTaskButtonClick:(UIBarButtonItem *)sender {
}

-(NSMutableArray *) taskObjects
{
    // lazy instantiation - let's make sure it's instantiated when we do the get
    if (!_taskObjects)
    {
        _taskObjects = [[NSMutableArray alloc] init];
        
    }
    return _taskObjects;
}

-(void) didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) didAddTask:(Task *)task
{
    [self.taskObjects addObject:task];
    NSMutableArray *taskObjectsAsList = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_LIST] mutableCopy];
    if (!taskObjectsAsList)
    {
        taskObjectsAsList = [[NSMutableArray alloc] init];
    }
    [taskObjectsAsList addObject:[self taskObjectAsAPropertyList:task]];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsList forKey:TASK_LIST];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(NSDictionary *) taskObjectAsAPropertyList:(Task *)taskObject
{
    NSDictionary *taskDictionary = @{TASK_TITLE:taskObject.title, TASK_DESC:taskObject.taskDetail, TASK_DUE_DATE:taskObject.date, TASK_COMPLETION:@(taskObject.isComplete)};
    return taskDictionary;
}

# pragma mark - Navigation stuffs
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // is the destination view controller the AddTaskViewController?
    if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]])
    {
        AddTaskViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }
}
@end
