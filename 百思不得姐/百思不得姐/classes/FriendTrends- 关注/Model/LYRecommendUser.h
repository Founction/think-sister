//
//  LYRecommendUser.h
//  百思不得姐
//
//  Created by 李胜营 on 16/5/20.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYRecommendUser : NSObject

/* use name  */
@property (strong, nonatomic) NSString * screen_name;
/* fans_count */
@property (assign, nonatomic) NSInteger fans_count;
/* header */
@property (strong, nonatomic) NSString * header;
@end
