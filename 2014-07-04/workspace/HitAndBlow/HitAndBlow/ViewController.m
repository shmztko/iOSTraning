//
//  ViewController.m
//  HitAndBlow
//
//  Created by student on 2014/07/04.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSString *answer;
}

@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UITextView *resultText;


- (IBAction)sendAnswer:(UIButton *)sender;
- (IBAction)reset:(UIButton *)sender;
- (IBAction)viewTapped:(UITapGestureRecognizer *)sender;

@end

@implementation ViewController

const int ANSWER_DIGIT = 4;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _answerTextField.delegate = self;

    answer = [self generateAnswer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendAnswer:(UIButton *)sender {
    NSString *givenAnswer = _answerTextField.text;
    NSLog(@"%@", givenAnswer);
    
    if (givenAnswer.length < ANSWER_DIGIT) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"４桁の数字を入れて下さい" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        return;
    }
    
    NSDictionary *result = [self getHitBlowResult:givenAnswer];
    
    NSMutableString *editableText = [_resultText.text mutableCopy];
    if ([result[@"hitCount"] isEqualToString:[NSString stringWithFormat: @"%d", ANSWER_DIGIT]]) {
        [editableText appendString:[NSString stringWithFormat:@"Your answer %@ is correct!!\n", givenAnswer]];
        answer = [self generateAnswer];
    } else {
        [editableText appendString:[NSString stringWithFormat:@"%@ (Hit : %@, Blow : %@)\n", givenAnswer, result[@"hitCount"], result[@"blowCount"]]];
    }
    _resultText.text = editableText;
    _answerTextField.text = @"";
}

- (IBAction)reset:(UIButton *)sender {
    _resultText.text = @"";
    _answerTextField.text = @"";
    answer = [self generateAnswer];
}


- (NSString *) generateAnswer {
    NSMutableString *generatedAnswer = [NSMutableString string];
    int i = 0;
    while (i < ANSWER_DIGIT) {
        NSString *digitValue = [NSString stringWithFormat:@"%d", arc4random() % 10];
        if ([self contains:generatedAnswer Includes:digitValue] == NO) {
            [generatedAnswer appendString:digitValue];
            i++;
        }

    }
    NSLog(@"Answer is %@", generatedAnswer);
    return generatedAnswer;
}

- (NSDictionary *) getHitBlowResult:(NSString *) givenAnswer {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSInteger hitCount = 0;
    NSInteger blowCount = 0;
    for (int i = 0; i < answer.length; i++) {
        NSString *ansChar = [self getChar:answer At:i];
        NSLog(@"------------------------");
        NSLog(@"i[%d] : %@", i, ansChar);

        NSString *givenAnsChar = [self getChar:givenAnswer At:i];
        NSLog(@"j[%d] : %@", i, givenAnsChar);

        uint charLocation = [answer rangeOfString:givenAnsChar].location;
        if(charLocation == i) {
            NSLog(@"Hit!!");
            hitCount++;
        } else if (charLocation != NSNotFound) {
            NSLog(@"Blow!! ->%u", charLocation);
            blowCount++;
        } else {
            // Noop
        }
    }
    [result setObject:[NSString stringWithFormat:@"%d", hitCount] forKey:@"hitCount"];
    [result setObject:[NSString stringWithFormat:@"%d", blowCount] forKey:@"blowCount"];
    
    return result;
}

- (IBAction)viewTapped:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString *editingValue = [textField.text mutableCopy];
    [editingValue replaceCharactersInRange:range withString:string];
    
    return editingValue.length <= 4;
}

- (NSString *) getChar:(NSString *)value At:(int) index {
    return [value substringWithRange:NSMakeRange(index, 1)];
}

- (BOOL) contains:(NSString *)value Includes:(NSString *) part {
    return [value rangeOfString:part].location != NSNotFound;
}

@end
