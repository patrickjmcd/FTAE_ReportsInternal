//
//  OverrideViewController.m
//  FTAE Reports
//
//  Created by Patrick McDonagh on 12/7/12.
//  Copyright (c) 2012 Patrick McDonagh. All rights reserved.
//

#import "OverrideViewController.h"
#import "AFJSONRequestOperation.h"
#import "AlarmDetailViewController.h"

@interface OverrideViewController ()

@end

@implementation OverrideViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Override Alarms";
        self.tabBarItem.image = [UIImage imageNamed:@"man"];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    //[super viewDidLoad];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh)
             forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    NSURL *url = [[NSURL alloc] initWithString:@"http://10.41.16.10:3000/override.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        self.overrideAlarms = JSON;
        [self.tableView reloadData]; // this is necessary, because by the time this runs, tableView:numberOfRowsInSection has already executed
        NSLog(@"JSON Successful");
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"NSError: %@",[error localizedDescription]);
    }];
    
    [operation start];
}


-(void)refresh {
    [self.tableView reloadData];
    NSURL *url = [[NSURL alloc] initWithString:@"http://107.20.191.86:3000/override_alarm.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        self.overrideAlarms = JSON;
        [self.tableView reloadData]; // this is necessary, because by the time this runs, tableView:numberOfRowsInSection has already executed
        NSLog(@"JSON Successful");
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"NSError: %@",[error localizedDescription]);
    }];
    [operation start];
    [self.refreshControl endRefreshing];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.overrideAlarms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = self.overrideAlarms[indexPath.row][@"sourcename"];
    cell.detailTextLabel.text = self.overrideAlarms[indexPath.row][@"eventtimestamp"];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlarmDetailViewController *alarmDetailViewController = [[AlarmDetailViewController alloc] init];
    
    
    alarmDetailViewController.alarmClass = self.overrideAlarms[indexPath.row][@"alarmclass"];
    alarmDetailViewController.conditionName = self.overrideAlarms[indexPath.row][@"conditionname"];
    alarmDetailViewController.eventTimeStamp = self.overrideAlarms[indexPath.row][@"eventtimestamp"];
    alarmDetailViewController.message = self.overrideAlarms[indexPath.row][@"message"];
    alarmDetailViewController.sourceName = self.overrideAlarms[indexPath.row][@"sourcename"];
    alarmDetailViewController.userComment = self.overrideAlarms[indexPath.row][@"usercomment"];
    
    
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:alarmDetailViewController animated:YES];
}

@end
