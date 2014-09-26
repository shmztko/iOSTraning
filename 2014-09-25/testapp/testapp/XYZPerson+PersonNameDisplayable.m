//
//  XYZPerson+PersonNameDisplayable.m
//  testapp
//
//  Created by student on 2014/09/26.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "XYZPerson+PersonNameDisplayable.h"

@implementation XYZPerson (PersonNameDisplayable)
- (NSString *) getFullNameInJapaneseOrder
{
    return [NSString stringWithFormat:@"%@ %@", self.lastName, self.firstName];
}
- (NSString *) getFullNameInEnglishOrder
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}
@end
