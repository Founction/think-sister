//
//  LYTabBarController.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/18.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYTabBarController.h"
#import "LYTabBar.h"
#import "LYEssenseViewController.h"
#import "LYNewBBSViewController.h"
#import "LYFriendTrendsController.h"
#import "LYMeViewController.h"
#import "LYNavigationController.h"
@interface LYTabBarController ()

@end

@implementation LYTabBarController
+ (void)initialize
{
 //通过appearance获取所有的UITabBarItem，并进行属性设置
    UITabBarItem *tabBarItem= [UITabBarItem appearance];
    NSMutableDictionary *attrTitle = [NSMutableDictionary dictionary];
    attrTitle[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrTitle[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *attrSeletedTitle = [NSMutableDictionary dictionary];
    attrSeletedTitle [NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrSeletedTitle [NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    [tabBarItem setTitleTextAttributes:attrTitle forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:attrSeletedTitle forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self setUpAllChildViewController];
    //利用kvc代替系统自带的tababr
    [self setValue:[[LYTabBar alloc] init]forKeyPath:@"tabBar"];
}
- (void)setUpAllChildViewController
{
    LYEssenseViewController *vc = [[LYEssenseViewController alloc] init];
    [self setUpEveryViewController:vc image:[UIImage imageNamed:@"tabBar_essence_icon"] selectedImage:[UIImage imageNamed:@"tabBar_essence_click_icon"]  title:@"精华"];
    LYFriendTrendsController *vc1 = [[LYFriendTrendsController alloc] init];
    [self setUpEveryViewController:vc1 image:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selectedImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"]  title:@"关注"];

    LYMeViewController *vc2 = [[LYMeViewController alloc] init];
    [self setUpEveryViewController:vc2 image:[UIImage imageNamed:@"tabBar_me_icon"] selectedImage:[UIImage imageNamed:@"tabBar_me_click_icon"]  title:@"我"];
    LYNewBBSViewController *vc3 = [[LYNewBBSViewController alloc] init];
    [self setUpEveryViewController:vc3 image:[UIImage imageNamed:@"tabBar_new_icon"] selectedImage:[UIImage imageNamed:@"tabBar_new_click_icon"]  title:@"新帖"];


}
- (void)setUpEveryViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
   
    vc.navigationItem.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    vc.tabBarItem.title = title;
    
   //将自控制器包装成
    LYNavigationController *nav = [[LYNavigationController alloc] initWithRootViewController:vc];

    [self addChildViewController:nav];
}
@end
