//
//  ViewController.m
//  AlertSample
//
//  Created by student on 2014/07/03.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    int counter;
}
- (IBAction)handleButtonClicked:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    counter = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleButtonClicked:(UIButton *)sender {
    [self showAlert: @"てきがあらわれた！！"];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (counter > 3) {
        if (alertView.alertViewStyle == UIAlertViewStylePlainTextInput) {
            NSString *creditcardNumber = [alertView textFieldAtIndex:0].text;
            if ([creditcardNumber isEqualToString:@""] == false) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"１０万円の買い物を実行しました。"
                                      message:nil
                                      delegate:nil
                                      cancelButtonTitle:nil
                                      otherButtonTitles:@"OK", nil];
                counter = 0;
                [alert show];
            } else {
                [self showCreditCardInputAlert];
            }
        } else {
            [self showCreditCardInputAlert];
        }

    } else {
        [self showActionSheet];
    }

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self showAlert: @"しかしまわりこまれてしまった！！"];
}

- (void) showAlert:(NSString *) message {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:message
                          message:nil
                          delegate:self
                          cancelButtonTitle:@"にげる"
                          otherButtonTitles:@"たたかう", nil];
    counter++;
    [alert show];
}

- (void) showActionSheet {
    UIActionSheet *sheet = [[UIActionSheet alloc]
                            initWithTitle:@"しかしまわりこまれてしまった！！"
                            delegate:self
                            cancelButtonTitle:@"にげる"
                            destructiveButtonTitle:@"じばくする"
                            otherButtonTitles:@"たたかう", nil];
    [sheet showInView:self.view];
}

- (void) showCreditCardInputAlert {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"クレジットカード番号入力"
                          message:@"レジットカード番号を入力するとループから抜け出すことができます。"
                          delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"確定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

@end
