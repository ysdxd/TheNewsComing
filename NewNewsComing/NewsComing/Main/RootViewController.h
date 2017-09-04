//
//  RootViewController.h
//  TabBar
//
//  Created by huangfei on 16/7/26.
//  Copyright © 2016年 huangfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITabBarController

@property (nonatomic,strong) UIView *tabBarView;
-(void)showTabBar:(BOOL)show;

@end
