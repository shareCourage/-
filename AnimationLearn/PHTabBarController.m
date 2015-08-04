//
//  PHTabBarController.m
//  AnimationLearn
//
//  Created by Kowloon on 15/6/2.
//  Copyright (c) 2015年 Paul. All rights reserved.
//

#import "PHTabBarController.h"

@interface PHTabBarController ()<UITabBarControllerDelegate>

@end

@implementation PHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedIndex = self.viewControllers.count - 3;
    self.delegate = self;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //set up crossfade transition
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    //apply transition to tab bar controller's view
    [self.tabBarController.view.layer addAnimation:transition forKey:nil];
}


@end
