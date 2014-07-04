//
//  Sample01FlipsideViewController.h
//  Sample01
//
//  Created by student on 2014/07/03.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Sample01FlipsideViewController;

@protocol Sample01FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(Sample01FlipsideViewController *)controller;
@end

@interface Sample01FlipsideViewController : UIViewController

@property (weak, nonatomic) id <Sample01FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
