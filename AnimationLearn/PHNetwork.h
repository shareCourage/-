//
//  PHNetwork.h
//  AnimationLearn
//
//  Created by Kowloon on 15/6/2.
//  Copyright (c) 2015年 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PHNetwork : NSObject
+ (void)request;
+ (void)requestWithblock:(void (^)(void))block;
+ (void)requestWithArgument:(NSString *)httpMethod url:(NSString *)url;
@end
