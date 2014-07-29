//
//  ViewController.m
//  SceneChangeSample
//
//  Created by student on 2014/07/04.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [[segue destinationViewController] setDelegate:self];
}

- (void) settingViewFinished:(SettingViewController *) controller config:(NSMutableDictionary *) config {
    _nameLabel.text = config[@"name"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyねん MM がつ ddにち HH:mm"];
    
    _dateLabel.text = [formatter stringFromDate:config[@"date"]];

    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
