//
//  PHForwardViewController.m
//  AnimationLearn
//
//  Created by Kowloon on 15/6/10.
//  Copyright (c) 2015年 Paul. All rights reserved.
//
#define RADIANS_TO_DEGREES(x) ((x)/M_PI*180.0)
#import "PHForwardViewController.h"

@interface PHForwardViewController ()

@property (weak, nonatomic) IBOutlet UIView *lightView;
@property (weak, nonatomic) IBOutlet UIView *redView;
- (IBAction)animationClick:(id)sender;
@end

@implementation PHForwardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lightView.layer.cornerRadius = 20.f;
    self.redView.layer.cornerRadius = 20.f;
    
    self.lightView.layer.masksToBounds = YES;
    
    self.lightView.layer.borderWidth = 3.0f;
    self.lightView.layer.borderColor = [UIColor greenColor].CGColor;
    self.lightView.layer.shadowOpacity = 1.f;
    self.lightView.layer.shadowOffset = CGSizeMake(0, -9);
    self.lightView.layer.shadowRadius = 30;
    
    
    self.lightView.layer.mask = nil;
}




- (IBAction)animationClick:(id)sender {
//    [self transformThree];
    [self transformWith3DOne];
//    [self transformWith3DTwo];
}






#pragma mark - 使用这种方式无法触发隐式动画，UIView内部将这个动画已经禁止了
- (void)transformOne
{
#if 1
    [CATransaction begin];
    [CATransaction setAnimationDuration:2.0f];
    
    CGAffineTransform originalT = self.lightView.layer.affineTransform;
    
    CGAffineTransform transform = CGAffineTransformRotate(originalT, M_PI_4);
    
    self.lightView.layer.affineTransform = transform;
    
    [CATransaction commit];
#endif
}


- (void)transformTwo
{
#if 1
    CGAffineTransform originalT = self.lightView.layer.affineTransform;
    
    CGAffineTransform transform = CGAffineTransformRotate(originalT, M_PI_4);
    
    self.lightView.layer.affineTransform = transform;
#endif
}

- (void)transformThree
{
#if 1
    CGAffineTransform transform = CGAffineTransformIdentity; //scale by 50%
    transform = CGAffineTransformScale(transform, 0.5, 0.5); //rotate by 30 degrees
    transform = CGAffineTransformRotate(transform, M_PI / 180.0 * 30.0); //translate by 200 points
    transform = CGAffineTransformTranslate(transform, 200, 0);
    //apply transform to layer
    self.lightView.layer.affineTransform = transform;
#endif
}


- (void)transformWith3DOne
{
//    CATransform3D transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    CATransform3D transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);

    self.lightView.layer.transform = transform;
}


#pragma mark - 透视投影
- (void)transformWith3DTwo
{
    //create a new transform
    CATransform3D transform = CATransform3DIdentity;
    //apply perspective
    transform.m34 = - 1.0 / 500.0;
    //rotate by 45 degrees along the Y axis
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    //apply to layer
    self.lightView.layer.transform = transform;
}






@end














