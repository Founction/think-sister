//
//  LYAllViewController.m
//  百思不得姐
//
//  Created by 李胜营 on 16/5/22.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LYAllViewController.h"

@interface LYAllViewController ()

@end

@implementation LYAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor blueColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@----%zd", [self class], indexPath.row];
    
    return cell;
}


@end
