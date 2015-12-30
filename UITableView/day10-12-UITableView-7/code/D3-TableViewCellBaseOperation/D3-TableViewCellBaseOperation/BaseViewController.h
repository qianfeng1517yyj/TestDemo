//
//  BaseViewController.h
//  D3-TableViewCellBaseOperation
//
//  Created by Jerry on 15/11/16.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

@interface BaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)DataModel *dataModel;

- (void)rightButtonHandle:(UIBarButtonItem *)item;

@end
