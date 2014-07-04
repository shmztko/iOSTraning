//
//  ViewController.h
//  BMI
//
//  Created by zabaglione on 2013/05/23.
//  Copyright (c) 2013年 student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    UISlider *heightSlider;
    UISlider *weightSlider;

    UILabel *heightLabel;
    UILabel *weightLabel;

    UILabel *bmiLabel;

    CGFloat height;
    CGFloat weight;
    CGFloat bmi;
    NSString *result;
}

@property (strong, nonatomic)UISlider *heightSlider;
@property (strong, nonatomic)UISlider *weightSlider;

@property (strong, nonatomic)UILabel *heightLabel;
@property (strong, nonatomic)UILabel *weightLabel;

@property (strong, nonatomic)UILabel *bmiLabel;

@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat weight;
@property (nonatomic) CGFloat bmi;
@property (strong, nonatomic) NSString *result;


- (void) configureView;
- (void) configureViewIPhone;
- (void) configureViewIPad;
- (void) action:(id)sender;
- (void) calcBMI;
- (void) viewValues;

@end
