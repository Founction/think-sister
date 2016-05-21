//
//  LYVerticalButton.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/21.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYVerticalButton.h"

@implementation LYVerticalButton

- (void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}
- (void)awakeFromNib
{
    [self setUp];

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w = self.width;
    
    CGFloat h = w;
    
    self.imageView.frame = CGRectMake(0, 0, w, h);
    
    self.titleLabel.frame = CGRectMake(0, w, w, self.height - h);


}
@end
