//
//  LYEssenceTitleView.h
//  百思不得姐
//
//  Created by 李胜营 on 16/5/21.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYEssenceTitleView;
@protocol LYEssenceTitleViewDelegate <NSObject>
@optional

- (void)essenceTitleView:(LYEssenceTitleView *)titleView ButtonTag:(NSInteger)tag;
@end

@interface LYEssenceTitleView : UIView
/* model array */
@property (strong, nonatomic) NSArray  * titles;
/* delegate */
@property (weak, nonatomic) id<LYEssenceTitleViewDelegate> delegate;

- (void)titleClick:(UIButton *)button;
@end
