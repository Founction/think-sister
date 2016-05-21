//
//  LYEssenseTitle.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/21.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYEssenseTitle.h"

@implementation LYEssenseTitle

+ (instancetype)essenseTitleWithTitle:(NSString *)title
{
    LYEssenseTitle *essenseTitle = [[LYEssenseTitle alloc] init];
    
    essenseTitle.title = title;

    return essenseTitle;
}
+ (NSArray *)initWithArray:(NSArray *)titles
{
   
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++)
    {
        LYEssenseTitle *essenseTitle = [[LYEssenseTitle alloc] init];
        essenseTitle.title = titles[i];
        [arr addObject:essenseTitle];
        
    }
  
    return arr;

}
@end
