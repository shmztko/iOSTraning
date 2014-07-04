//
//  ViewController.m
//  BMI
//
//  Created by zabaglione on 2013/05/23.
//  Copyright (c) 2013年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize heightSlider = heightSlider;
@synthesize weightSlider = weightSlider;

@synthesize heightLabel = heightLabel;
@synthesize weightLabel = weightLabel;

@synthesize bmiLabel = bmiLabel;

@synthesize height = height;
@synthesize weight = weight;
@synthesize bmi = bmi;
@synthesize result = result;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Viewの初期化
    [self configureView];
    
    // BMIの計算
    [self calcBMI];
    
    // 身長、体重、BMIの表示
    [self viewValues];
}

- (void) configureView
{
    // iPhoneとiPadで表示位置を調整する
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self configureViewIPhone];
    } else {
        [self configureViewIPad];
    }
    
    // 身長と体重の初期値を設定
    height = 165.0f;
    weight = 60.0;

    // iPhone、iPad共通処理
    // 身長のスライダー
    heightSlider.minimumValue = 140.0f;
    heightSlider.maximumValue = 200.0f;
    heightSlider.value = height;
    [heightSlider addTarget:self action:@selector(action:) forControlEvents:UIControlEventValueChanged];
    heightSlider.continuous = YES;
    heightSlider.tag = 1;
    [self.view addSubview:heightSlider];
    
    // 体重のスライダー
    weightSlider.minimumValue = 30.0f;
    weightSlider.maximumValue = 150.0f;
    weightSlider.value = weight;
    [weightSlider addTarget:self action:@selector(action:) forControlEvents:UIControlEventValueChanged];
    weightSlider.continuous = YES;
    weightSlider.tag = 2;
    [self.view addSubview:weightSlider];
    
    // 身長のラベル
    heightLabel.textColor = [UIColor blackColor];
    heightLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:heightLabel];
    
    // 体重のラベル
    weightLabel.textColor = [UIColor blackColor];
    weightLabel.text = @"cm";
    weightLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:weightLabel];
    
    // BMIのラベル
    bmiLabel.textColor = [UIColor blackColor];
    bmiLabel.text = @"bmi";
    bmiLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:bmiLabel];
}

// iPhone用の画面
- (void) configureViewIPhone
{
    // BMIのラベル
    bmiLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 60.0, 240.0, 40.0)];
    bmiLabel.font = [UIFont fontWithName:@"HirakakuProN-W6" size:18];

    // 身長のラベル
    heightLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 100.0, 240.0, 40.0)];
    heightLabel.font = [UIFont fontWithName:@"HirakakuProN-W6" size:18];

    // 身長のスライダー
    heightSlider = [[UISlider alloc] initWithFrame:CGRectMake(40.0, 135.0, 240.0, 40.0)];
    
    // 体重のラベル
    weightLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 190.0, 240.0, 40.0)];
    weightLabel.font = [UIFont fontWithName:@"HirakakuProN-W6" size:18];

    // 体重のスライダー
    weightSlider = [[UISlider alloc] initWithFrame:CGRectMake(40.0, 225.0, 240.0, 40.0)];
}

// iPad用の画面
- (void) configureViewIPad
{
    // BMIのラベル
    bmiLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 60.0, 680.0, 40.0)];
    bmiLabel.font = [UIFont fontWithName:@"HirakakuProN-W6" size:16];
    
    // 身長のラベル
    heightLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 100.0, 680.0, 40.0)];
    heightLabel.font = [UIFont fontWithName:@"HirakakuProN-W6" size:16];
    
    // 身長のスライダー
    heightSlider = [[UISlider alloc] initWithFrame:CGRectMake(40.0, 135.0, 680.0, 40.0)];
    
    // 体重のラベル
    weightLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 190.0, 680.0, 40.0)];
    weightLabel.font = [UIFont fontWithName:@"HirakakuProN-W6" size:16];
    
    // 体重のスライダー
    weightSlider = [[UISlider alloc] initWithFrame:CGRectMake(40.0, 225.0, 680.0, 40.0)];
}

- (void)action:(id)sender
{
    // senderの種別を調べる
    UISlider *slider = (UISlider *)sender;
    if (slider.tag == 1) {  // 身長のスライダー
        height = slider.value;
    } else {                // 体重のスライダー
        weight = slider.value;
    }

    // BMIの計算
    [self calcBMI];
    
    // 身長、体重、BMIの表示
    [self viewValues];
}

- (void)calcBMI
{
    // BMIの計算
    bmi = weight / (height * height / 10000);
    
    if (bmi < 18.5f) {
        result = @"低体重";
    } else if (bmi < 25.0f) {
        result = @"普通体重";
    } else if (bmi < 30.0f) {
        result = @"肥満(1度)";
    } else if (bmi < 35.0f) {
        result = @"肥満(2度)";
    } else if (bmi < 40.0f) {
        result = @"肥満(3度)";
    } else {
        result = @"肥満(4度)";
    }
    NSLog( @"bmi=%3.1f:%@", bmi, result );
}

- (void)viewValues
{
    // 身長、体重のラベルを更新
    heightLabel.text = [NSString stringWithFormat:@"%3.1fcm", height ];
    weightLabel.text = [NSString stringWithFormat:@"%3.1fKg", weight ];    

    // BMIの表示
    bmiLabel.text = [NSString stringWithFormat:@"BMI:%3.1f(%@)", bmi, result];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
