//
//  NSData+LYData.h
//  百思不得姐
//
//  Created by 李胜营 on 16/5/23.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LYDate)
/* 是否今年 */
- (BOOL)isYear;

/* 是否今年 */
- (BOOL)isToday;
/* 是否今年 */
- (BOOL)isYesterday;

- (NSDateComponents *)deletFromDate:(NSDate *)date;

@end
