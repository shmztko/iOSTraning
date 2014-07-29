//
//  ViewController.m
//  FileIOSample
//
//  Created by student on 2014/07/04.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    CGRect originalFrame;
}
- (IBAction)editDone:(id)sender;
- (IBAction)editCancel:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self loadFile];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
}

- (void) viewDidAppear:(BOOL)animated {
    originalFrame = _myTextView.frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    // 画面の正面向きだけを許可する
    return UIInterfaceOrientationMaskPortrait;
}


- (IBAction)editDone:(id)sender {
    [self saveFile];
    [self.view endEditing:YES];
}

- (IBAction)editCancel:(id)sender {
    [self loadFile];
    [self.view endEditing:YES];
}

- (void) saveFile {
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/note.txt"];
    [_myTextView.text writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void) loadFile {
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/note.txt"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        _myTextView.text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    } else {
        NSLog(@"ファイルがありません");
        _myTextView.text = nil;
    }
}

- (void) keyboardDidShow:(NSNotification *) notification {
    NSLog(@"KeyBoardSHow");
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect textViewFrame = _myTextView.frame;
    textViewFrame.size.height = originalFrame.size.height - keyboardFrame.size.height;
    _myTextView.frame = textViewFrame;
}

- (void) keyboardDidHide:(NSNotification *) notification {
    NSLog(@"KeyBoardHide");
    _myTextView.frame = originalFrame;
}

@end
