//
//  ViewController.m
//  BMI2
//
//  Created by student on 2014/06/03.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *bmiLabel;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UISlider *heightSilder;
@property (weak, nonatomic) IBOutlet UISlider *weightSlider;

- (IBAction)changeSlider:(id)sender;

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

- (IBAction)changeSlider:(id)sender {
    _heightLabel.text = [NSString stringWithFormat:@"%.1fcm",_heightSilder.value];
    _weightLabel.text = [NSString stringWithFormat:@"%.1fKg",_weightSlider.value];
    [self calcBMI];
}

- (void)calcBMI
{
    float weight = _weightSlider.value;
    float height = _heightSilder.value / 100.0;
    float bmi = weight / (height * height);

    NSLog(@"weight=%.1f, height=%.1f, bmi=%.1f", weight, height, bmi);
    
    // 判定
    NSString *result;
    if (bmi < 18.5) {
        result = @"やせ過ぎ";
    } else if (bmi < 25.0) {
        result = @"普通体重";
    } else {
        result = @"太り過ぎ";
    }
    
    NSString *bmiString = [NSString stringWithFormat:@"BMI:%.1f(%@)", bmi, result];
    _bmiLabel.text = bmiString;
}

@end
