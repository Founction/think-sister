//
//  LYRecommendCell.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/20.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYRecommendCell.h"
#import "LYRecommendCategory.h"
@interface LYRecommendCell()
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;


@end
@implementation LYRecommendCell
- (void)setCategory:(LYRecommendCategory *)category
{
   _category = category;
    
    self.textLabel.text = category.name;

}

- (void)awakeFromNib {
    
    self.backgroundColor = LYRGBColor(244, 244, 244);
//    self.selectedIndicator.backgroundColor = LYRGBColor(219, 21, 26);
    
   
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 *  self.textLabel.y;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    self.selectedIndicator.hidden = !selected;
    
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : [UIColor grayColor];
    
}

@end
