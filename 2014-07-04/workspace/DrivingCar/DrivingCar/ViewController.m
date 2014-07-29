//
//  ViewController.m
//  DrivingCar
//
//  Created by student on 2014/07/03.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    BOOL xDirectionIsTrue;
}
- (IBAction)moveFlower:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *flower;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    xDirectionIsTrue = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)moveFlower:(UIButton *)sender {

    if (xDirectionIsTrue) {
        _flower.center = CGPointMake(_flower.center.x + 30, _flower.center.y + 30);
    } else {
        _flower.center = CGPointMake(_flower.center.x - 30, _flower.center.y - 30);
    }
    xDirectionIsTrue = _flower.center.x > self.view.center.x * 2;

}



@end
