//
//  ViewController.m
//  ColorLight
//
//  Created by student on 2014/07/02.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "ViewController.h"
#import "HitAndBlow.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
@property (weak, nonatomic) IBOutlet UILabel *sliderValueLabel;
@property (weak, nonatomic) IBOutlet UITextField *answerInput;

- (IBAction)mySwitch:(UISwitch *)sender;
- (IBAction)handleSlider:(UISlider *)sender;
- (IBAction)handleClickAction:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    HitAndBlow *hb = [[HitAndBlow alloc] init];
//   [hb generateAnswer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mySwitch:(UISwitch *)sender {
}

- (IBAction)handleSlider:(UISlider *)sender {
    _sliderValueLabel.text = [NSString stringWithFormat:@"%.10f %%", sender.value];
}

- (IBAction)handleClickAction:(UIButton *)sender {
    const NSString *answer = @"1234";
    NSString *inputValue = _answerInput.text;
    
    NSLog(@"aa %@", self.answerInput.text);
    NSString *message;
    if ([answer isEqualToString:inputValue]) {
        message = [NSString stringWithFormat:@"Your input is Correct!!"];

    
    } else {
        message = [NSString stringWithFormat:@"Your input is Wrong -> %@", inputValue];
        
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

@end
