//
//  ViewController.m
//  DragonFlyCatcher
//
//  Created by student on 2014/07/03.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)catchDragonFly:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *circle;
@property (weak, nonatomic) IBOutlet UIImageView *dragonfly;
@property (weak, nonatomic) IBOutlet UIView *field;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"捕まえる" forState:UIControlStateNormal];
    [button setTitle:@"捕まえる！？" forState:UIControlStateHighlighted];
    [button setTitle:@"捕まえた" forState: UIControlStateDisabled];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    button.frame = CGRectMake(100, 200, 150, 40);
    
    UIColor *buttonColor = [UIColor colorWithRed:20/255.0 green:220/255.0 blue:128/255.0 alpha:1.0];
    button.backgroundColor = buttonColor;
    [button.layer setCornerRadius:10.0];
    [button.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [button.layer setBorderWidth:1.0];
    
    [button addTarget:self action:@selector(catchDragonFly:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)catchDragonFly:(UIButton *)sender {
    CGPoint point = [self.view convertPoint:_dragonfly.center fromView: _field];
    _circle.center = point;
    sender.enabled = NO;
}
@end
