//
//  BookCell.m
//  D5-TableViewCellCustom
//
//  Created by Jerry on 15/11/17.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import "BookCell.h"

@interface BookCell ()

@property (nonatomic, retain)UIImageView *iconView;
@property (nonatomic, retain)UILabel *titleLabel;
@property (nonatomic, retain)UILabel *detailLabel;
@property (nonatomic, retain)UILabel *priceLabel;

@end

@implementation BookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //创建子视图
        _iconView = [[UIImageView alloc] init];
        _titleLabel = [[UILabel alloc] init];
        _detailLabel = [[UILabel alloc] init];
        _priceLabel = [[UILabel alloc] init];
        //设置背景色
        self.titleLabel.backgroundColor = [UIColor redColor];
        self.detailLabel.backgroundColor = [UIColor greenColor];
        self.priceLabel.backgroundColor = [UIColor blueColor];
        //添加到contentView
        [self.contentView addSubview:_iconView];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_detailLabel];
        [self.contentView addSubview:_priceLabel];
    }
    //这里frame为{{0, 0}, {320, 44}}
    //NSLog(@"frame:%@", NSStringFromCGRect(self.frame));
    //[self setNeedsLayout];
    return self;
}

- (void)layoutSubviews
{
    //NSLog(@"frame:%@", NSStringFromCGRect(self.frame));
    //需要调用父类的方法
    [super layoutSubviews];
    
    CGSize size = self.contentView.frame.size;
    CGFloat gap = 5;
    CGFloat height = size.height - 2*gap;
    //布局子视图
    self.iconView.frame = CGRectMake(gap, gap, height, height);
    self.titleLabel.frame = CGRectMake(size.height, gap, size.width-size.height-gap, height/3);
    self.detailLabel.frame = CGRectMake(size.height, gap+height/3, size.width-size.height-gap, height/3);
    self.priceLabel.frame = CGRectMake(size.height, gap+height*2/3, size.width-size.height-gap, height/3);
}

- (void)updateWithData:(BookModel *)book
{
    self.iconView.image = [UIImage imageNamed:book.icon];
    self.titleLabel.text = [@"书名:" stringByAppendingString:book.title];
    self.detailLabel.text = [@"详情:" stringByAppendingString:book.detail];
    self.priceLabel.text = [@"价格:" stringByAppendingString:book.price];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
