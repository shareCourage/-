//
//  Person.m
//  AnimationLearn
//
//  Created by Kowloon on 15/6/4.
//  Copyright (c) 2015年 Paul. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize foo;
@synthesize name = myName;
//@dynamic name;

- (id)copyWithZone:(NSZone *)zone
{
    Person *person = [[[self class] allocWithZone:zone] init];
    return person;
}

+ (instancetype)person
{
    return [[self alloc] init];
}


- (NSString *)name
{
    return myName;
}


- (NSString *)foo
{
    return foo;
}

@end
