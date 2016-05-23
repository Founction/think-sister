//
//  LYWordViewController.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/22.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYTopicsViewController.h"
#import <AFNetworking.h>
#import "LYWord.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "LYWordCell.h"

@interface LYTopicsViewController()
/* 请求 */
@property (strong, nonatomic) AFHTTPSessionManager * manager;
/* models */
@property (strong, nonatomic) NSMutableArray * words;
/* 返回的最大值 */
@property (strong, nonatomic) NSString *maxtime;
/* page */
@property (assign, nonatomic) NSInteger page;
/* 防止多次请求，刷新表格 */
@property (strong, nonatomic) NSMutableDictionary * param;

@end

@implementation LYTopicsViewController
- (NSMutableArray *)words
{
    if (_words == nil)
    {
        _words = [NSMutableArray array];
    }
    return _words;
    
}
- (AFHTTPSessionManager *)manager
{
    if (_manager == nil)
    {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableview];
    
    [self setUpRefresh];
    
    
}

static NSString * const LYWordCellID = @"wordcell";
- (void)setUpTableview
{
    CGFloat buttom = self.tabBarController.tabBar.height;
    
    CGFloat top = LYTitleViewY + LYTitleViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, buttom,0);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 200;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYWordCell class]) bundle:nil] forCellReuseIdentifier:LYWordCellID];
}
- (void)setUpRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewWord)];
    [self.tableView.header beginRefreshing];
    self.tableView.header.automaticallyChangeAlpha = YES;
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreWord)];
    
    
}
- (void)loadNewWord
{
    [self.tableView.footer endRefreshing];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.param = params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task,id responseObject){
        if (self.param != params) return ;
        
        [self.tableView.header endRefreshing];
        //字典－>模型
        self.words = [LYWord mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //刷新表格
        [self.tableView reloadData];
        //清空页码
        self.page = 0;
        //停止刷新
        [self.tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask *task,NSError *error){
        
        if (self.param != params) return ;
        
        [self.tableView.header endRefreshing];
    }];
    
}
- (void)loadMoreWord
{
    
    [self.tableView.header endRefreshing];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"maxtime"] = self.maxtime;
    params[@"page"] = @(++self.page);
    
    self.param = params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task,id responseObject){
        if (self.param != params) return ;
        
        [self.tableView.header endRefreshing];
        
        [self.words addObjectsFromArray:[LYWord mj_objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        
        [self.tableView reloadData];
        
        [self.tableView.footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task,NSError *error){
        if (self.param != params) return ;
        
        [self.tableView.footer endRefreshing];
        
        self.page--;
        
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.footer.hidden = (self.words.count == 0);
    return self.words.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYWord *word = self.words[indexPath.row];
    
    LYWordCell *cell = [tableView dequeueReusableCellWithIdentifier:LYWordCellID];
    
    cell.word = word;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYWord *word = self.words[indexPath.row];
    //设置文字的约束
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * LYWordViewMargin, MAXFLOAT);
    
    CGFloat textH = [word.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    
    return LYWordViewTextY + textH + LYWordViewButtonH + 2 * LYWordViewMargin;
    
}
- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
    
}
@end
