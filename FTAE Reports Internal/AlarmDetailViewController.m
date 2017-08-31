//
//  AlarmDetailViewController.m
//  instaPhoto
//
//  Created by Patrick McDonagh on 12/6/12.
//  Copyright (c) 2012 Patrick McDonagh. All rights reserved.
//

#import "AlarmDetailViewController.h"

@interface AlarmDetailViewController ()

@end

@implementation AlarmDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(320,560);
    
    UILabel *sourceName = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 40)];
    sourceName.text = [NSString stringWithFormat:@"Alarm: %@",self.sourceName ];
    sourceName.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    [self.scrollView addSubview:sourceName];
    
    UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 280, 30)];
    message.text = [NSString stringWithFormat:@"Condition: %@",self.message ];
    [self.scrollView addSubview:message];
    
    UILabel *alarmClass = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 30)];
    alarmClass.text = [NSString stringWithFormat:@"AlarmClass: %@",self.alarmClass ];
    [self.scrollView addSubview:alarmClass];
    
    UILabel *eventTimeStamp = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 280, 30)];
    eventTimeStamp.text = [NSString stringWithFormat:@"Time: %@",self.eventTimeStamp ];
    [self.scrollView addSubview:eventTimeStamp];
   
    UILabel *userComment = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 280, 30)];
    userComment.text = [NSString stringWithFormat:@"Comment: %@",self.userComment ];
    [self.scrollView addSubview:userComment];
    
    UILabel *conditionName = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, 280, 30)];
    conditionName.text = [NSString stringWithFormat:@"Alarm: %@",self.conditionName ];
    [self.scrollView addSubview:conditionName];
    
    
    [self.view addSubview:self.scrollView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
