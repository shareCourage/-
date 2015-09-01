//
//  PHCubeViewController.m
//  AnimationLearn
//
//  Created by Kowloon on 15/6/11.
//  Copyright (c) 2015年 Paul. All rights reserved.
//

#import "PHCubeViewController.h"
#import <GLKit/GLKit.h>
#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5
@interface PHCubeViewController ()

@property(nonatomic, strong)IBOutletCollection(UIView) NSArray *numberViews;
@property (weak, nonatomic) IBOutlet UIView *container;

@property (weak, nonatomic) IBOutlet UIButton *containerRotation;

- (IBAction)containerRotationClick:(id)sender;
- (IBAction)threeViewClick:(id)sender;
@end

@implementation PHCubeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

//    self.view.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3f];
//    self.container.backgroundColor = [UIColor whiteColor];
    UIView *face = [self.numberViews firstObject];
    CGFloat translate = face.frame.size.width / 2;
    NSLog(@"numbers->%.f",face.frame.size.width);
    for (int i = 0; i < 6; i ++) {
        UIView *obj = self.numberViews[i];
        obj.userInteractionEnabled = NO;
        if (i == 2) {
            obj.userInteractionEnabled = YES;
        }
    }
#if 1
    //set up the container sublayer transform
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);

    self.container.layer.sublayerTransform = perspective;
    
    //add cube face 1
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, translate);
    [self addFace:0 withTransform:transform];
    
    //add cube face 2
    transform = CATransform3DMakeTranslation(translate, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    
    //add cube face 3
    transform = CATransform3DMakeTranslation(0, -translate, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    
    //add cube face 4
    transform = CATransform3DMakeTranslation(0, translate, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    
    //add cube face 5
    transform = CATransform3DMakeTranslation(-translate, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    
    //add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -translate);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
    
//    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
//    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
#endif
}
- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform
{
    //get the face view and add it to the container
    UIView *face = self.numberViews[index];
    [self.container addSubview:face];
    //center the face view within the container
    CGSize containerSize = self.container.bounds.size;
    face.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    // apply the transform
    face.layer.transform = transform;
#if 1
    index = index + 1;
    CGFloat alpha = 0.8f;
    switch (index) {
        case 1:
            [self addLayer:face color:[UIColor purpleColor] alpha:alpha];
            break;
        case 2:
            [self addLayer:face color:[UIColor redColor] alpha:alpha];

            break;
        case 3:
            [self addLayer:face color:[UIColor yellowColor] alpha:alpha];

            break;
        case 4:
            [self addLayer:face color:[UIColor whiteColor] alpha:alpha];

            break;
        case 5:
            [self addLayer:face color:[UIColor greenColor] alpha:alpha];

            break;
        case 6:
            [self addLayer:face color:[UIColor blueColor] alpha:alpha];

            break;
        default:
            break;
    }
#endif
//    [self applyLightingToFace:face.layer];
}
- (void)addLayer:(UIView *)face color:(UIColor *)color alpha:(CGFloat)alpha
{
    face.backgroundColor = [color colorWithAlphaComponent:alpha];
}
- (void)applyLightingToFace:(CALayer *)face
{
    //add lighting layer
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    //译者注：GLKMatrix4和CATransform3D内存结构一致，但坐标类型有长度区别，所以理论上应该做一次float到CGFloat的转换，感谢[@zihuyishi](https://github.com/zihuyishi)同学~
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}


- (IBAction)containerRotationClick:(id)sender {
//    [CATransaction begin];
//    [CATransaction setAnimationDuration:2.0f];
//    CATransform3D perspective = CATransform3DIdentity;
    CATransform3D perspective = self.container.layer.sublayerTransform;

//    perspective.m34 = -1.0 / 500.0;

    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    [UIView animateWithDuration:3.0f animations:^{
        self.container.layer.sublayerTransform = perspective;
    }];
//    [CATransaction commit];
}

- (IBAction)threeViewClick:(id)sender {
    NSLog(@"threeViewClick");
}
@end




