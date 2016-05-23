//
//  LYWord.h
//  百思不得姐
//
//  Created by 李胜营 on 16/5/22.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYWord : NSObject
/* sceen_name */
@property (strong, nonatomic) NSString * sceen_name;
/* 帖子的文字内容 */
@property (strong, nonatomic) NSString * text;
/* 头像url */
@property (strong, nonatomic) NSString * profile_image;

@end
