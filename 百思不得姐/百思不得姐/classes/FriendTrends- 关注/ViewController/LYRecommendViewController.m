//
//  LYRecommendViewController.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/19.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYRecommendViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "LYRecommendCategory.h"
#import "LYRecommendCell.h"
#import "LYRecommendUser.h"
#import "LYRecommendUserCell.h"
#import <MJRefresh.h>


static NSString *LYCategoryID = @"category";
static NSString *LYSubCategoryID = @"subcategory";
@interface LYRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *subCategoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *catagoriesTableView;
/* 模型数组 */
@property (strong, nonatomic) NSArray * categories;
/* recommend user */
@property (strong, nonatomic) NSArray * recommendUsers;
/* clicked model */
@property (strong, nonatomic) LYRecommendCategory * clickedCategory;
/* 纪录最后一次请求 */
@property (strong, nonatomic) NSMutableDictionary * param;
/* request */
@property (strong, nonatomic) AFHTTPSessionManager * manager;


@end

@implementation LYRecommendViewController
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
    
    [self setUpTableView];
   
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    [self setUpRefresh];
    
    [self setUpCategories];
    
    
}
//加载左侧数据
- (void)setUpCategories
{
    /**
     *  开始请求数据，
     *  1、设置请求参数param 为一个字典可变
     *  2、发送请求。
     *  3、解析数据
     *
     */
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //解析数据
        //模拟一个蒙板
        [SVProgressHUD dismiss];
        //返回json数据
        self.categories = [LYRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.catagoriesTableView reloadData];
        
        [self.catagoriesTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        [self.subCategoryTableView.mj_header beginRefreshing];
        
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
        
    }];


}
//设置header 和 footer
- (void)setUpRefresh
{

    self.subCategoryTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.subCategoryTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
//    self.subCategoryTableView.footer.hidden = YES;


}
//右侧下拉刷新
- (void)loadNewUsers
{
    self.clickedCategory = self.categories[self.catagoriesTableView.indexPathForSelectedRow.row];
    
    self.clickedCategory.page = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(self.clickedCategory.id);
    params[@"page"] = @(self.clickedCategory.page);
    self.param = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task,id responseObject){
        
        //为了避免每次请求都会将添加到模型数组中，导致数组变大。每次刷新的时候应该把之前保存的模型数组删除
        [self.clickedCategory.usrs removeAllObjects];
        //获得数据的总数
        self.clickedCategory.total = [responseObject[@"total"] integerValue];
        //获得更新数据模型数组
        [self.clickedCategory.usrs addObjectsFromArray:[LYRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        
        if (self.param != params)  return ;
        
        [self.subCategoryTableView reloadData];
        //停止刷新,只有显示的表才考虑结束刷新。之前的请求不用考虑结束刷新
        [self.subCategoryTableView.header endRefreshing];
        
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask *task, NSError *error){
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 结束刷新
        [self.subCategoryTableView.header endRefreshing];
        
    }];

}
//右侧上拉加载跟多
- (void)loadMoreUsers
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(self.clickedCategory.id);
    
    params[@"page"] = @(++self.clickedCategory.page);
    self.param = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task,id responseObject){
        
//        self.clickedCategory.usrs = [LYRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
 
        
//        [self.clickedCategory.usrs arrayByAddingObjectsFromArray:[LYRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        
        [self.clickedCategory.usrs addObjectsFromArray:[LYRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        
        if (self.param != params) return ;
        
        [self.subCategoryTableView reloadData];
        
        //停止刷新,只有显示的表才考虑结束刷新。之前的请求不用考虑结束刷新
        [self.subCategoryTableView.header endRefreshing];
        
        [self checkFooterState];
        //　下面方法可用
//        [self.subCategoryTableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error){
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 结束刷新
        [self.subCategoryTableView.header endRefreshing];
        
    }];





}
//设置基本信息子视图
- (void)setUpTableView
{
//    self.title = @"推荐关注";
    self.navigationItem.title = @"推荐关注";
    [self.catagoriesTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYRecommendCell class])  bundle:nil]forCellReuseIdentifier:LYCategoryID];
    
    
    [self.subCategoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:LYSubCategoryID];
    
    self.subCategoryTableView.rowHeight = 70;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.subCategoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
    ;
    self.catagoriesTableView.contentInset = self.subCategoryTableView.contentInset;
    //    [self.catagoriesTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:LYCategoryID];
    //删除tableview多余空白行
    //    self.catagoriesTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //    self.catagoriesTableView.dataSource = self;


}
- (void)checkFooterState
{
    self.subCategoryTableView.footer.hidden = (self.clickedCategory.usrs.count == 0);
    
    if (self.clickedCategory.usrs.count == self.clickedCategory.total)
    {
        [self.subCategoryTableView.footer noticeNoMoreData];
    }else
    {
        [self.subCategoryTableView.footer endRefreshing];
    
    }
    
    
}
#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.catagoriesTableView) return self.categories.count;

    [self checkFooterState];

    LYRecommendCategory *c = self.categories[self.catagoriesTableView.indexPathForSelectedRow.row];
    return c.usrs.count;
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.catagoriesTableView) {
        
        LYRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:LYCategoryID];
        
        LYRecommendCategory *category = self.categories[indexPath.row];
        
        cell.category = category;
        return cell;
    }else
    {
        LYRecommendCategory *c = self.categories[self.catagoriesTableView.indexPathForSelectedRow.row];
        
        LYRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:LYSubCategoryID];
        
        cell.user = c.usrs[indexPath.row];
        
        return cell;
    }
}
#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYRecommendCategory *category = self.categories[indexPath.row];
    self.clickedCategory = category;
    if (category.usrs.count)
    {
        
         [self.subCategoryTableView reloadData];
        
    }else {
        // 进入了右侧界面，立刻刷新
         [self.subCategoryTableView reloadData];
        
        //开始下拉刷新状态
        
        [self.subCategoryTableView.header beginRefreshing];
       

    }
}
- (void)dealloc
{

    [self.manager.operationQueue cancelAllOperations];

}
/**
 1.目前只能显示1页数据
 2.重复发送请求
 3.网络慢带来的细节问题
 */
@end
