//
//  ViewController.m
//  SegmentedControlSample
//
//  Created by student on 2014/07/03.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)handleSegmentedControl:(UISegmentedControl *)sender;

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

- (IBAction)handleSegmentedControl:(UISegmentedControl *)sender {
    NSLog(@"%@", sender.selectedSegmentIndex);
    self.view.backgroundColor = [self getColor:sender.selectedSegmentIndex];
}

- (UIColor *) getColor:(NSInteger) colorType {
    switch (colorType) {
        case 1:
            return [UIColor blueColor];
        case 2:
            return [UIColor yellowColor];
        case 3:
            return [UIColor redColor];
        case 4:
            return [UIColor greenColor];
        case 5:
            return nil;
        case 6:
            return [UIColor purpleColor];
        default:
            return [UIColor blackColor];
    }
}

@end
