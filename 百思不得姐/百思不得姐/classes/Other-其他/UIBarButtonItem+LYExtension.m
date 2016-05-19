//
//  UIBarButtonItem+LYExtension.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/19.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "UIBarButtonItem+LYExtension.h"

@implementation UIBarButtonItem (LYExtension)
+ (instancetype)itemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:selectedImage forState:UIControlStateSelected];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:@selector(action) forControlEvents: UIControlEventTouchUpInside];
    
    btn.size = btn.currentBackgroundImage.size;
    
    return [[self alloc] initWithCustomView:btn];
    
}
@end
