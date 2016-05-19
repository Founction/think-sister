//
//  UIBarButtonItem+LYExtension.h
//  百思不得姐
//
//  Created by 李胜营 on 16/5/19.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LYExtension)
+ (instancetype)itemWithImage:(UIImage *)image selectedImage:(UIImage *)image target:(id)target action:(SEL)action;
@end
