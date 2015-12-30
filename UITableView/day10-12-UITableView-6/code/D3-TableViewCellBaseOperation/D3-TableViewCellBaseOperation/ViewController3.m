//
//  ViewController3.m
//  D3-TableViewCellBaseOperation
//
//  Created by Jerry on 15/11/16.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import "ViewController3.h"

@interface ViewController3 ()
{
    NSMutableArray *_selectedIndexPaths;
}
@end

@implementation ViewController3

- (void)dealloc
{
    [_selectedIndexPaths release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _selectedIndexPaths = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//重写父类的方法
- (void)rightButtonHandle:(UIBarButtonItem *)item
{
    [super rightButtonHandle:item];
    
    if (self.tableView.isEditing) {
        //每次开始多选，先清空上次记录
        [_selectedIndexPaths removeAllObjects];
    } else {
        [self.dataModel deleteRowsAtIndexPaths:_selectedIndexPaths];
        [self.tableView deleteRowsAtIndexPaths:_selectedIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        //刷新数据
        [self.tableView reloadData];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //相或之后，会是多选样式
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //将选中的行的indexPath保存到数组中
    [_selectedIndexPaths addObject:indexPath];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当取消选中时，应该将已保存到数组中的对象删除
    [_selectedIndexPaths removeObject:indexPath];
}

@end
