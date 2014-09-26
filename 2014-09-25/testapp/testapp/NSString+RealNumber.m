//
//  NSString+RealNumber.m
//  testapp
//
//  Created by student on 2014/09/26.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "NSString+RealNumber.h"

@implementation NSString (RealNumber)
- (double)realValue {
    return [self doubleValue];
}
@end
