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
    
    NSArray *theTasks = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_LIST];
    
    for (NSDictionary *dictionary in theTasks)
    {
        Task *taskObject = [self taskObjectForDictionary:dictionary];
        [self.taskObjects addObject:taskObject];
    }
    self.taskTableView.dataSource = self;
    self.taskTableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)reorderButtonClick:(UIBarButtonItem *)sender {
}

- (IBAction)addTaskButtonClick:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toAddTaskViewControllerSegue" sender:nil];
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
    [self.taskTableView reloadData];
    
}

-(NSDictionary *) taskObjectAsAPropertyList:(Task *)taskObject
{
    NSDictionary *taskDictionary = @{TASK_TITLE:taskObject.title, TASK_DESC:taskObject.taskDetail, TASK_DUE_DATE:taskObject.date, TASK_COMPLETION:@(taskObject.isComplete)};
    return taskDictionary;
}

-(Task *) taskObjectForDictionary:(NSDictionary *) dictionary
{
    Task *taskObject = [[Task alloc] initWithData:dictionary];
    return taskObject;
}

- (BOOL) isGreaterThanDate:(NSDate *)date and:(NSDate *)toDate
{
    int dateAsInt = [date timeIntervalSince1970];
    int toDateAsInt = [toDate timeIntervalSince1970];
    
    if (dateAsInt < toDateAsInt)
        return YES;
    else
        return NO;
    
}

#pragma mark - UITableView data source stuff.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.taskObjects count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // this method should display the task information
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    Task *taskObject = [self.taskObjects objectAtIndex:indexPath.row];
    cell.textLabel.text =taskObject.title;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];

    if (taskObject.isComplete)
    {
        cell.backgroundColor = [UIColor greenColor];
    }
    else
    {
        cell.backgroundColor = [UIColor yellowColor];
    }
    
    if (([self isGreaterThanDate:taskObject.date and:[NSDate date]]) && !(taskObject.isComplete)){
        cell.backgroundColor = [UIColor redColor];
    }
    cell.detailTextLabel.text = [formatter stringFromDate:taskObject.date];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // call the helper method.
    
    Task *taskObject = [self.taskObjects objectAtIndex:indexPath.row];
    [self updateCompletionOfTask:taskObject forIndexPath:indexPath];

}

- (void) updateCompletionOfTask:(Task *)task forIndexPath:(NSIndexPath *)indexPath
{
    task.isComplete = !(task.isComplete); // flip the flag
    
    // get the array of tasks from the NSUserDefaults object
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_LIST] mutableCopy];
    // remove the task from the array
    [taskObjectsAsPropertyLists removeObjectAtIndex:indexPath.row];
    // re-add the new task object to the NSUserDefaults array
    [taskObjectsAsPropertyLists addObject:[self taskObjectAsAPropertyList:task]];
    // presist the array to the NSUserDefaults
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.taskTableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // delete the row from the data source
        [self.taskObjects removeObjectAtIndex:indexPath.row];
        
        // delete the row from the NSUserDefaults array
        NSMutableArray *updatedTaskList = [[NSMutableArray alloc] init];
        for (Task *taskObject in self.taskObjects)
        {
            [updatedTaskList addObject:[self taskObjectAsAPropertyList:taskObject]];
        }
        [[NSUserDefaults standardUserDefaults] setObject:updatedTaskList forKey:TASK_LIST];
        // finally, sync the updated NSUserDefaults array
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
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
