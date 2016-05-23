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
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;

/* cell高度 */
@property (assign, nonatomic,readonly) CGFloat cellH;

/* sinaV 加v */
@property (assign, nonatomic,getter=isSina_v) BOOL sina_v;


@end
