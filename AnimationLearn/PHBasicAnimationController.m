//
//  PHBasicAnimationController.m
//  AnimationLearn
//
//  Created by Kowloon on 15/6/11.
//  Copyright (c) 2015年 Paul. All rights reserved.
//

#import "PHBasicAnimationController.h"

@interface PHBasicAnimationController ()
{
    CFTimeInterval _timeInterval;
    float _speed;
}
@property (weak, nonatomic) IBOutlet UIView *layerView;
@property(nonatomic, strong)CALayer *colorLayer;
- (IBAction)layerChange:(id)sender;


@property(nonatomic, strong)CALayer *bezierLayer;
@property(nonatomic, strong)UIBezierPath *bezierPath;
@property (weak, nonatomic) IBOutlet UISlider *sliderOne;
@property (weak, nonatomic) IBOutlet UISlider *sliderTwo;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
- (IBAction)playAction:(id)sender;
- (IBAction)sliderOneAction:(id)sender;
- (IBAction)sliderTwoAction:(id)sender;
@property(nonatomic, weak)IBOutlet UILabel *offsetL;
@property(nonatomic, weak)IBOutlet UILabel *speedL;
@end

@implementation PHBasicAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
#if 1
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(150.0f, 300.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layerView.layer addSublayer:self.colorLayer];
#endif
    
    //create a path
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(30, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    self.bezierPath = bezierPath;
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.layerView.layer addSublayer:pathLayer];
    //add the ship
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = CGPointMake(35, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed: @"icon001.jpg"].CGImage;
    shipLayer.cornerRadius = 32;
    shipLayer.masksToBounds = YES;
    [self.layerView.layer addSublayer:shipLayer];
    self.bezierLayer = shipLayer;
    //create the keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0;
    animation.path = bezierPath.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;//方向沿着贝塞尔曲线的切点
    [shipLayer addAnimation:animation forKey:nil];
}

- (IBAction)layerChange:(id)sender {
    
    //create a keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor ];
    //apply animation to layer
    [self.colorLayer addAnimation:animation forKey:nil];
    
    
    
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    keyAnimation.keyPath = @"position";
//    keyAnimation.duration = 4.0;
    keyAnimation.path = self.bezierPath.CGPath;
    keyAnimation.rotationMode = kCAAnimationRotateAuto;//方向沿着贝塞尔曲线的切点
//    [self.bezierLayer addAnimation:keyAnimation forKey:nil];
    
    
    CABasicAnimation *basic = [CABasicAnimation animation];
    basic.keyPath = @"transform.rotation";
//    basic.duration = 2.0f;
    basic.byValue = @( - M_PI * 2);

    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[basic, keyAnimation];
    group.duration = 4.0f;
    
    [self.bezierLayer addAnimation:group forKey:nil];
}


- (IBAction)basicAnimation:(id)sender {
    
    //animate the ship rotation
    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"transform";
//    animation.duration = 2.0;
//    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0, 0, 1)];
    
    animation.keyPath = @"transform.rotation";
    animation.duration = 2.0f;
    animation.byValue = @(- M_PI * 2);
    [self.bezierLayer addAnimation:animation forKey:nil];
    
}


- (IBAction)playAction:(id)sender {
    //create the keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.timeOffset = _timeInterval;
    animation.speed = _speed;
    animation.duration = 2.0;
//    animation.repeatCount = INFINITY;
    animation.path = self.bezierPath.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.removedOnCompletion = NO;
    animation.fillMode =  kCAFillModeBoth;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.bezierLayer addAnimation:animation forKey:@"slide"];
}

- (IBAction)sliderOneAction:(id)sender {
    UISlider *mySlider = (UISlider *)sender;
    _timeInterval = mySlider.value;
    self.offsetL.text = [NSString stringWithFormat:@"%.2f",_timeInterval];
}

- (IBAction)sliderTwoAction:(id)sender {
    UISlider *mySlider = (UISlider *)sender;
    _speed = mySlider.value;
    self.speedL.text = [NSString stringWithFormat:@"%.2f",_speed];

}
@end







