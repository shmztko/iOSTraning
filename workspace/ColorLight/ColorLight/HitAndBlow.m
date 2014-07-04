//
//  HitAndBlow.m
//  ColorLight
//
//  Created by student on 2014/07/02.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "HitAndBlow.h"

@implementation HitAndBlow

const int ANSWER_DIGIT = 4;

NSArray *answer;

- (void) generateAnswer
{
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < ANSWER_DIGIT; i++) {
//        [self getRandInt:0 max:10].get
//        [result addObject:];
    }
}

- (NSInteger)getRandInt:(int)min max:(int)max {
	static int randInitFlag;
	if (randInitFlag == 0) {
		srand(time(NULL));
		randInitFlag = 1;
	}
	return min + (int)(rand()*(max-min+1.0)/(1.0+RAND_MAX));
}

@end
