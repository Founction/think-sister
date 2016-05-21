//
//  LYPushGuideView.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/21.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYPushGuideView.h"

@implementation LYPushGuideView

+ (void)show
{
    NSString *curVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] valueForKey:@"version"];
    
    if (![curVersion isEqualToString:oldVersion])
    {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        LYPushGuideView *guideV = [LYPushGuideView pushGuideView];
        guideV.frame = window.bounds;
        [window addSubview:guideV];
        
        [[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:@"version"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (instancetype)pushGuideView
{

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];;
}
- (IBAction)closeGuideView:(id)sender
{
    [self removeFromSuperview];
    
}
@end
