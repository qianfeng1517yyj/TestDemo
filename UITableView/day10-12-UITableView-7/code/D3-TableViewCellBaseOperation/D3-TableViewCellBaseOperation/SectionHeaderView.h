//
//  SectionHeaderView.h
//  D3-TableViewCellBaseOperation
//
//  Created by Jerry on 15/11/16.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BLOCK)(void);

@interface SectionHeaderView : UIView

@property (nonatomic, copy)BLOCK block;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

- (void)updateWithStatus:(BOOL)status;

@end
