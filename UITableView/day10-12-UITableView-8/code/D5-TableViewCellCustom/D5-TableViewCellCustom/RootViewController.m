//
//  RootViewController.m
//  D5-TableViewCellCustom
//
//  Created by Jerry on 15/11/17.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import "RootViewController.h"
#import "BookModel.h"
#import "BookCell.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
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

    //设置导航
    [self setNavigation];
    //创建数据源
    [self createDataSource];
    //创建表格视图
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavigation
{
    //设置标题
    self.navigationItem.title = @"Cell定制";
    //取消对滚动视图的影响
    self.automaticallyAdjustsScrollViewInsets = NO;
    //添加按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(buttonHandle:)];
    self.navigationItem.rightBarButtonItem = [item autorelease];
}

- (void)buttonHandle:(UIBarButtonItem *)item
{
#if 1
    if (_tableView.isEditing == YES) {
        [_tableView setEditing:NO animated:YES];
        item.title = @"Edit";
    } else {
        [_tableView setEditing:YES animated:YES];
        item.title = @"Done";
    }
#else
    BOOL status = !_tableView.isEditing;
    [_tableView setEditing:status animated:YES];
    item.title = (status==YES) ? @"Done" : @"Edit";
#endif
}

- (void)createDataSource
{
    _dataSource = [[NSMutableArray alloc] init];
    //解析plist文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"books" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    //遍历数组，解析并保存数据
    for (NSDictionary *dic in array) {
        //创建数据模型
        BookModel *book = [[BookModel alloc] init];
        //填充内容
        book.title = dic[@"title"];
        book.detail = dic[@"detail"];
        book.price = dic[@"price"];
        book.icon = dic[@"icon"];
        //保存数据模型
        [_dataSource addObject:[book autorelease]];
    }
}

- (void)createTableView
{
    CGSize size = self.view.frame.size;
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 64, size.width, size.height-64);
    
    //设置代理
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    //注册cell类型及复用标识
    [_tableView registerClass:[BookCell class] forCellReuseIdentifier:@"cellId"];
    
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    
    BookModel *book = _dataSource[indexPath.row];
    [cell updateWithData:book];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

@end








