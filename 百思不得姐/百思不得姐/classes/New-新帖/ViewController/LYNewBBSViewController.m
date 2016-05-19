//
//  LYNewBBSViewController.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/19.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYNewBBSViewController.h"

@interface LYNewBBSViewController ()

@end

@implementation LYNewBBSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MainTagSubIconClick"] style:UIBarButtonItemStylePlain target:self action:@selector(tagClick)];
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MainTagSubIconClick"] style:UIBarButtonItemStyleDone target:self action:@selector(tagClick)];
    //    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [btn setBackgroundImage:forState:UIControlStateSelected];
    //    [btn setBackgroundImage:forState:UIControlStateNormal];
    //    [btn addTarget:self action:@selector(tagClick) forControlEvents:UIControlStateSelected];
       self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"]  selectedImage:[UIImage imageNamed:@"MainTagSubIconClick"]  target:self action:@selector(tagClick)];
}


- (void)tagClick
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
