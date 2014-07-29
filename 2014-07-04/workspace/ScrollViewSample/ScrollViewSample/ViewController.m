//
//  ViewController.m
//  ScrollViewSample
//
//  Created by student on 2014/07/04.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _myScrollView.delegate = self;
    _myScrollView.minimumZoomScale = 1;
    _myScrollView.maximumZoomScale = 10;
    
    _myScrollView.scrollEnabled = YES;
    _myScrollView.showsHorizontalScrollIndicator = YES;
    _myScrollView.showsVerticalScrollIndicator = YES;
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    _myImageView.userInteractionEnabled = YES;
    [_myImageView addGestureRecognizer:doubleTapGesture];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _myImageView;
}

- (void) doubleTap:(UIGestureRecognizer *) gesture {
    if (_myScrollView.zoomScale < _myScrollView.maximumZoomScale) {
        float newScale = _myScrollView.zoomScale * 3;
        CGRect zoomedRect = [self zoomRectForScale:newScale withCenter:[gesture locationInView:gesture.view]];
        [_myScrollView zoomToRect:zoomedRect animated:YES];
    } else {
        [_myScrollView setZoomScale:1.0 animated:YES];
    }
}

- (CGRect) zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    CGRect zoomedRect;
    zoomedRect.size.height = [_myScrollView frame].size.height / scale ;
    zoomedRect.size.width = [_myScrollView frame].size.width / scale ;
    zoomedRect.origin.x = center.x - (zoomedRect.size.width / 2.0);
    zoomedRect.origin.y = center.y - (zoomedRect.size.height / 2.0);
    return zoomedRect;
}


@end
