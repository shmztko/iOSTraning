//
//  Person.h
//  testapp
//
//  Created by student on 2014/09/25.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZPerson : NSObject

@property(readonly) NSString *personId;
@property(copy) NSString *firstName;
@property(copy) NSString *lastName;
@property(readonly) NSString *fullName;
@property(copy) NSDate *birthday;
@property(readonly) int weight;
@property(readonly) int height;
@property(weak) XYZPerson *partner;

- (void) measureWeight;
- (void) measureHeight;

- (void) sayHello;
- (NSString *) getGreeting;
+ (id) person;
+ (id) personWithLastName:(NSString *) lastName andFirstName:(NSString *) firstName;
+ (id) personWithLastName:(NSString *) lastName andFirstName:(NSString *) firstName andBirthday:(NSDate *) birthday;
@end
