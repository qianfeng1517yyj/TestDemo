//
//  ViewController4.m
//  D3-TableViewCellBaseOperation
//
//  Created by Jerry on 15/11/16.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import "ViewController4.h"

@interface ViewController4 ()

@end

@implementation ViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if ([sourceIndexPath isEqual:destinationIndexPath]) {
        return;
    }
    [self.dataModel moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

@end
