//
//  PHNetwork.m
//  AnimationLearn
//
//  Created by Kowloon on 15/6/2.
//  Copyright (c) 2015年 Paul. All rights reserved.
//

#import "PHNetwork.h"

@implementation PHNetwork
+ (void)request
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://baidu.com"]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"request sleep 5s");
        NSLog(@"%@",[NSThread currentThread]);
        sleep(1);
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"string->%@",string);
        
    }];
    [task resume];
}
+ (void)requestWithblock:(void (^)(void))block
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://baidu.com"]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"request sleep 5s");
        NSLog(@"%@",[NSThread currentThread]);
        sleep(1);
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"string->%@",string);
        if (block) {
            block();
        }
        
    }];
    [task resume];
}
+ (void)requestWithArgument:(NSString *)httpMethod url:(NSString *)url
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = httpMethod;
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"requestWithArgument sleep 5s");
        NSLog(@"%@",[NSThread currentThread]);
        sleep(5);
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"string->%@",string);
        
    }];
    [task resume];
}
@end
