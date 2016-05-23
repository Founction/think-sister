//
//  LYRecommendTagsViewController.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/22.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYRecommendTagsViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "LYRecommendTag.h"
#import <MJExtension.h>
#import "LYRecommendTagCell.h"
#import <SVProgressHUD.h>

static NSString *tagID = @"reuseRecommendTag";
@interface LYRecommendTagsViewController ()
/* 模型数组 */
@property (strong, nonatomic) NSArray * tags;
/* request */
@property (strong, nonatomic)  AFHTTPSessionManager* manager;
@end

@implementation LYRecommendTagsViewController
- (AFHTTPSessionManager *)manager
{
    if (_manager == nil)
    {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (NSArray *)tags
{
    if (_tags == nil) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];

    [self setUpTags];
    
    
}
- (void)setUpTags
{
    //设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"c"] = @"topic";
    params[@"action"] = @"sub";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task,id responseObject){
        
        self.tags = [LYRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task,NSError *error){
        
        [SVProgressHUD showErrorWithStatus:@"加载错误"];
        
    }];

}
- (void)setUpTableView
{
    self.title = @"推荐关注";
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass ([LYRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:tagID];
    
    self.tableView.rowHeight = 70;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = LYGlobleBg;


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:tagID forIndexPath:indexPath];
    
    LYRecommendTag *recommendTag = self.tags[indexPath.row];
    
    cell.recommendTag = recommendTag;
    
    return cell;
}

- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];


}
@end
