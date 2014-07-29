//
//  KadoMaruButton.m
//  DragonFlyCatcher
//
//  Created by student on 2014/07/03.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "KadoMaruButton.h"

@implementation KadoMaruButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame label:(NSString *)title bkgColor:(UIColor *) rgba {
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:title forState:UIControlStateNormal];
        self.backgroundColor = rgba;
        
        [self.layer setCornerRadius:10.0];
        [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
