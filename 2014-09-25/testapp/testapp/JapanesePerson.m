//
//  JapanesePerson.m
//  testapp
//
//  Created by student on 2014/09/25.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "JapanesePerson.h"

@implementation JapanesePerson
- (NSString *) getGreeting
{
    return [NSString stringWithFormat:@"こんにちわ！！ 私の名前は %@ です。", self];
}
@end
