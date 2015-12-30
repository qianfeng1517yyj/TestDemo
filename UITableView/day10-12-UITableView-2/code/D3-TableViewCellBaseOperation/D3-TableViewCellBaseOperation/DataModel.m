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

- (NSString *)contentOfRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _dataArray[indexPath.section][indexPath.row];
}

- (void)insertRow:(NSString *)content atIndexPath:(NSIndexPath *)index
{
    [_dataArray[index.section] insertObject:content atIndex:index.row];
}

@end
