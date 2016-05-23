//
//  LYWordViewController.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/22.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYWordViewController.h"
#import <AFNetworking.h>
#import "LYWord.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>

@interface LYWordViewController ()
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

@implementation LYWordViewController
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
    
    [self setUpRefresh];
    
    
}
- (void)setUpRefresh
{
    self.tableView.header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewWord)];
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreWord)];


}
- (void)loadNewWord
{
     [self.tableView.footer endRefreshing];
    
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        params[@"a"] = @"list";
        params[@"c"] = @"data";
        params[@"type"] = @"29";
        self.param = params;
        [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task,id responseObject){
            if (self.param != params) return ;
            
            [self.tableView.header endRefreshing];
            
            self.words = [LYWord mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            self.maxtime = responseObject[@"info"][@"maxtime"];
            
            [self.tableView reloadData];
              self.page = 0;
         
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
    params[@"type"] = @"29";
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
    
    
    return self.words.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYWord *word = self.words[indexPath.row];
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
      
    }
    
    cell.detailTextLabel.text = word.text;
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:word.profile_image]];
    
    cell.textLabel.text = word.sceen_name;
    
    return cell;
}

- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];

}
@end
