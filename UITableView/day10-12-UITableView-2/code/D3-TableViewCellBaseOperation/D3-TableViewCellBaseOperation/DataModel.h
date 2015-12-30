//
//  DataModel.h
//  D3-TableViewCellBaseOperation
//
//  Created by Jerry on 15/11/16.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataModel : NSObject

//返回区的个数
- (NSInteger)numberOfSections;
//返回指定区的行数
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
//指定区指定行的内容
- (NSString *)contentOfRowAtIndexPath:(NSIndexPath *)indexPath;
//向指定的区插入一行内容
- (void)insertRow:(NSString *)content atIndexPath:(NSIndexPath *)index;

@end
