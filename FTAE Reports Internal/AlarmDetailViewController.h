//
//  AlarmDetailViewController.h
//  instaPhoto
//
//  Created by Patrick McDonagh on 12/6/12.
//  Copyright (c) 2012 Patrick McDonagh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmDetailViewController : UIViewController
@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic) NSString *alarmClass;
@property (nonatomic) NSString *conditionName;
@property (nonatomic) NSString *eventTimeStamp;
@property (nonatomic) NSString *message;
@property (nonatomic) NSString *sourceName;
@property (nonatomic) NSString *userComment;
@end
