//
//  RootViewController.m
//  D3-TableViewCellBaseOperation
//
//  Created by Jerry on 15/11/16.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import "RootViewController.h"
#import "BaseViewController.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_dataSource;
}
@end

@implementation RootViewController

- (void)dealloc
{
    [_tableView release];
    [_dataSource release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航标题
    self.navigationItem.title = @"Cell基本操作";
    //创建数据源
    _dataSource = [[NSArray alloc] initWithArray:@[@"添加一行",@"删除一行",@"删除多行",@"移动一行",@"展开关闭",@"搜索Cell"]];
    //创建表格视图
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 64, VIEW_WIDTH, VIEW_HEIGHT-64);
    //设置代理
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    //注册复用标识
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    
    [self.view addSubview:_tableView];
}

#pragma mark - 数据源代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    //设置cell附加视图类型
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}

#pragma mark - 本身代理

//选中某一行时回调此方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //拼接视图控制器的名字
    NSString *name = [NSString stringWithFormat:@"ViewController%ld", indexPath.row + 1];
    //根据名字创建Class
    Class cls = NSClassFromString(name);
    //创建视图控制器
    BaseViewController *bvc = [[cls alloc] init];
    //设置标题
    bvc.navigationItem.title = _dataSource[indexPath.row];
    //压入导航控制器
    [self.navigationController pushViewController:[bvc autorelease] animated:YES];
}

@end
