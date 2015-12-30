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
        //贴图
        UIImage *image = [[UIImage imageNamed:@"unfold"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_button setImage:image forState:UIControlStateNormal];
        _button.frame = CGRectMake(0, 0, 200, frame.size.height);
        //设置标题
        [_button setTitle:title forState:UIControlStateNormal];
        //内容左对齐
        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //添加事件
        [_button addTarget:self action:@selector(clickHandle:) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor = [UIColor cyanColor];
        [self addSubview:_button];
    }
    return self;
}

- (void)clickHandle:(UIButton *)button
{
    if (self.block) {
        self.block();
    }
}

- (void)updateWithStatus:(BOOL)status
{
    NSString *name = (status==YES)?@"fold":@"unfold";
    UIImage *image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_button setImage:image forState:UIControlStateNormal];
}

@end
