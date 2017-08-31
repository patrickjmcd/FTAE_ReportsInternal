//
//  AlarmTableViewController.m
//  instaPhoto
//
//  Created by Patrick McDonagh on 12/6/12.
//  Copyright (c) 2012 Patrick McDonagh. All rights reserved.
//

#import "AlarmTableViewController.h"
#import "AFJSONRequestOperation.h"
#import "AlarmDetailViewController.h"

@interface AlarmTableViewController ()

@end

@implementation AlarmTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"FTAE";
        self.tabBarItem.image = [UIImage imageNamed:@"toxic"];
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
    NSURL *url = [[NSURL alloc] initWithString:@"http://10.41.16.10:3000/condition_events.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        self.alarms = JSON;
        [self.tableView reloadData]; // this is necessary, because by the time this runs, tableView:numberOfRowsInSection has already executed
        NSLog(@"JSON Successful");
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"NSError: %@",[error localizedDescription]);
    }];
    
    [operation start];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    }

-(void)refresh {
    [self.tableView reloadData];
    NSURL *url = [[NSURL alloc] initWithString:@"http://107.20.191.86:3000/events.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        self.alarms = JSON;
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
    return self.alarms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = self.alarms[indexPath.row][@"sourcename"];
    cell.detailTextLabel.text = self.alarms[indexPath.row][@"eventtimestamp"];
    
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
    // Navigation logic may go here. Create and push another view controller.
    
    AlarmDetailViewController *alarmDetailViewController = [[AlarmDetailViewController alloc] init];
    
    
    alarmDetailViewController.alarmClass = self.alarms[indexPath.row][@"alarmclass"];
    alarmDetailViewController.conditionName = self.alarms[indexPath.row][@"conditionname"];
    alarmDetailViewController.eventTimeStamp = self.alarms[indexPath.row][@"eventtimestamp"];
    alarmDetailViewController.message = self.alarms[indexPath.row][@"message"];
    alarmDetailViewController.sourceName = self.alarms[indexPath.row][@"sourcename"];
    alarmDetailViewController.userComment = self.alarms[indexPath.row][@"usercomment"];
    
    
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:alarmDetailViewController animated:YES];
}

@end
