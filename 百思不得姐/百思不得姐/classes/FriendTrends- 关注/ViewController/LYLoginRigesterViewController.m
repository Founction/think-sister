//
//  LYLoginRigesterViewController.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/21.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYLoginRigesterViewController.h"

@interface LYLoginRigesterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *loginBackground;
@property (weak, nonatomic) IBOutlet UIView *logView;
@property (weak, nonatomic) IBOutlet UIView *registerView;
@property (weak, nonatomic) IBOutlet UIButton *registerBut;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logViewLeftMargin;

@end

@implementation LYLoginRigesterViewController
- (IBAction)registerCount:(UIButton *)btn
{
    
    [self.view endEditing:YES];
    
    //如果当前显示的为logview
    if (self.logViewLeftMargin.constant == 0)
    {
        self.logViewLeftMargin.constant = - self.view.width;
        
        btn.selected = YES;//为了能够xib切换图片
    }else//显示为注册view
    {
    
        self.logViewLeftMargin.constant = 0;
        btn.selected = NO;
    
    }
    
    [UIView animateWithDuration:0.1 animations:^{
    
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view insertSubview:self.loginBackground atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;

}
- (IBAction)closeLogView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
