//
//  ViewController.m
//  SandBox
//
//  Created by student on 2014/07/29.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSMutableData *imageData;
    long imageDataLength;
}
- (void) startDownload:(NSString *) urlString;
@property (weak, nonatomic) IBOutlet UITextField *nameInput;

@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *urlInput;
- (IBAction)donwloadImageHandler:(id)sender;
- (IBAction)downloadTextHandler:(id)sender;

- (IBAction)viewTapped:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    imageData = [[NSMutableData alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)donwloadImageHandler:(id)sender {
    [self startDownload:_urlInput.text];
    //    NSData *data = [self openLinkByNSConnection];
//    UIImage *image = [UIImage imageWithData:data];
//    _imageView.image = image;
}

- (IBAction)downloadTextHandler:(id)sender {
    [self downloadByNSURLSession: _urlInput.text];
    //    NSData *data = [self openLinkByNSConnection];
//    NSString *text = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
//    _textView.text = text;
}


- (void) downloadByNSURLSession:(NSString *) urlString {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];

    NSString *parameterizedUrl = [NSString stringWithFormat:@"%@?%@=%@", urlString, @"name", _nameInput.text];
    
    NSURL *url = [NSURL URLWithString:parameterizedUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"Got response %@ with error %@", response, error);
        NSString *recievedData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        _textView.text = recievedData;
        
    }];
    [task resume];
}

- (void) startDownload:(NSString *) urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [imageData setLength:0];
    [connection start];
}


- (void) openTextByNSURL {
    NSURL *url = [NSURL URLWithString:_urlInput.text];
    NSError *error = nil;
    NSString *text = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"%@", error);
    _textView.text = text;
}

- (void) openImageByNSURL {
    NSURL *url = [NSURL URLWithString:_urlInput.text];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    _imageView.image = image;
}

- (NSData *) openLinkByNSConnection {
    NSURL *url = [NSURL URLWithString:_urlInput.text];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSHTTPURLResponse *response;
    NSError *error = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error
    ];
    if (data != NULL && response.statusCode == 200) {
        return data;
        
    } else {
        NSLog(@"Failed! error:%@ status:%ld", error, (long)response.statusCode);
        return nil;
    }
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode != 200) {
        NSLog(@"Error. %ld", (long)httpResponse.statusCode);
    } else {
        NSLog(@"Success.");
    }
    imageDataLength = (int)[response expectedContentLength];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [imageData appendData:data];
    
    _progressLabel.text = [NSString stringWithFormat:@"Loading %d/%ld", [imageData length], imageDataLength];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    _progressLabel.text = @"Download complete.";
    _imageView.image = [UIImage imageWithData:imageData];
}

- (IBAction)viewTapped:(id)sender {
    [self.view endEditing:YES];
}
@end
