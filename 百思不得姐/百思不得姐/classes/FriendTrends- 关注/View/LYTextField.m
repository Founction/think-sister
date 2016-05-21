//
//  LYTextField.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/21.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYTextField.h"

@implementation LYTextField
- (void)awakeFromNib
{
//    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.tintColor = self.textColor;
    //创建的时候都不称为第一响应者，只有点击的时候才是
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
  
    return [super becomeFirstResponder];

}
- (BOOL)resignFirstResponder
{

    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    return [super resignFirstResponder];
}
@end
