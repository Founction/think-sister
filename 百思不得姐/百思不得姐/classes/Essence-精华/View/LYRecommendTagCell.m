//
//  LYRecommendTagCell.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/22.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYRecommendTagCell.h"
#import "LYRecommendTag.h"
#import "UIImageView+WebCache.h"

@interface LYRecommendTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLable;


@end
@implementation LYRecommendTagCell
- (void)setRecommendTag:(LYRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLable.text = recommendTag.theme_name;
    NSString *fans;
    if (recommendTag.sub_number > 9999)
    {
        fans = [NSString stringWithFormat:@"%zd万人订阅",recommendTag.sub_number / 10000];
    }else
    {
        fans = [NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    }
    self.fansCountLable.text = fans;

}
-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;
    
    frame.size.width -= 2 * frame.origin.x;
    
    frame.size.height -= 1;
    
    [super setFrame:frame];


}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
