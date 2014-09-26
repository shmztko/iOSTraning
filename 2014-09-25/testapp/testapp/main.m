//
//  main.m
//  testapp
//
//  Created by student on 2014/09/25.
//  Copyright (c) 2014年 student. All rights reserved.
//

// import と include の違い
// import -> 二重読み込み防止機能が追加されている、プリコンパイル済みヘッダが利用可能
// include -> 二重読み込み防止は自身でコードを記述する必要あり
#import <Foundation/Foundation.h>
#import "XYZPerson.h"
#import "XYZPerson+PersonNameDisplayable.h"
#import "JapanesePerson.h"
#import "NSString+SuperNSString.h"
#import "NSString+RealNumber.h"
#import "ShopFinder.h"
/**
 * Objective-c 用コマンドラインプログラムのスタートポイント
 * - int argc : 引数の数
 * - char argv[] : コマンドライン引数。0番目には必ず実行されたプログラムのパスが含まれる
 */
int main(int argc, const char * argv[])
{

    
   return 0;
}

void findCurryShop() {
    ShopFinder *finder = [[ShopFinder alloc] init];
    
    for (NSDictionary *shop in [finder findShop:@"カレー"]) {
        NSLog(@"%@", shop[@"name"]);
    }
}

void nooo() {
    NSString *value = @"1.41421356";
    
    NSLog(@"%.10f", value.realValue);
    
}

void foo() {
    XYZPerson *person = [XYZPerson personWithLastName:@"清水" andFirstName:@"エスパルス"];
    NSLog(@"%@", [person getFullNameInJapaneseOrder]);
    
    NSLog(@"H:%d W:%d", person.height, person.weight);
    
    
    [person measureWeight];
    [person measureHeight];
    
    NSLog(@"H:%d W:%d", person.height, person.weight);
    
    
    NSString *value = @"hoge";
    
    [value showSuperString];
}

void fuga() {
    @autoreleasepool {
        XYZPerson *husband = [XYZPerson personWithLastName:@"shimizu" andFirstName:@"takeo"];
        XYZPerson *wife = [XYZPerson personWithLastName:@"shimizu" andFirstName:@"mami"];
        husband.partner = wife;
        wife.partner = husband;
        
        [husband sayHello];
        wife.lastName = @"yoshizawa";
        
        husband.partner = nil;
        
        [husband sayHello];
    }
}

void hoge(int argc, const char * argv[]) {
    @autoreleasepool {
        
        XYZPerson *person7 = [XYZPerson personWithLastName:@"ふが" andFirstName:@"ふが"];
        XYZPerson __weak *person6 = [XYZPerson personWithLastName:@"ほげ" andFirstName:@"ほげ"];
        
        [person7 sayHello];
        [person6 sayHello];
        
        for (int i = 0; i < argc; i++) {
            const char *hoge = argv[i];
            NSLog(@"argument %d is %s", i, hoge);
        }
    }
}



void test(int argc, const char * argv[]) {
    NSLog(@"Hello, World! %d", argc);
    
    for (int i = 0; i < argc; i++) {
        const char *hoge = argv[i];
        NSLog(@"argument %d is %s", i, hoge);
    }
    
    XYZPerson *person = [[XYZPerson alloc] init];
    person.lastName = @"清水";
    person.firstName = @"威夫";
    [person sayHello];
    
    NSDate *birth = [NSDate dateWithString:@"1985-09-08 00:00:00 +0000"];
    XYZPerson *person2 = [XYZPerson personWithLastName:@"清" andFirstName:@"たけお" andBirthday:birth];
    [person2 sayHello];
    
    XYZPerson *person3 = [XYZPerson person];
    [person3 sayHello];
    
    XYZPerson *person4 = [JapanesePerson personWithLastName:@"shimizu" andFirstName:@"takeo"];
    [person4 sayHello];
    
    XYZPerson *nilPerson;
    NSLog(@"%@", nilPerson);
    
    NSMutableString *editableLastName = [NSMutableString stringWithString:@"shimizu"];
    XYZPerson *person5 = [XYZPerson personWithLastName:editableLastName andFirstName:@"たけお" andBirthday:birth];
    person5.lastName = editableLastName;
    [person5 sayHello];
    [editableLastName appendString:@"ほげ"];
    [person5 sayHello];
}
