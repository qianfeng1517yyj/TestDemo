//
//  RootViewController.m
//  D4-CustomTableViewCell
//
//  Created by Jerry on 15/11/17.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    //用于记录偏移量
    CGFloat _lastContentOffset;
    //用于记录滑动方向(YES:向下，NO:向上)
    BOOL _isDownward;
}
@end

@implementation RootViewController

- (void)dealloc
{
    [_tableView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加切换按钮
    [self createButton];
    //创建tableView
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createButton
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(buttonHandle:)];
    self.navigationItem.rightBarButtonItem = [item autorelease];
}

- (void)buttonHandle:(UIBarButtonItem *)item
{
    BOOL status = !_tableView.isEditing;
    [_tableView setEditing:status animated:YES];
    item.title = (status==YES)?@"Done":@"Edit";
}

- (void)createTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height-64);
    
    //设置代理
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        /*cell风格                    detail  imageView
         UITableViewCellStyleDefault  不支持     支持
         UITableViewCellStyleValue1    支持      支持
         textLabal与detailTextLabel水平布局
         UITableViewCellStyleValue2    支持     不支持
         UITableViewCellStyleSubtitle  支持      支持
         textLabal与detailTextLabel垂直布局
         */
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
        //设置detailTextLabel
        cell.detailTextLabel.text = @"detail";
        //设置imageView
        cell.imageView.image = [UIImage imageNamed:@"colors"];
    /*附加视图系统类型，设置附加视图后失效
     UITableViewCellAccessoryDisclosureIndicator    >
     UITableViewCellAccessoryDetailDisclosureButton ¡>
     UITableViewCellAccessoryCheckmark              √
     UITableViewCellAccessoryDetailButton           ¡
     */
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        //编辑状态附加视图类型，设置附加视图后失效
        cell.editingAccessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        //设置附加视图
        UIImage *accessoryImage = [UIImage imageNamed:@"next.jpg"];
        UIImageView *accessoryView = [[UIImageView alloc] initWithImage:accessoryImage];
        cell.accessoryView = [accessoryView autorelease];
        //设置编辑状态附加视图
        UIImage *editingImage = [UIImage imageNamed:@"prev.jpg"];
        UIImageView *editingView = [[UIImageView alloc] initWithImage:editingImage];
        cell.editingAccessoryView = [editingView autorelease];
        //设置背景色
        cell.backgroundColor = [UIColor greenColor];
        /*设置选中风格
         UITableViewCellSelectionStyleNone      无色
         UITableViewCellSelectionStyleBlue      灰色
         UITableViewCellSelectionStyleGray      灰色
         UITableViewCellSelectionStyleDefault   灰色
         */
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        //没有选中状态背景的设置，可以设置选中背景视图
        UIView *view = [[UIView alloc] init];
        //只有颜色有效
        view.backgroundColor = [UIColor redColor];
        cell.selectedBackgroundView = [view autorelease];
    }
    //设置随机的内容颜色
#define Random  arc4random()%256/255.0
    cell.contentView.backgroundColor = [UIColor colorWithRed:Random green:Random blue:Random alpha:1.0];
    
    //设置textLable
    cell.textLabel.text = [NSString stringWithFormat:@"第%.2ld行", indexPath.row+1];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //点击cell右边附加视图时回调，button风格时才回调
    NSLog(@"%ld %ld",indexPath.section,indexPath.row);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > _lastContentOffset) {
        //向上滑
        _isDownward = NO;
    } else if (offsetY < _lastContentOffset) {
        //向下滑
        _isDownward = YES;
    }
    //记录本次偏移量
    _lastContentOffset = offsetY;
}

//显示效果在此处处理
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //锚点：旋转的轴心点，默认(0.5,0.5)
    //位置：锚点在父视图上的位置
    CGRect frame = cell.frame;
    //设置锚点
    cell.layer.anchorPoint = CGPointMake(0, _isDownward);
    //设置锚点在父视图位置
    cell.layer.position = CGPointMake(0, frame.origin.y+_isDownward*frame.size.height);
    //设置旋转角度90˚(±PI/2)
    int flag = (_isDownward==YES) ? -1 : 1;
    cell.layer.transform = CATransform3DMakeRotation(flag*M_PI_2, 0, 0, 1);
    cell.alpha = 0;
    //动画显示出来
    [UIView animateWithDuration:1 animations:^{
        cell.alpha = 1.0;
        cell.layer.transform = CATransform3DIdentity;
    }];
}

@end





