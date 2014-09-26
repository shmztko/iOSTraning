//
//  ViewController.m
//  Yubin
//
//  Created by zabaglione on 2014/09/21.
//  Copyright (c) 2014年 zabaglione. All rights reserved.
//

#import "ViewController.h"
#import "Yubin.h"

@interface ViewController ()

@property (strong, nonatomic) Yubin *yubin;

@property (weak, nonatomic) IBOutlet UITextField *postalCode;
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;

- (IBAction)bntFind:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.yubin = [[Yubin alloc] initWithCSVFileName:@"13TOKYO"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bntFind:(id)sender {
    NSArray *addresses = [self.yubin containsThePostalCode: self.postalCode.text];
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSURL *docsDirURL = [fileManger URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
    
    NSURL *fileUrl = [NSURL URLWithString:@"found.plist" relativeToURL:docsDirURL];
    
    [addresses writeToURL:fileUrl atomically:YES];
    

    
    NSMutableString *resultText = [[NSMutableString alloc ]init];
    for (NSDictionary *data in addresses) {
        NSString *text = [NSString stringWithFormat:@"%@ : %@%@%@", data[@"PostalCode"], data[@"Address1"], data[@"Address2"], data[@"Address3"]];
        NSLog(@"%@", text);
        [resultText appendString:text];
        [resultText appendString:@"\n"];
    }
    self.resultTextView.text = resultText;
}
@end
