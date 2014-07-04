//
//  ViewController.m
//  SandBox
//
//  Created by student on 2014/07/03.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    UIImageView *house;
}
@property (weak, nonatomic) IBOutlet UIView *container;

- (IBAction)createHouse:(UIButton *)sender;
- (IBAction)moveHousePoint:(UISegmentedControl *)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImage *houseImage = [UIImage imageNamed:@"house.png"];
    
    house = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, houseImage.size.width, houseImage.size.height)];
    house.image = houseImage;
    house.contentMode = UIViewContentModeTopLeft;
    house.center = _container.center;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createHouse:(UIButton *)sender {

    UIActionSheet *sheet = [[UIActionSheet alloc]
            initWithTitle:@"選択してください"
            delegate:nil
            cancelButtonTitle:@"キャンセル"
            destructiveButtonTitle:nil otherButtonTitles:@"A", @"B", @"C", nil];
    
    
    
    if ([house isDescendantOfView: _container]) {
        NSLog(@"hide");
        [house removeFromSuperview];
    } else {
        NSLog(@"show");
        [_container insertSubview:house atIndex:1];
    }

}

- (IBAction)moveHousePoint:(UISegmentedControl *)sender {
    
    NSInteger selectedIndex = sender.selectedSegmentIndex;
    if  (selectedIndex == 0) {
        house.center = CGPointMake(sender.superview.center.x, 5);
    } else if  (selectedIndex == 0) {
        house.center = CGPointMake(sender.superview.center.x, 25);
    } else if  (selectedIndex == 0) {
        house.center = CGPointMake(sender.superview.center.x, 50);
    } else {
        NSLog(@"ERROR");
    }
}
@end
