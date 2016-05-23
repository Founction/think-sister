//
//  LYWordCell.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/23.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYWordCell.h"
#import <UIImageView+WebCache.h>
#import "LYWord.h"
@interface LYWordCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *sinaVimageView;



@end
@implementation LYWordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // 加载背景图片
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    
    self.backgroundView = imageV;
}
- (void)setWord:(LYWord *)word
{
    _word = word;
    //设置头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:word.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    //设置昵称
    self.nameLable.text = word.name;
    //设置时间
    self.timeLable.text = word.create_time;
    self.sinaVimageView.hidden = !word.isSina_v;
    //设置底部工具条的显示内容
    [self setButtonTitle:self.dingButton setTitle:word.ding forState:UIControlStateNormal placeholder:@"顶"];
    [self setButtonTitle:self.caiButton setTitle:word.cai forState:UIControlStateNormal placeholder:@"踩"];
    [self setButtonTitle:self.shareButton setTitle:word.repost forState:UIControlStateNormal placeholder:@"分享"];
    [self setButtonTitle:self.commentButton setTitle:word.comment forState:UIControlStateNormal placeholder:@"评论"];


}

//设置按钮显示内容
- (void)setButtonTitle:(UIButton *)button setTitle:(NSInteger)count forState:(UIControlState)state placeholder:(NSString *)placeholder
{
    if (count > 10000)
    {
        placeholder = [NSString stringWithFormat:@"%zd万",count / 10000.0];
    }else if(count > 0)
    {
        placeholder = [NSString stringWithFormat:@"%zd",count];
    
    }
    
    [button setTitle:placeholder forState:state];
}
//设置cell的间隙
- (void)setFrame:(CGRect)frame
{
    CGFloat margin = 10;
    
    frame.origin.x = margin;
    
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    frame.size.width -= 2 * margin;
    
    [super setFrame:frame];


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
