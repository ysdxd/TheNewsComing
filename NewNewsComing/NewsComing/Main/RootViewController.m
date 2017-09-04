//
//  RootViewController.m
//  TabBar
//
//  Created by huangfei on 16/7/26.
//  Copyright © 2016年 huangfei. All rights reserved.
//

#import "RootViewController.h"
#import "HomeController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
CGFloat const tabViewHeight = 49;
CGFloat const btnWidth = 64;
CGFloat const btnHeight = 45;

@interface RootViewController ()

@property (nonatomic,strong) UIImageView *selectView;

@end

/*
 本节重点：UITabBarController  UINavigationController
 
 1.一个导航控制器对应于一个视图控制器，
 2.标签控制器是管理固定的几个视图控制器，子控制器是并列的。每一个分栏控制器只有一个UITabBar视图，用于显示UITabBarItem实例，UITabBarItem由当前的视图控制器管理，这一点与导航控制器中的UIBarButtonItem相同
 
 3.UITabBarController用数组管理视图控制器，而导航控制器所管理的视图控制器之间的关系是上下级关系
 
 */

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //隐藏系统默认的样式
    self.tabBar.hidden = YES;
    
    [self initViewController];
    [self initTabBarView];
    
}

//初始化视图控制器
- (void)initViewController
{
    //添加几个UIViewController
    HomeController *homeVC = [[HomeController alloc] init];
    
    NSArray *vcArray = @[homeVC];
    
    NSMutableArray *tabArray = [NSMutableArray arrayWithCapacity:vcArray.count];
    //初始化导航控制器
    for (int i = 0; i < vcArray.count; i++) {
        
        //使用UIViewController 创建UINavigationController
        UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:vcArray[i]];
        [tabArray addObject:navCtrl];
    }
    //将导航控制器给标签控制器
    self.viewControllers = tabArray;
}

//自定义标签工具栏
- (void)initTabBarView
{
    //初始化标签工具栏视图
    _tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - tabViewHeight, kScreenWidth, kScreenHeight)];
    _tabBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mask_navbar"]];
    [self.view addSubview:_tabBarView];
    //创建数组，拿到图片
    NSArray *imgArray = @[@"home_tab_icon_1",@"home_tab_icon_2",@"home_tab_icon_3",@"home_tab_icon_4",@"home_tab_icon_5"];
    for (int i = 0; i < imgArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
        btn.frame = CGRectMake(btnWidth * i, (tabViewHeight - btnHeight)/2, btnWidth, btnHeight);
        //设置的tag值最好是100以后的，在IOS中，100以前的都是有特殊用法的。
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBarView addSubview:btn];
    
    }
    //初始化选中图片视图(指示小箭头)
    _selectView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btnWidth, btnHeight)];
    _selectView.image = [UIImage imageNamed:@"home_bottom_tab_arrow"];
    [_tabBarView addSubview:_selectView];

}

- (void)btnAction:(UIButton *)button
{
    //根据tag值判断当前索引
    self.selectedIndex = button.tag - 100;
    [UIView animateWithDuration:0.2 animations:^{
        _selectView.center = button.center;
    }completion:nil];
    
}

//是否显示工具栏
- (void)showTabBar:(BOOL)show
{
    CGRect frame = self.tabBarView.frame;
    if (show) {
        frame.origin.x = 0;
    }else{
        frame.origin.x = - kScreenWidth;
    }
    //重新赋值frame
    [UIView animateWithDuration:0.2 animations:^{
        self.tabBarView.frame = frame;
    }completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
