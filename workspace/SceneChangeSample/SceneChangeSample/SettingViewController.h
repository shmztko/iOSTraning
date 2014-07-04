//
//  SettingViewController.h
//  SceneChangeSample
//
//  Created by student on 2014/07/04.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController
@end

@protocol SettingViewControllerDelegate
- (void) settingViewFinished:(SettingViewController *) controller config:(NSMutableDictionary *) config;
@end