//
//  ViewController.m
//  PanGestureSample
//
//  Created by student on 2014/07/03.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    CGPoint prevTranslation;
}
- (IBAction)heartPanned:(UIPanGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *heart;

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

- (IBAction)heartPanned:(UIPanGestureRecognizer *)sender {
    CGPoint translation =[sender translationInView:self.view];
    
    NSLog(@"Current Translation x: %f, y:%f", translation.x, translation.y);
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"State Began");
        [sender setTranslation:prevTranslation inView:self.view];

    } else if (sender.state == UIGestureRecognizerStateChanged) {
        NSLog(@"State Changed");
        _heart.center = CGPointMake(_heart.center.x + translation.x, _heart.center.y + translation.y);

//        _heart.transform = CGAffineTransformMakeTranslation(translation.x, translation.y);
    
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"State Ended");
        prevTranslation = translation;
    }
    [sender setTranslation:CGPointZero inView:self.view];
}
@end
