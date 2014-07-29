//
//  ViewController.m
//  UserDefaultSample
//
//  Created by student on 2014/07/04.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch2;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch1;
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
- (IBAction)valueChanged:(id)sender;

- (IBAction)viewTapped:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewWillAppear:(BOOL)animated {
    [self restoreDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void) initialize {
    NSMutableDictionary *appDefaults = [NSMutableDictionary dictionary];
    [appDefaults setValue:@"これは口です" forKey:@"mytext"];
    [appDefaults setValue:@"1.0" forKey:@"myslider"];
    [appDefaults setValue:@"YES" forKey:@"myswitch1"];
    [appDefaults setValue:@"NO" forKey:@"myswitch2"];
    NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
    [myDefaults registerDefaults:appDefaults];
    
}

- (void) restoreDefault {
    NSLog(@"読み込んだらあああああ");
    NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
    _myTextField.text = [myDefaults objectForKey:@"mytext"];
    _mySlider.value = [myDefaults floatForKey:@"myslider"];
    _mySwitch1.on = [myDefaults boolForKey:@"myswitch1"];
    _mySwitch2.on = [myDefaults boolForKey:@"myswitch2"];
}

- (void) saveDefault {
    NSLog(@"ほぞんんんんされたらああああああああ");
    NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
    [myDefaults setObject:_myTextField.text forKey:@"mytext"];
    [myDefaults setFloat:_mySlider.value forKey:@"myslider"];
    [myDefaults setBool:_mySwitch1.on forKey:@"myswitch1"];
    [myDefaults setBool:_mySwitch2.on forKey:@"myswitch2"];
    [myDefaults synchronize];
}


- (IBAction)valueChanged:(id)sender {
    [self saveDefault];
}

- (IBAction)viewTapped:(id)sender {
    [self.view endEditing:YES];
}
@end
