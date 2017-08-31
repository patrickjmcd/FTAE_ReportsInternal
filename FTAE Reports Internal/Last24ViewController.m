//
//  Last24ViewController.m
//  FTAE Reports
//
//  Created by Patrick McDonagh on 12/7/12.
//  Copyright (c) 2012 Patrick McDonagh. All rights reserved.
//

#import "Last24ViewController.h"
#import "AFJSONRequestOperation.h"
#import "AlarmDetailViewController.h"

@interface Last24ViewController ()

@end

@implementation Last24ViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Last 24 Hours";
        self.tabBarItem.image = [UIImage imageNamed:@"caution"];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh)
             forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    NSURL *url = [[NSURL alloc] initWithString:@"http://10.41.16.10:3000/last24.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        self.last24Alarms = JSON;
        [self.tableView reloadData]; // this is necessary, because by the time this runs, tableView:numberOfRowsInSection has already executed
        NSLog(@"JSON Successful");
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"NSError: %@",[error localizedDescription]);
    }];
    [UIApplication sharedApplication].applicationIconBadgeNumber = self.last24Alarms.count;
    [operation start];
}


-(void)refresh {
    [self.tableView reloadData];
    NSURL *url = [[NSURL alloc] initWithString:@"http://107.20.191.86:3000/last24.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        self.last24Alarms = JSON;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.last24Alarms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = self.last24Alarms[indexPath.row][@"sourcename"];
    cell.detailTextLabel.text = self.last24Alarms[indexPath.row][@"eventtimestamp"];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlarmDetailViewController *alarmDetailViewController = [[AlarmDetailViewController alloc] init];
    
    
    alarmDetailViewController.alarmClass = self.last24Alarms[indexPath.row][@"alarmclass"];
    alarmDetailViewController.conditionName = self.last24Alarms[indexPath.row][@"conditionname"];
    alarmDetailViewController.eventTimeStamp = self.last24Alarms[indexPath.row][@"eventtimestamp"];
    alarmDetailViewController.message = self.last24Alarms[indexPath.row][@"message"];
    alarmDetailViewController.sourceName = self.last24Alarms[indexPath.row][@"sourcename"];
    alarmDetailViewController.userComment = self.last24Alarms[indexPath.row][@"usercomment"];
    
    
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:alarmDetailViewController animated:YES];
}

@end
