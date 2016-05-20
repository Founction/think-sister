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


static NSString *LYCategoryID = @"category";
static NSString *LYSubCategoryID = @"subcategory";
@interface LYRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *subCategoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *catagoriesTableView;
/* 模型数组 */
@property (strong, nonatomic) NSArray * categories;
/* recommend user */
@property (strong, nonatomic) NSArray * recommendUsers;

@end

@implementation LYRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
   
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
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
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //解析数据
        //模拟一个蒙板
        [SVProgressHUD dismiss];
        //返回json数据
        self.categories = [LYRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.catagoriesTableView reloadData];
        
    
    
    }failure:^(NSURLSessionDataTask *task, NSError *error){
    
    
    
    }];
    
}
- (void)setUpTableView
{
    [self.catagoriesTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYRecommendCell class])  bundle:nil]forCellReuseIdentifier:LYCategoryID];
    
    
    [self.subCategoryTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:LYSubCategoryID];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.subCategoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
    ;
    self.catagoriesTableView.contentInset = self.subCategoryTableView.contentInset;
    //    [self.catagoriesTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:LYCategoryID];
    //删除tableview多余空白行
    //    self.catagoriesTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //    self.catagoriesTableView.dataSource = self;


}
#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.catagoriesTableView)
    {
        return self.categories.count;
    }
    else{
        return self.recommendUsers.count;
    }
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
        LYRecommendUser *category = self.recommendUsers[indexPath.row];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LYSubCategoryID];
        
        cell.textLabel.text = category.screen_name;
        
        cell.textLabel.frame = CGRectMake(0, 0, 20, 20);
    
        return cell;
    }
}
#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYRecommendCategory *category = self.categories[indexPath.row];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task,id responseObject){
    
        self.recommendUsers = [LYRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.subCategoryTableView reloadData];
    
    } failure:^(NSURLSessionDataTask *task, NSError *error){
    
    
    }];

}

@end
