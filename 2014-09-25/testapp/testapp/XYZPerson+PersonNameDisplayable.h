//
//  XYZPerson+PersonNameDisplayable.h
//  testapp
//
//  Created by student on 2014/09/26.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "XYZPerson.h"

@interface XYZPerson (PersonNameDisplayable)
/**
 * クラスメソッドでも、インスタンスメソッドでも追加可能。
 * インスタンス変数の追加はできない。
 */
- (NSString *) getFullNameInJapaneseOrder;
@end
