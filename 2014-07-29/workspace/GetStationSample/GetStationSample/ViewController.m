//
//  ViewController.m
//  GetStationSample
//
//  Created by student on 2014/07/29.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
}

- (IBAction)executeRequset:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *xLocationInput;
@property (weak, nonatomic) IBOutlet UITextField *yLocationInput;
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;
- (IBAction)clearResultView:(id)sender;
- (IBAction)viewTapped:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)executeRequset:(id)sender {
    [self loadStationsWithXLocation:_xLocationInput.text andYLocation:_yLocationInput.text];
}

- (void) loadStationsWithXLocation:(NSString *) xLocation andYLocation:(NSString *) yLocation {
    NSString *parameterizedUrlString = [NSString stringWithFormat:@"http://express.heartrails.com/api/json?method=getStations&x=%@&y=%@", xLocation, yLocation];
    NSURL *url = [NSURL URLWithString:parameterizedUrlString];

    [self getRequestWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError = nil;
        NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
       [self setResultText: jsonResult[@"response"][@"station"]];
    }];
}

- (void)getRequestWithURL:(NSURL *)url completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:completionHandler];
    [task resume];
}

- (void) setResultText:(NSArray *) stations {
    NSMutableString *stationText = [_resultTextView.text mutableCopy];
    [stationText appendString:@"--------------------------\n"];
    for (int i = 0; i < stations.count; i++) {
        [stationText appendString: [NSString stringWithFormat:@"Area[%d] Prefecture : %@, Name : %@, Line : %@ \n", i, stations[i][@"prefecture"]
                                    , stations[i][@"name"], stations[i][@"line"]]];
    }
    _resultTextView.text = stationText;
}

- (IBAction)clearResultView:(id)sender {
    _resultTextView.text = @"";
}

- (IBAction)viewTapped:(id)sender {
    [self.view endEditing:YES];
}
@end
