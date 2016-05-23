//
//  LYWord.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/22.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYWord.h"

/**
    今年
        今天
             1分钟内
                  刚刚
             1小时内
                 xx分钟前
             其他
                 xx小时前
         昨天
             昨天 18:56:34
         其他
             06-23 19:56:23
         
     非今年
         2014-05-08 18:45:30
 */
@implementation LYWord
//readonly的时候，只会有get没有set，所以声明变量，以此使用_cellH
{
    CGFloat _cellH;
    
}
- (NSString *)create_time
{

    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *date = [fmt dateFromString:_create_time];
    NSDateComponents *cmp = [[NSDate date] deletFromDate:date];
    
    if (date.isYear)
    {
        if (date.isToday)
        {
            
            if (cmp.hour >= 1) {
                
                return [NSString stringWithFormat:@"%zd小时前",cmp.hour];
                
            }else if (cmp.minute >= 1)
            {
                return [NSString stringWithFormat:@"%zd分钟前 ",cmp.minute];
            
            }else
            {
              return @"刚刚";
            }
            
        }else if (date.isYesterday)
        {
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:date];
        
        }else
        {
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:date];
        }
    }else
    {
        
        return _create_time;
    
    }


}
//只计算一次高度
- (CGFloat)cellH
{
    
    if (!_cellH) {
        //文字最大尺寸，规定了宽度，不设置高度
        CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * LYWordViewMargin, MAXFLOAT);
        //计算高度
        CGFloat textH = [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        
        _cellH = LYWordViewTextY + textH + LYWordViewButtonH + 2 * LYWordViewMargin;
    }
        

    return _cellH;
}
@end
