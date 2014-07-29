//
//  SettingViewController.m
//  SceneChangeSample
//
//  Created by student on 2014/07/04.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController () {
    NSMutableDictionary *config;
}
@property (weak, nonatomic) IBOutlet UIDatePicker *dateInput;
@property (weak, nonatomic) IBOutlet UITextField *nameInput;
- (IBAction)done:(UIButton *)sender;
@property (weak, nonatomic) id <SettingViewControllerDelegate> delegate;
@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)done:(UIButton *)sender {
    // config の設定

    config = [NSMutableDictionary dictionary];
    config[@"name"] = _nameInput.text;
    config[@"date"] = _dateInput.date;
    
    [_delegate settingViewFinished:self config:config];
}
@end
