//
//  Person.m
//  testapp
//
//  Created by student on 2014/09/25.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "XYZPerson.h"

//--- クラス拡張　(匿名カテゴリ)
// カテゴリとは違い、自分がソースコードを所有する場合に可能。
// ヘッダファイルに記述したプロパティ・メソッドはパブリックになるが、クラス拡張部分に記述したものはプロテクテッドになる？
@interface XYZPerson()
@property(readwrite) NSString *personId;
@property(readwrite) int weight;
@property(readwrite) int height;
@end

@implementation XYZPerson

- (void) measureHeight
{
    self.height = 100 + arc4random() % 200;
}
- (void) measureWeight
{
    self.weight = 30 + arc4random() % 100;
}


- (id) init
{
    return [self initWithLastName:@"-" andFirstName:@"-" andBirthday:nil];
}

- (id) initWithLastName:(NSString *) lastName andFirstName:(NSString *) firstName
{
    return [self initWithLastName:lastName andFirstName:firstName andBirthday:nil];
}

/**
 * 特命初期化メソッド
 * すべてのプロパティに対する初期値の設定を行うメソッド
 */
- (id) initWithLastName:(NSString *) lastName andFirstName:(NSString *)firstName andBirthday:(NSDate *) birthday
{
    self = [super init];
    if (self) {
        _lastName = [lastName copy];
        _firstName = [firstName copy];
        _birthday = [birthday copy];
    }
    return self;
}

+ (id) person
{
    return [[self alloc] init];
}

+ (id) personWithLastName:(NSString *) lastName andFirstName:(NSString *) firstName
{
    return [[self alloc] initWithLastName:lastName andFirstName:firstName];
}

+ (id) personWithLastName:(NSString *) lastName andFirstName:(NSString *) firstName andBirthday:(NSDate *) birthday
{
    return [[self alloc] initWithLastName:lastName andFirstName:firstName andBirthday:birthday];
}

- (NSString *) fullName
{
    return [NSString stringWithFormat:@"%@ %@", self.lastName, self.firstName];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ (%@)", self.fullName, self.birthday];
}

- (void) sayHello
{
    NSLog(@"%@", [self getGreeting]);
}

- (NSString *) getGreeting
{
    return [NSString stringWithFormat:@"Hello!! my name is %@. (%@)", self, self.partner];
}

- (void) dealloc
{
    NSLog(@"%@ is being deallocated", self);
}

@end
