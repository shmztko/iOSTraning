//
//  Yubin.m
//  Yubin
//
//  Created by zabaglione on 2014/09/21.
//  Copyright (c) 2014年 zabaglione. All rights reserved.
//

#import "Yubin.h"

@implementation Yubin

- (id)initWithCSVFileName:(NSString *)csvFileName;
{
    self = [super init];
    
    if (self) {
        
        // 参考: http://snippets.feb19.jp/?p=942
        // CSVファイルからセクションデータを取得する
        NSString *csvFile = [[NSBundle mainBundle] pathForResource:csvFileName ofType:@"CSV"];
        NSData *csvData = [NSData dataWithContentsOfFile:csvFile];
        NSString *csv = [[NSString alloc] initWithData:csvData encoding:NSUTF8StringEncoding];
        
        NSScanner *scanner = [NSScanner scannerWithString:csv];
        // 改行文字の選定
        NSCharacterSet *chSet = [NSCharacterSet newlineCharacterSet];
        NSString *line;
        
        // レコードを入れる NSMutableArray
        NSMutableArray *row = [NSMutableArray array];
        
        while (![scanner isAtEnd]) {
            // 一行づつ読み込んでいく
            [scanner scanUpToCharactersFromSet:chSet intoString:&line];
            // "(ダブルコーテーション)を削除する(課題)
            line = [line stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            // ,(カンマ)で区切り、配列に格納する
            NSArray *array = [line componentsSeparatedByString:@","];
            [row addObject:array];
            
            // 改行文字をスキップ
            [scanner scanCharactersFromSet:chSet intoString:NULL];
        }
        yubinData = row;
    }
    return self;
}

// 郵便番号(部分一致)から住所(NSDictonary)の配列(NSArray)を取得
- (NSArray *)containsThePostalCode:(NSString *)postalCode
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"PostalCode" ascending:YES];
    NSArray *sortArray = [NSArray arrayWithObject:sortDescriptor];
    NSMutableArray *ret = [NSMutableArray array];
    // 全住所を検索
    for (NSArray *rowData in yubinData) {
        // 郵便番号の部分一致検索を行う
        NSRange range = [rowData[2] rangeOfString:postalCode];
        if (range.location != NSNotFound) {
            // 部分一致したデータから必要なところだけ抜き出す
            NSDictionary *data = @{@"PostalCode":rowData[2], @"Address1":rowData[6], @"Address2":rowData[7], @"Address3":rowData[8]};
            [ret addObject:data];
        }
    }
    return [ret sortedArrayUsingDescriptors:sortArray];
}

@end
