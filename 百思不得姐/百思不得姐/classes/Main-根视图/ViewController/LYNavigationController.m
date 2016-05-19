//
//  LYNavigationController.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/19.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYNavigationController.h"

@implementation LYNavigationController

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];


}
//每个标签控制器都对应一个导航控制器。每个标签控制器进行切换的时候都要进行该方法。
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0)
    {
        //设置一个自定义反悔button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        
        btn.size = CGSizeMake(70, 30);
        //设置左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //左移10
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        //设置文本颜色
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        //设置push控制器的title
        
        viewController.title = @"xxx";
        //把标签控制器隐藏
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:YES];
}
- (void)back
{
    [self popViewControllerAnimated:YES];

}
@end
