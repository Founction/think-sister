//
//  LYEssenseViewController.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/19.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYEssenseViewController.h"
#import "LYEssenseTitle.h"
#import "LYEssenceTitleView.h"
#import "LYRecommendTagsViewController.h"
#import "LYAllViewController.h"
#import "LYWordViewController.h"
#import "LYViedoViewController.h"
#import "LYPictureViewController.h"
#import "LYVoiceViewController.h"
#import "LYTopicsViewController.h"

@interface LYEssenseViewController ()<UIScrollViewDelegate,LYEssenceTitleViewDelegate>
/* titleNames */
@property (strong, nonatomic) NSArray * titleNames;

/* 滚动时图 */
@property (strong, nonatomic) UIScrollView * contentView;
/* 标题拦 */
@property (strong, nonatomic) LYEssenceTitleView * titleV;

@end

@implementation LYEssenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setUpNav];
    //加载所有的子控制器
    [self setUpAllChildViewController];
   
    //设置标题view
    [self setUpTitleView];
    //设置滚动时图
    [self setUpContentView];
}
//设置滚动时图
- (void)setUpContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.pagingEnabled = YES;
    contentView.delegate = self;
    [self.view insertSubview:contentView atIndex:0];
    
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
   
    self.contentView = contentView;
    
    //一开始就默认显示一个控制器
    [self scrollViewDidEndScrollingAnimation:contentView];


}
//加载所有的子控制器
- (void)setUpAllChildViewController
{
    LYTopicsViewController *allVC = [[LYTopicsViewController alloc] init];
    allVC.title = @"全部";
    allVC.type = LYTopicsTypeAll;
    
   LYTopicsViewController *videoVC = [[LYTopicsViewController alloc] init];
    videoVC.title = @"视频";
    videoVC.type = LYTopicsTypeVideo;
    
    LYTopicsViewController*voiceVC = [[LYTopicsViewController alloc] init];
    voiceVC.title = @"声音";
    videoVC.type = LYTopicsTypeVoice;
    
    LYTopicsViewController *pictureVC = [[LYTopicsViewController alloc] init];
    pictureVC.title =@"图片";
    pictureVC.type = LYTopicsTypePicture;
    
   LYTopicsViewController *wordVC =[[LYTopicsViewController alloc] init];
    wordVC.title = @"段子";
    wordVC.type = LYTopicsTypeWord;
    [self addChildViewController:allVC];
    [self addChildViewController:videoVC];
    [self addChildViewController:voiceVC];
    [self addChildViewController:pictureVC];
    [self addChildViewController:wordVC];
}
- (void)setUpTitleView
{
    NSArray *arr = @[@"全部",@"视频", @"声音", @"图片", @"段子"];
    self.titleNames = [LYEssenseTitle initWithArray:arr];
    LYEssenceTitleView *titleV = [[LYEssenceTitleView alloc] initWithFrame:CGRectMake(0, LYTitleViewY, self.view.width,LYTitleViewH)];
    titleV.titles = _titleNames;
    titleV.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    self.titleV = titleV;
    titleV.delegate = self;
    
    
    [self.view addSubview:titleV];
    
}
- (void)setUpNav
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"]  selectedImage:[UIImage imageNamed:@"MainTagSubIconClick"]  target:self action:@selector(tagClick)];
    
    self.view.backgroundColor = LYGlobleBg;
}
- (void)tagClick
{
    LYRecommendTagsViewController *recommendVc = [[LYRecommendTagsViewController alloc] init];
    
    [self.navigationController pushViewController:recommendVc animated:YES];
}
#pragma mark <UIScrollViewDelegate>
//滚动停止的时候要切换view（已经完全进入下一个界面）
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger i = offsetX / self.view.width;
    UITableViewController *vc = self.childViewControllers[i];
//    vc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, self.view.width, scrollView.height);
    vc.tableView.x = scrollView.contentOffset.x;
    vc.tableView.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.tableView.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    
    [scrollView addSubview:vc.view];

}
//即将进入下一个界面的时候会调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //按钮跟着滑动一起
    NSInteger index = scrollView.contentOffset.x / self.view.width;

    [self.titleV titleClick:self.titleV.subviews[index]];
    
    
}
#pragma mark <LYEssenceTitleViewDelegate>
- (void)essenceTitleView:(LYEssenceTitleView *)titleView ButtonTag:(NSInteger)tag
{
    CGPoint offset = self.contentView.contentOffset;
    offset.x = self.contentView.width * tag;
    
    [self.contentView setContentOffset:offset animated:YES];
}


@end
