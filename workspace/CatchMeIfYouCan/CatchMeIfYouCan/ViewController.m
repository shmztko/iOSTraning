//
//  ViewController.m
//  CatchMeIfYouCan
//
//  Created by student on 2014/07/03.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *heartImage;
- (IBAction)heartTapped:(UITapGestureRecognizer *)sender;

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

- (IBAction)heartTapped:(UITapGestureRecognizer *)sender {
    CGFloat heartWidth = _heartImage.bounds.size.width;
    CGFloat heartHeight = _heartImage.bounds.size.height;
    NSInteger w = self.view.bounds.size.width - heartWidth;
    NSInteger h = self.view.bounds.size.height - heartHeight;
    
    NSLog(@"W : %d", w);
    NSLog(@"H : %d", h);
    
    int r1 = arc4random();
    NSLog(@"R1 : %d", r1);
    int r2 = arc4random();
    NSLog(@"R1 : %d", r2);

    NSLog(@"TEMP1 : %d", r1 % w);
    NSLog(@"TEMP2 : %d", r2 % w);
    
    CGFloat x = (r1 % w) + heartWidth / 2;
    CGFloat y = (r2 % h) + heartHeight / 2;
    
    NSLog(@"X : %f", x);
    NSLog(@"Y : %f", y);
    
    _heartImage.center = CGPointMake(x, y);

}
@end
