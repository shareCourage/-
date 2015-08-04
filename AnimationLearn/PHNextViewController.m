//
//  PHNextViewController.m
//  AnimationLearn
//
//  Created by Kowloon on 15/6/9.
//  Copyright (c) 2015年 Paul. All rights reserved.
//

#import "PHNextViewController.h"
#import "PHNothingController.h"
@interface PHNextViewController ()
@property (weak, nonatomic) IBOutlet UIView *myView;

@property (nonatomic, strong) CALayer *colorLayer;
@property (nonatomic, strong) CALayer *colorLayer1;

@end

@implementation PHNextViewController

- (void)displayLink
{
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTrigger)];
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)displayLinkTrigger
{
    CALayer *layer = self.colorLayer.presentationLayer;
    NSLog(@"%@",NSStringFromCGRect(layer.frame));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
#if 1
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromLeft;
    self.colorLayer.actions = @{@"backgroundColor":transition};
#endif
    [self.myView.layer addSublayer:self.colorLayer];
    
#if 0
    self.colorLayer1 = [CALayer layer];
    self.colorLayer1.frame = CGRectMake(60.0f, 60.0f, 100.0f, 100.0f);
    self.colorLayer1.backgroundColor = [UIColor redColor].CGColor;
    //add it to our view
    [self.myView.layer addSublayer:self.colorLayer1];
    self.colorLayer.zPosition = 1.f;
#endif
    
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
#if 0
    //get touch position
    CGPoint point = [[touches anyObject] locationInView:self.view];
    //get touched layer
    CALayer *layer = [self.myView.layer hitTest:point];
    //get layer using hitTest
    if (layer == self.colorLayer) {
        [[[UIAlertView alloc] initWithTitle:@"Inside Blue Layer"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
    else if (layer == self.myView.layer) {
        [[[UIAlertView alloc] initWithTitle:@"Inside White Layer"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
#endif
#if 0
    //get touch position relative to main view
    CGPoint point = [[touches anyObject] locationInView:self.view];
    //convert point to the white layer's coordinates
    point = [self.myView.layer convertPoint:point fromLayer:self.view.layer];
    //get layer using containsPoint:
    if ([self.myView.layer containsPoint:point]) {
        //convert point to colorLayer’s coordinates
        point = [self.colorLayer convertPoint:point fromLayer:self.myView.layer];
        if ([self.colorLayer containsPoint:point]) {
            [[[UIAlertView alloc] initWithTitle:@"Inside Blue Layer"
                                        message:nil
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Inside White Layer"
                                        message:nil
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
    }
#endif
    
    
#if 0
    //get the touch point
    CGPoint point = [[touches anyObject] locationInView:self.view];
    //check if we've tapped the moving layer
    CALayer *hitLayer = [self.view.layer hitTest:point];
    if (hitLayer == self.colorLayer) {
        NSLog(@"hit self.colorLayer");
        [CATransaction begin];
        [CATransaction setAnimationDuration:4.0];
        self.colorLayer.position = point;
        [CATransaction commit];
    }
    else if (hitLayer == self.colorLayer.presentationLayer){
        NSLog(@"hit self.colorLayer.presentationLayer");
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    }
    else {
        NSLog(@"hit someelse");
    }
#endif
    
    
#if 1
    CGPoint point = [[touches anyObject] locationInView:self.view];
    if ([self.colorLayer.presentationLayer hitTest:point]) {
        //randomize the layer background color
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    } else {
        //otherwise (slowly) move the layer to new position
        [CATransaction begin];
        [CATransaction setAnimationDuration:4.0];
        self.colorLayer.position = point;
        [CATransaction commit];
    }
#endif
}

- (IBAction)changeColor:(id)sender {
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:2.0f];
#if 0
    CGAffineTransform originalT = self.colorLayer.affineTransform;
    
    CGAffineTransform transform = CGAffineTransformRotate(originalT, M_PI_4);
    
    self.colorLayer.affineTransform = transform;
#endif
    
#if 1
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
#endif
    [CATransaction commit];
}

- (IBAction)similarPush:(id)sender {
    PHNothingController *nothing = [[PHNothingController alloc] init];
    
    CATransition *transion = [CATransition animation];
    transion.type = kCATransitionPush;
    transion.subtype = kCATransitionFromLeft;
    [nothing.view.layer addAnimation:transion forKey:nil];
    [self presentViewController:nothing animated:YES completion:nil];
}


@end




