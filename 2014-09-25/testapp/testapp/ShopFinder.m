//
//  ShopFinder.m
//  testapp
//
//  Created by student on 2014/09/26.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "ShopFinder.h"
@interface ShopFinder()
@end

@implementation ShopFinder

NSArray *shops;


- (id)init {
    self = [super init];
    
    NSDictionary *shop1 = @{
              @"name": @"旬菜庵さざめき",
              @"address": @"Osaka",
              @"phone": @"000-0123-4567",
              @"start": @18.5,
              @"end": @25.0
              };
    NSDictionary *shop2 = @{
              @"name": @"カレーのMy Great",
              @"address": @"Tokyo",
              @"phone": @"111-9876-5432",
              @"start": @10.0,
              @"end": @21.0
              };
    NSDictionary *shop3 = @{
              @"name": @"カレーハウス湊",
              @"address": @"Osaka",
              @"phone": @"000-5678-8765",
              @"start": @12.0,
              @"end": @22.0
              };
    shops = @[shop1, shop2, shop3];
    
    return self;
}

- (NSArray *) findShop:(NSString *)keyword
{
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *shop in shops) {
        NSRange range = [shop[@"name"] rangeOfString:keyword];
        if (range.location != NSNotFound)
        {
            [result addObject:shop];
        }
    }
    return result;
}

@end
