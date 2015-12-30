//
//  DataModel.m
//  D3-TableViewCellBaseOperation
//
//  Created by Jerry on 15/11/16.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import "DataModel.h"

@interface DataModel ()
{
    NSMutableArray *_dataArray;
    NSArray *_sectionNames;
}
@end

@implementation DataModel

- (void)dealloc
{
    [_dataArray release];
    [_sectionNames release];
    [super dealloc];
}

- (instancetype)init
{
    if (self = [super init]) {
        _dataArray = [[NSMutableArray alloc] init];
        _sectionNames = [[NSArray alloc] initWithArray:@[@"女神",@"男神",@"屌丝",@"欧巴"]];
        for (NSString *sectionName in _sectionNames) {
            NSMutableArray *section = [NSMutableArray array];
            NSInteger number = arc4random()%20+10;
            for (NSInteger i=0; i<number; i++) {
                NSString *name = [NSString stringWithFormat:@"%@%.2ld号", sectionName, i+1];
                [section addObject:name];
            }
            //将每一组放入数组中
            [_dataArray addObject:section];
        }
    }
    return self;
}

- (NSInteger)numberOfSections
{
    return _sectionNames.count;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray[section] count];
}

- (NSString *)titleOfSection:(NSInteger)section
{
    return _sectionNames[section];
}

- (NSString *)contentOfRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _dataArray[indexPath.section][indexPath.row];
}

- (void)insertRow:(NSString *)content atIndexPath:(NSIndexPath *)index
{
    [_dataArray[index.section] insertObject:content atIndex:index.row];
}

- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_dataArray[indexPath.section] removeObjectAtIndex:indexPath.row];
}

- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths
{
    //先将数组排序(默认从小到大)
    NSArray *array = [indexPaths sortedArrayUsingSelector:@selector(compare:)];
    //然后倒序删除(后面的不会影响前面元素的顺序)
    for (NSInteger i=array.count-1; i>=0; i--) {
        [self deleteRowAtIndexPath:array[i]];
    }
}

- (void)moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //先取出源数据，为确保万一需要retain一次
    NSString *source = [[self contentOfRowAtIndexPath:sourceIndexPath] retain];
    //删除源数据
    [self deleteRowAtIndexPath:sourceIndexPath];
    //然后再将源数据插入目标地址
    [self insertRow:[source autorelease] atIndexPath:destinationIndexPath];
}

- (NSArray *)searchWithText:(NSString *)searchText
{
    NSMutableArray *result = [NSMutableArray array];
    for (NSArray *section in _dataArray) {
        for (NSString *content in section) {
            if ([content containsString:searchText]) {
                //只要包含搜索内容，就保存到数组
                [result addObject:content];
            }
        }
    }
    return result;
}

@end
