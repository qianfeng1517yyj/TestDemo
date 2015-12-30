//
//  ViewController6.m
//  D3-TableViewCellBaseOperation
//
//  Created by Jerry on 15/11/16.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import "ViewController6.h"

@interface ViewController6 ()<UISearchBarDelegate>
{
    NSMutableArray *_searchResultArray;
    UISearchBar *_searchBar;
    UISearchDisplayController *_searchDC;
    BOOL _isHidden;
}
@end

@implementation ViewController6

- (void)dealloc
{
    [_searchResultArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建存放搜索结果的数组
    _searchResultArray = [[NSMutableArray alloc] init];
    //创建场景
    [self createScene];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createScene
{
    //将tableView下移44，用于布局searchBar
//    CGRect frame = self.tableView.frame;
//    frame.origin.y += 44;
//    frame.size.height -= 44;
//    self.tableView.frame = frame;
    
    //创建searchBar
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, VIEW_WIDTH, 44)];
    //显示取消按钮
    _searchBar.showsCancelButton = YES;
    //设置占位文本
    _searchBar.placeholder = @"搜索偶像";
    //设置代理
    _searchBar.delegate = self;
    //设置为表格视图的头视图
    self.tableView.tableHeaderView = _searchBar;
    
    //创建searchDisplayController，并绑定搜索条及内容显示的视图控制器
    _searchDC = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    //设置代理
    _searchDC.searchResultsDataSource = self;
    //注册cell类型及复用标识
    [_searchDC.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"searchCellId"];
}

- (BOOL)prefersStatusBarHidden
{
    return _isHidden;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _isHidden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    //searchBar.transform = CGAffineTransformMakeTranslation(0, -64);
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _isHidden = NO;
    [self setNeedsStatusBarAppearanceUpdate];
    //searchBar.transform = CGAffineTransformIdentity;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    _searchResultArray.array = [self.dataModel searchWithText:searchText];
    [_searchDC.searchResultsTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView) {
        return [self.dataModel numberOfSections];
    } else if (tableView == _searchDC.searchResultsTableView) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return [self.dataModel numberOfRowsInSection:section];
    } else if (tableView == _searchDC.searchResultsTableView) {
        return _searchResultArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    } else if (tableView == _searchDC.searchResultsTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCellId"];
        cell.textLabel.text = _searchResultArray[indexPath.row];
        return cell;
    }
    return nil;
}

@end
