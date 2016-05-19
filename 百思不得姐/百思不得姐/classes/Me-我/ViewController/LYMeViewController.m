//
//  LYMeViewController.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/19.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYMeViewController.h"

@interface LYMeViewController ()

@end

@implementation LYMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我";
    
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon-click"]  selectedImage:[UIImage imageNamed:@"mine-moon-icon"]  target:self action:@selector(moonClick)];
   
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon-click"]  selectedImage:[UIImage imageNamed:@"mine-setting-icon"]  target:self action:@selector(settingClick)];
    
    self.navigationItem.rightBarButtonItems = @[moonItem,settingItem];
}

- (void)tagClick
{


}
- (void)settingClick
{
    
    
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
