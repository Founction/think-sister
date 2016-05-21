//
//  LYRecommendUserCell.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/20.
//  Copyright © 2016年 dasheng. All rights reserved.
//screen_name;fans_count;fans_count;

#import "LYRecommendUserCell.h"
#import "LYRecommendUser.h"
#import <UIImageView+WebCache.h>
@interface LYRecommendUserCell()
@property (weak, nonatomic) IBOutlet UILabel *fans_count;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *sceen_name;
@end
@implementation LYRecommendUserCell
- (void)setUser:(LYRecommendUser *)user
{
    _user = user;
    
    self.fans_count.text = [NSString stringWithFormat:@"%ld人关注",user.fans_count];
    
    self.sceen_name.text = user.screen_name;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@""]];


}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
