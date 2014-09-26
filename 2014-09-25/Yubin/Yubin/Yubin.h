//
//  Yubin.h
//  Yubin
//
//  Created by zabaglione on 2014/09/21.
//  Copyright (c) 2014年 zabaglione. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Yubin : NSObject
{
    NSMutableArray *yubinData;
}

- (id)initWithCSVFileName:(NSString *)csvFileName;

// 郵便番号(部分一致)から住所(NSDictonary)の配列(NSArray)を取得
// 住所情報
//      キー　    :  値
//   "PostalCode": 郵便番号
//   "Address1"  : 都道府県名
//   "Address2"  : 市区町村名
//   "Address3"  : 町域名
- (NSArray *)containsThePostalCode:(NSString *)postalCode;
   
@end
