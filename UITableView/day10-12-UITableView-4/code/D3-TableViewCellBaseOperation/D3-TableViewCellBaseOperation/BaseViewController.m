//
//  BaseViewController.m
//  D3-TableViewCellBaseOperation
//
//  Created by Jerry on 15/11/16.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)dealloc
{
    self.tableView = nil;
    self.dataModel = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:Random green:Random blue:Random alpha:1.0];
    //导航条上添加按钮
    [self addButton];
    //创建数据源
    _dataModel = [[DataModel alloc] init];
    //创建表格式图
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addButton
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonHandle:)];
    self.navigationItem.rightBarButtonItem = [item autorelease];
}

- (void)rightButtonHandle:(UIBarButtonItem *)item
{
    if (self.tableView.isEditing) {
        [self.tableView setEditing:NO animated:YES];
        item.title = @"Edit";
    } else {
        [self.tableView setEditing:YES animated:YES];
        item.title = @"Done";
    }
}

- (void)createTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView = [[UITableView alloc] init];
    self.tableView.frame = CGRectMake(0, 64, VIEW_WIDTH, VIEW_HEIGHT-64);
    
    //设置代理
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //注册cell类型及复用标识
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - 数据源代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataModel numberOfSections];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataModel numberOfRowsInSection:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    
    cell.textLabel.text = [self.dataModel contentOfRowAtIndexPath:indexPath];
    
    return cell;
}

@end
