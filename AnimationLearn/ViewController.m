//
//  ViewController.m
//  AnimationLearn
//
//  Created by Paul on 15-5-31.
//  Copyright (c) 2015年 Paul. All rights reserved.
//
#define Padding 60
#define Alpha 0.35f
#define RadiusPlus 1.5f
#define AlphaMinus 0.0035;
#define WidthOfScreen [UIScreen mainScreen].bounds.size.width / 2
#import "ViewController.h"
#import "PHCubeViewController.h"
@interface ViewController ()
{
    CGPoint center;
    CGFloat radiusOne;
    CGFloat radiusTwo;
    CGFloat alphaOne;
    CGFloat alphaTwo;
    BOOL _lanuchFirst;
    BOOL _lanuchSecond;
    BOOL _isButtonDown;
}
@property (nonatomic, strong)CAShapeLayer *myLayerOne;
@property (nonatomic, strong)CAShapeLayer *myLayerTwo;

@property(nonatomic, strong)CADisplayLink *displayLinkOne;
@property(nonatomic, strong)CADisplayLink *displayLinkTwo;

@property(nonatomic, weak)UIButton *myButton;
@property(nonatomic, strong)NSMutableArray *shapLayers;
- (IBAction)cubeVC:(id)sender;

@end

@implementation ViewController
- (NSMutableArray *)shapLayers
{
    if (!_shapLayers) {
        _shapLayers = [NSMutableArray array];
    }
    return _shapLayers;
}

- (IBAction)cubeVC:(id)sender {
     [self.navigationController pushViewController:[[PHCubeViewController alloc] init] animated:YES];
}
- (CAShapeLayer *)myLayerOne
{
    if (!_myLayerOne) {
        _myLayerOne = [CAShapeLayer layer];
        _myLayerOne.frame = self.view.bounds;
        [self.view.layer insertSublayer:_myLayerOne below:self.myButton.layer];

    }
    return _myLayerOne;
}
- (CAShapeLayer *)myLayerTwo
{
    if (!_myLayerTwo) {
        _myLayerTwo = [CAShapeLayer layer];
        _myLayerTwo.frame = self.view.bounds;
        [self.view.layer insertSublayer:_myLayerTwo below:self.myButton.layer];
    }
    return _myLayerTwo;
}
- (CADisplayLink *)displayLinkOne
{
    if (!_displayLinkOne) {
        _displayLinkOne = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTriggerOne)];
    }
    return _displayLinkOne;
}
- (CADisplayLink *)displayLinkTwo
{
    if (!_displayLinkTwo) {
        _displayLinkTwo = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTriggerTwo)];
    }
    return _displayLinkTwo;
}
- (void)oneValidate
{
    [self.displayLinkOne invalidate];
    self.displayLinkOne = nil;
}
- (void)twoValidate
{
    [self.displayLinkTwo invalidate];
    self.displayLinkTwo = nil;
}
- (void)displayLinkTriggerOne
{
    if (radiusOne >= WidthOfScreen + Padding) {
        radiusOne = self.myButton.frame.size.width / 2 - 5;
        alphaOne = Alpha;
        [self oneValidate];
        _lanuchFirst = YES;
    }
    radiusOne = radiusOne + RadiusPlus;
    alphaOne = alphaOne - AlphaMinus;
    UIBezierPath *bezier = [UIBezierPath bezierPathWithArcCenter:center radius:radiusOne startAngle:0 endAngle:2 * M_PI clockwise:NO];
    self.myLayerOne.fillColor = [[UIColor redColor] colorWithAlphaComponent:alphaOne].CGColor;
    self.myLayerOne.path = bezier.CGPath;
    
    if (radiusOne >= WidthOfScreen && _lanuchFirst) {
        if (!_isButtonDown) {
            [self.displayLinkTwo addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        }
        _lanuchFirst = NO;
    }
}

- (void)displayLinkTriggerTwo
{
    if (radiusTwo >= WidthOfScreen + Padding) {
        radiusTwo = self.myButton.frame.size.width / 2 - 5;
        alphaTwo = Alpha;
        [self twoValidate];
        _lanuchSecond = YES;
    }
    radiusTwo = radiusTwo + RadiusPlus;
    alphaTwo = alphaTwo - AlphaMinus;
    UIBezierPath *bezier = [UIBezierPath bezierPathWithArcCenter:center radius:radiusTwo startAngle:0 endAngle:2 * M_PI clockwise:NO];
    self.myLayerTwo.fillColor = [[UIColor redColor] colorWithAlphaComponent:alphaTwo].CGColor;
    self.myLayerTwo.path = bezier.CGPath;
    
    if (radiusTwo >= WidthOfScreen && _lanuchSecond) {
        if (!_isButtonDown) {
            [self.displayLinkOne addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        }
        _lanuchSecond = NO;
    }
}
- (void)clearShaperLayerAndInvalidateDisplayLink
{
    [self oneValidate];
    [self twoValidate];
    [self.myLayerOne removeFromSuperlayer];
    self.myLayerOne = nil;
    [self.myLayerTwo removeFromSuperlayer];
    self.myLayerTwo = nil;
    radiusOne = self.myButton.frame.size.width / 2;
    radiusTwo = self.myButton.frame.size.width / 2;
    alphaOne = Alpha;
    alphaTwo = Alpha;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AnimationL";

    [self buttonImplementation];
    _isButtonDown = NO;
    _lanuchFirst = YES;
    _lanuchSecond = YES;
    radiusOne = self.myButton.frame.size.width / 2;
    radiusTwo = self.myButton.frame.size.width / 2;
    center = self.view.center;
    alphaOne = Alpha;
    alphaTwo = Alpha;
    [self.displayLinkOne addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)buttonImplementation
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 100, 100);
    button.center = self.view.center;
    button.layer.cornerRadius = button.bounds.size.width / 2;
    [button setImage:[UIImage imageNamed:@"icon001.jpg"] forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    button.imageView.layer.cornerRadius = button.bounds.size.width / 2;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(buttonTouchDown:) forControlEvents:UIControlEventTouchDown];

    
    self.myButton = button;
}
- (void)buttonTouchUpInside:(UIButton *)sender
{
    NSLog(@"buttonTouchUpInside");
    sender.bounds = CGRectMake(0, 0, 100, 100);
    sender.center = self.view.center;
    sender.layer.cornerRadius = sender.bounds.size.width / 2;
    sender.imageView.contentMode = UIViewContentModeScaleAspectFit;
    sender.imageView.layer.cornerRadius = sender.bounds.size.width / 2;
    [self.displayLinkTwo addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _lanuchFirst = YES;
    _lanuchSecond = YES;
    _isButtonDown = NO;
}
- (void)buttonTouchDown:(UIButton *)sender
{
    NSLog(@"buttonTouchDown");
    _isButtonDown = YES;
    CGFloat downRadius = 70;
    sender.bounds = CGRectMake(0, 0, downRadius, downRadius);
    sender.center = self.view.center;
    sender.layer.cornerRadius = sender.bounds.size.width / 2;
    sender.imageView.contentMode = UIViewContentModeScaleAspectFit;
    sender.imageView.layer.cornerRadius = sender.bounds.size.width / 2;
}


@end





