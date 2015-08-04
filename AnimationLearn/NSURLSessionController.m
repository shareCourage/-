//
//  NSURLSessionController.m
//  AnimationLearn
//
//  Created by Kowloon on 15/6/2.
//  Copyright (c) 2015年 Paul. All rights reserved.
//

#import "NSURLSessionController.h"
#import "PHNetwork.h"
#import "Person.h"
//#import <GMOpenSDK/GMOpenKit.h>
@interface NSURLSessionController ()
@property (nonatomic, strong) NSString *strongString;
@property (nonatomic, copy) NSString *copyedString;

@property (nonatomic, strong) NSArray *strongArray;
@property (nonatomic, copy) NSArray *copyedArray;

@property(nonatomic, strong)Person *strongPerson;
@property(nonatomic, copy)Person *copyedPerson;

@property(nonatomic, strong)IBOutletCollection(UIScrollView) NSArray *scrollViews;
@property(nonatomic, strong)NSArray *imagesData;
@end

@implementation NSURLSessionController
- (NSArray *)imagesData
{
    if (!_imagesData) {
        _imagesData = @[@"bg.jpg",@"icon001.jpg",@"bg.jpg"];
    }
    return _imagesData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    self.title = @"Request";

}
- (void)test {
    NSString *string = [NSString stringWithFormat:@"abc"];
//    NSMutableString *string = [NSMutableString stringWithFormat:@"abc"];
    self.strongString = string;
    self.copyedString = string;
    NSLog(@"origin string: %p, %p", string, &string);
    NSLog(@"strong string: %p, %p", _strongString, &_strongString);
    NSLog(@"__copy string: %p, %p", _copyedString, &_copyedString);
    NSString *mutableString = [string mutableCopy];
    NSLog(@"__mutableCopy string: %p, %p", mutableString, &mutableString);
    mutableString = [mutableString stringByAppendingString:@"efg"];
    NSLog(@"%@",mutableString);
#if 1
//    NSArray *array = [NSArray array];
    NSMutableArray *array = [NSMutableArray array];
    self.strongArray = array;
    self.copyedArray = array;
    NSLog(@"origin array: %p, %p", array, &array);
    NSLog(@"strong array: %p, %p", _strongArray, &_strongArray);
    NSLog(@"__copy array: %p, %p", _copyedArray, &_copyedArray);
    
    
    Person *origin = [Person person];
    self.strongPerson = origin;
    self.copyedPerson = origin;
    NSLog(@"origin person: %p, %p",origin, &origin);
    NSLog(@"strong person: %p, %p",_strongPerson, &_strongPerson);
    NSLog(@"__copy person: %p, %p",_copyedPerson, &_copyedPerson);
#endif
    
}

- (void)setupScrollViewImages
{
    NSLog(@"%@",self.scrollViews);
    for (UIScrollView *scrollView in self.scrollViews) {
        [self.imagesData enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL *stop) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(scrollView.frame) * idx, 0, CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame))];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.image = [UIImage imageNamed:imageName];
            [scrollView addSubview:imageView];
        }];
    }
}

- (void)awakeFromNib
{
    NSLog(@"awakeFromNib");
}
- (IBAction)requestEvent:(id)sender {
#if 0
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://baidu.com"]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"sleep 5s");
        NSLog(@"%@",[NSThread currentThread]);
        sleep(5);
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"string->%@",string);
    }];
    [task resume];
#endif
    
    __weak typeof(self) weakSelf = self;
    [PHNetwork requestWithblock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            [strongSelf setupScrollViewImages];
        });
    }];
    
    [self test];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"group1");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"group2");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:8];
        NSLog(@"group3");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"updateUi");  
    });
    
}

@end






