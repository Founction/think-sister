//
//  NSData+LYData.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/23.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "NSDate+LYDate.h"

@implementation NSDate (LYDate)
- (NSDateComponents *)deletFromDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //指定比较内容，比较年，月，日？
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour |NSCalendarUnitSecond;
    
    //进行日期的比较
    return [calendar components:unit fromDate:date toDate:self options:0];

}
- (BOOL)isYear
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
   //只要截取时间，进行比较
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}
- (BOOL)isToday
{

    //    NSCalendar *calendar = [NSCalendar currentCalendar];
//    当传过来的时间格式发生变化的时候就不能用了 2015/02/02  2015-02-02
//    //指定比较内容，比较年，月，日？
//    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
//    
//    //进行日期的比较
//    NSDateComponents *cmp = [calendar components:unit fromDate:[NSDate date] toDate:self options:0];
//    
//    return cmp.year == 0 && cmp.month == 0 && cmp.day == 0;
    
    //确定时间的格式
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    //根据时间格式求出时间
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
    NSString *selfStr = [fmt stringFromDate:self];
    
    return [nowStr isEqualToString:selfStr];
    
}
- (BOOL)isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowStr = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    
    NSDate *selfStr = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmp = [calendar components:unit fromDate:selfStr toDate:nowStr options:0];
    
    return cmp.year == 0
    && cmp.month == 0
    && cmp.day == 1;
}
@end
