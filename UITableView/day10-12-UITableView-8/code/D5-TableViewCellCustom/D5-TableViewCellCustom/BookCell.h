//
//  BookCell.h
//  D5-TableViewCellCustom
//
//  Created by Jerry on 15/11/17.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookModel.h"

@interface BookCell : UITableViewCell

- (void)updateWithData:(BookModel *)book;

@end
