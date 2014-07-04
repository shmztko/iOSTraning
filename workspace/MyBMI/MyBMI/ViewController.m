//
//  ViewController.m
//  MyBMI
//
//  Created by student on 2014/07/02.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)heightSliderChanged:(UISlider *)sender;
- (IBAction)weightSliderChanged:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISlider *heightSlider;
@property (weak, nonatomic) IBOutlet UISlider *weightSlider;
@property (weak, nonatomic) IBOutlet UILabel *bmiResult;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.heightTextField.delegate = self;
    
    [self applyHeightValue:_heightSlider.value];
    [self applyWeightValue:_weightSlider.value];
    _bmiResult.text =[self getBMI:_heightSlider.value weight:_weightSlider.value];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)heightSliderChanged:(UISlider *)sender {
    [self applyHeightValue:sender.value];
    _bmiResult.text =[self getBMI:sender.value weight:_weightSlider.value];
}

- (IBAction)weightSliderChanged:(UISlider *)sender {
    [self applyWeightValue:sender.value];
    _bmiResult.text = [self getBMI:_heightSlider.value weight:sender.value];
}

- (void) applyWeightValue:(float) weight {
    _weightLabel.text = [NSString stringWithFormat:@"%.1f kg", weight];
}

- (void) applyHeightValue:(float) height {
    _heightLabel.text = [NSString stringWithFormat:@"%.1f cm", height * 100];
}

- (NSString *) getBMI:(float) height weight:(float) weight {
    float bmi = weight / (height * height);
    NSLog(@"H:%.1f, W:%.1f, BMI -> %.1f", height, weight, bmi);
    if (bmi < 18.5) {
        return [NSString stringWithFormat: @"デブ レベル1 の BMI は %.1f", bmi];
    } else if(bmi < 25) {
        return [NSString stringWithFormat: @"デブ レベル2 の BMI は %.1f", bmi];
    } else if(bmi < 25) {
        return [NSString stringWithFormat: @"デブ レベル3 の BMI は %.1f", bmi];
    } else if(bmi < 30) {
        return [NSString stringWithFormat: @"デブ レベル4 の BMI は %.1f", bmi];
    } else if(bmi < 35) {
        return [NSString stringWithFormat: @"デブ レベル5 の BMI は %.1f", bmi];
    } else if(bmi < 40) {
        return [NSString stringWithFormat: @"デブ レベル6 の BMI は %.1f", bmi];
    } else {
        return [NSString stringWithFormat: @"デブ レベル最大 の BMI は %.1f", bmi];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    float inputHeight = textField.text.floatValue / 100;
    _heightSlider.value = inputHeight;
    [self applyHeightValue: inputHeight];
    
    [textField resignFirstResponder];
    return YES;
}

@end
