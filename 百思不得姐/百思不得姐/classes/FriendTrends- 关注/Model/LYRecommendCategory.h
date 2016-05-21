//
//  LYRecommendCategory.h
//  百思不得姐
//
//  Created by 李胜营 on 16/5/20.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LYRecommendCategory : NSObject
/* id */
@property (assign, nonatomic) NSInteger id;
/* count */
@property (assign, nonatomic) NSInteger count;
/* name */
@property (strong, nonatomic) NSString * name;
/* user */
@property (strong, nonatomic) NSMutableArray * usrs;
/* 指示当前更新总数 */
@property (assign, nonatomic) NSInteger total;
/* 当前页数 */
@property (assign, nonatomic) NSInteger page;
@end
