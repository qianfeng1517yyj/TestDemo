//
//  SectionHeaderView.m
//  D3-TableViewCellBaseOperation
//
//  Created by Jerry on 15/11/16.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import "SectionHeaderView.h"

@interface SectionHeaderView ()
{
    UIButton *_button;
}
@end

@implementation SectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        
    }
    return self;
}

@end
