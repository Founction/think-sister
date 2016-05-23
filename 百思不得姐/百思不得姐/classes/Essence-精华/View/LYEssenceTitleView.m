//
//  LYEssenceTitleView.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/21.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYEssenceTitleView.h"
#import "LYEssenseTitle.h"
@interface LYEssenceTitleView ()
/* indicator */
@property (strong, nonatomic) UIView * indicatorView;
/* 取消选中状态 */
@property (strong, nonatomic) UIButton * selectedBut;
@end

@implementation LYEssenceTitleView
- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    [self setUp];
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
  
    return self;
}
- (void)setUp
{
      //加载底部的移动条
    UIView *indicatorView = [[UIView alloc] init];
    
    indicatorView.backgroundColor = [UIColor redColor];
    self.indicatorView = indicatorView;
    
    //加载按钮
    for (int i = 0; i < self.titles.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        LYEssenseTitle *title = self.titles[i];
        
        [btn setTitle:title.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        //默认选中
        
        if (i == 0)
        {
            
            CGFloat w = self.width / self.titles.count;
            btn.enabled = NO;
            self.selectedBut = btn;
            //因为开始btn只是创建，还没有布局所以btn的frame都是0.可以根据文字内容进行布局，然后进行指示条的布局。
            [btn.titleLabel sizeToFit];
            self.indicatorView.width = btn.titleLabel.width;
            self.indicatorView.centerX = w * 0.5;
          
        }
        
    }
    
    [self addSubview:indicatorView];
    

}
- (void)titleClick:(UIButton *)button
{
    self.selectedBut.enabled = YES;
    button.enabled = NO;
    self.selectedBut = button;
    
    [UIView animateWithDuration:0.05 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    if ([_delegate respondsToSelector:@selector(essenceTitleView: ButtonTag:)])
    {
        [_delegate essenceTitleView:self ButtonTag:button.tag];
    }

}
- (void)layoutSubviews
{
    CGFloat w = self.width / self.titles.count;
    CGFloat h = self.height;
    int i = 0;
    for (UIView *btn in self.subviews)
    {
        
        if ([btn isKindOfClass:[UIControl class]])
        {
            btn.frame = CGRectMake(i * w, 0, w, h);
            
           
            i++;
        }
        
    }
    self.indicatorView.height = 5;
    self.indicatorView.y = self.height - self.indicatorView.height;

}
@end
