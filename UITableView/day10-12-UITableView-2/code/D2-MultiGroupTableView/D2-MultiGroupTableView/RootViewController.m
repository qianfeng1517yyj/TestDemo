//
//  RootViewController.m
//  D2-MultiGroupTableView
//
//  Created by Jerry on 15/11/13.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_sectionNames;
    NSMutableArray *_dataSource;
    UITableView *_tableView;
}
@end

@implementation RootViewController

- (void)dealloc
{
    [_sectionNames release];
    [_dataSource release];
    [_tableView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建数据源
    [self createDataSource];
    //创建表格视图
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createDataSource
{
    _sectionNames = [[NSArray alloc] initWithArray:@[@"特工",@"杀手",@"城管",@"大妈"]];
    _dataSource = [[NSMutableArray alloc] init];
    
    for (NSUInteger i=0; i<_sectionNames.count; i++) {
        NSMutableArray *section = [NSMutableArray array];
        NSInteger number = arc4random()%20+10;
        for (NSInteger j=0; j<number; j++) {
            NSString *name = [NSString stringWithFormat:@"%@%.2ld", _sectionNames[i], j+1];
            [section addObject:name];
        }
        [_dataSource addObject:section];
    }
}

- (void)createTableView
{
    CGSize size = self.view.frame.size;
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 20, size.width, size.height-20);
    
    //设置数据源代理
    _tableView.dataSource = self;
    //设置本身的代理
    _tableView.delegate = self;
    
    //注册cell类型及复用标识
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    
    [self.view addSubview:_tableView];
}

#pragma mark - 数据源代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionNames.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    
    //设置内容
    cell.textLabel.text = _dataSource[indexPath.section][indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    //label.frame = CGRectMake(0, 0, 200, 44);
    label.text = _sectionNames[section];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor grayColor];
    return [label autorelease];
}

@end
