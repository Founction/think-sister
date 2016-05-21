//
//  LYEssenseTitle.h
//  百思不得姐
//
//  Created by 李胜营 on 16/5/21.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYEssenseTitle : UIView

/* label */
@property (strong, nonatomic) NSString * title;

+ (instancetype)essenseTitleWithTitle:(NSString *)title;
+ (NSArray *)initWithArray:(NSArray *)titles;
@end
