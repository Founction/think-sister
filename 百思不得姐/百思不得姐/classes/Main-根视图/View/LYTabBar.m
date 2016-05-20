//
//  LYTabBar.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/18.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYTabBar.h"
@interface LYTabBar()
/* button */
@property (weak, nonatomic) UIButton * btn;
@end

@implementation LYTabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [self addSubview:btn];
        self.btn = btn;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.btn.bounds = CGRectMake(0,0, self.btn.currentBackgroundImage.size.width, self.btn.currentBackgroundImage.size.height);
    self.btn.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.width / 5;
    CGFloat h = self.height;
    
    int i = 0;
    for (UIView * view in self.subviews)
    {
        if (![view isKindOfClass:[UIControl class]] || view == self.btn)
            continue;
        
        x = w * ((i > 1) ? (i + 1) : i);
        
        view.frame = CGRectMake(x, y, w, h);
        i++;
    }

}

@end
