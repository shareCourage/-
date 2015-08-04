//
//  Person.h
//  AnimationLearn
//
//  Created by Kowloon on 15/6/4.
//  Copyright (c) 2015年 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCopying>

@property(nonatomic, strong)NSString *name;
@property(nonatomic, assign)int age;
+ (instancetype)person;
@end
