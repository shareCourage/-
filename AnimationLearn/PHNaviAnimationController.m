//
//  PHNaviAnimationController.m
//  AnimationLearn
//
//  Created by Kowloon on 15/6/3.
//  Copyright (c) 2015年 Paul. All rights reserved.
//
#import <HomeKit/HomeKit.h>
#import <HealthKit/HealthKit.h>
#define NAVBAR_CHANGE_POINT 64
#define HeightOfImageView 200
#import "PHNaviAnimationController.h"
#import "UINavigationBar+Awesome.h"
@interface PHNaviAnimationController ()
{
    BOOL _isFirst;
}
@property(nonatomic, strong)NSArray *datas;
@property(nonatomic, weak)UIImageView *imageV;
@end

@implementation PHNaviAnimationController
- (NSArray *)datas
{
    if (!_datas) {
        _datas = @[@"YES",@"NO",@"Mac",@"iOS",@"Android",@"WindowPhone",@"Windows",@"Linuxs",@"Unixs",@"Mac",@"iOS",@"Android",@"WindowPhone",@"Windows",@"Linuxs",@"Unixs"];
    }
    return _datas;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NaviAni";
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HeightOfImageView)];
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.jpg"]];
    imageV.frame = CGRectMake(0, 0, self.view.frame.size.width, HeightOfImageView);
    [headView addSubview:imageV];
    self.imageV = imageV;
    self.tableView.tableHeaderView = headView;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[[UIColor greenColor] colorWithAlphaComponent:0.3f]];
}
#if 1
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"offsetY->%f",offsetY);
    
    if (offsetY >= -64) {
        if (!_isFirst) {
            CGFloat alpha;
            alpha = fabs(offsetY) / 64;
            if (offsetY >= 0) alpha = 0;
            [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        }
        else {
            if (offsetY < -20) {// -64 < a < -20
#warning 当scrollView的offsetY值跳动比较大时，会产生bug，20150604
                CGFloat value = -64 - offsetY;
                NSLog(@"value->%f",value);
                [self.navigationController.navigationBar lt_setTranslationY:value];
            }
            else {
                [self.navigationController.navigationBar lt_setTranslationY:(-44)];
            }
        }
        
    }
    else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:1]];
        CGFloat value = - (offsetY + 64);
        CGFloat scale = 1 + value / HeightOfImageView;
        self.imageV.transform = CGAffineTransformMakeScale(scale, scale);
        self.imageV.frame = CGRectMake(self.imageV.frame.origin.x, - value, self.imageV.frame.size.width, self.imageV.frame.size.height);
    }
}
#endif
- (void)setNavigationBarTransformProgress:(CGFloat)progress
{
//    [self.navigationController.navigationBar lt_setContentAlpha:(1-progress)];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.datas[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            _isFirst = YES;
            break;
        case 1:
            _isFirst = NO;
            break;

        default:
            
            break;
    }
}



@end
