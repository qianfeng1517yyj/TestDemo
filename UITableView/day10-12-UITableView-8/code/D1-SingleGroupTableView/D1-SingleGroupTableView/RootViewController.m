//
//  RootViewController.m
//  D1-SingleGroupTableView
//
//  Created by Jerry on 15/11/13.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
}
@end

@implementation RootViewController

- (void)dealloc
{
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
    _dataSource = [[NSMutableArray alloc] init];
    NSInteger number = arc4random()%20+30;
    for (NSInteger i=0; i<number; i++) {
        NSString *name = [NSString stringWithFormat:@"特工%.2ld号", i+1];
        [_dataSource addObject:name];
    }
}

- (void)createTableView
{
    CGSize size = self.view.frame.size;
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 20, size.width, size.height-20);
    
    //设置数据源代理
    _tableView.dataSource = self;
    
    //注册cell类型以及复用标识，注册后出列cell时无需判断
    //队列中有空闲cell直接返回，没有空闲cell按照此方法注册的创建新的cell
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
    //static int number = 0;
    
    //表格视图时通过一个复用队列来管理所有的cell，以节约内存
    //每次使用cell都从队列获取，若队列中有空闲的则直接返回
    //若没有则返回nil，这时需要用户自己创建新的cell
    
    //出列一个cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
#if 0   //若已注册，此处无需再判断
    //没有空闲的cell，需要用户创建，并指定复用标识
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
        number++;
        NSLog(@"number = %d", number);
    }
#endif
    //设置显示内容
    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}

@end
