//
//  CatCalcViewController.m
//  CatAgeCalcurator
//
//  Created by student on 2014/07/03.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "CatCalcViewController.h"

@interface CatCalcViewController ()
- (IBAction)catAgeChanged:(UITextField *)sender;
- (IBAction)calcButtonTaped:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *inputCatAge;
@property (weak, nonatomic) IBOutlet UILabel *humanAgeLabel;
- (IBAction)viewTapped:(UITapGestureRecognizer *)sender;

@end

@implementation CatCalcViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.inputCatAge.delegate = self;
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)catAgeChanged:(UITextField *)sender {
    int humanAge = [self catAgeToHumanAge: sender.text.intValue];
    _humanAgeLabel.text = [self getHumanAgeString:humanAge];
}

- (IBAction)calcButtonTaped:(UIButton *)sender {
    int humanAge = [self catAgeToHumanAge: _inputCatAge.text.intValue];
    _humanAgeLabel.text = [self getHumanAgeString:humanAge];

}

- (NSString *) getHumanAgeString:(int) humanAge {
    NSLog(@"Human age is %d", humanAge);
    if (humanAge >= 120) {
        return [NSString stringWithFormat:@"死亡(享年 %d歳)", humanAge];
    } else {
        return [NSString stringWithFormat:@"%d歳", humanAge];
    }
}

- (int) catAgeToHumanAge:(int)catAge {
    if (catAge <= 1) {
        return 20 * catAge;
    } else if (catAge <= 5) {
        return catAge * 6 + 15;
    } else if (catAge <= 10) {
        return catAge * 5 + 20;
    } else if (catAge <= 15) {
        return catAge * 4 + 30;
    } else {
        return catAge * 3 + 45;
    }
}
- (BOOL) textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString *editingValue = [_inputCatAge.text mutableCopy];
    [editingValue replaceCharactersInRange:range withString:string];
    
    return [editingValue intValue] <= 100 && [editingValue length] <= 4;
}

- (IBAction)viewTapped:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}
@end
