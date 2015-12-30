//
//  ViewController5.m
//  D3-TableViewCellBaseOperation
//
//  Created by Jerry on 15/11/16.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import "ViewController5.h"

@interface ViewController5 ()
{
    //用于记录每个组的展开关闭状态(@0关闭，@1展开)
    NSMutableArray *_sectionsStatus;
}
@end

@implementation ViewController5

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = nil;
    //创建记录状态的数组并初始化
    _sectionsStatus = [[NSMutableArray alloc] init];
    for (NSUInteger i=0; i<[self.dataModel numberOfSections]; i++) {
        //默认为关闭状态
        [_sectionsStatus addObject:@0];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //若是关闭状态，个数返回0
    if ([_sectionsStatus[section] isEqualToNumber:@0]) {
        return 0;
    }
    //若是展开状态，个数是真实的
    return [self.dataModel numberOfRowsInSection:section];
}

@end
