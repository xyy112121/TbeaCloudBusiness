//
//  AndyDropDownList.m
//  AndyDropDownList
//
//  Created by 933 on 16/1/29.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "AndyDropDownList.h"

/**
 *  主屏的宽
 */
#define DEF_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

/**
 *  主屏的高
 */
#define DEF_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface AndyDropDownList ()
<UITableViewDataSource,
UITableViewDelegate>

@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,assign)CGFloat rowHeight;   // 行高
@property(nonatomic,strong)UIButton *button;    //从Controller传过来的控制器
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,assign)NSInteger index;    //记录选中行

@end


@implementation AndyDropDownList

-(id)initWithListDataSource:(NSArray *)array
                  rowHeight:(CGFloat)rowHeight
                       view:(UIView *)v
{
    self = [super initWithFrame:CGRectMake(0, 41, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    if (self)
    {
        self.arr = array;
        self.rowHeight = rowHeight;
        self.button = (UIButton *)v;
    }
    return self;
}

-(id)initWithListDataSource:(NSArray *)array
				  rowHeight:(CGFloat)rowHeight
					   view:(UIView *)v
					  Frame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.arr = array;
		self.rowHeight = rowHeight;
		self.button = (UIButton *)v;
	}
	return self;
}

-(UIView *)bgView
{
    if (!_bgView)
    {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 41, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _bgView;
}
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
-(NSArray *)arr
{
    if (!_arr)
    {
        _arr = [[NSArray alloc]init];
    }
    return _arr;
}
-(UIImageView *)arrow
{
    if (!_arrow)
    {
        _arrow = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 35, 10, 20, 20)];
        _arrow.image = [UIImage imageNamed:@"ico_make"];
    }
    return _arrow;
}
/**
 *   显示下拉列表
 */
-(void)showList
{
    [self addSubview:self.bgView];
	UIButton *buttonhide = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonhide.frame = self.bgView.frame;
	[buttonhide addTarget:self action:@selector(clickhiddenList) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:buttonhide];
	
    [self addSubview:self.tableView];
    [self.tableView reloadData];
    [UIView animateWithDuration:0.25f animations:^{
        self.bgView.alpha = 1;
        self.tableView.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, self.rowHeight * self.arr.count);
    }];
}

-(void)clickhiddenList
{
	if([self.delegate respondsToSelector:@selector(setAndyDropHideflag:)])
	{
		[self.delegate setAndyDropHideflag:nil];
	}
	[self hiddenList];
}

/**
 *  隐藏
 */
-(void)hiddenList
{
    [UIView animateWithDuration:0.25f animations:^{
        self.bgView.alpha = 0;
        self.tableView.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - UITableViewDelegateAndUITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.arr[indexPath.row];
	
	if([cell.textLabel.text isEqualToString:@"自定义"]||[cell.textLabel.text isEqualToString:@"用户类型"]||[cell.textLabel.text isEqualToString:@"地区选择"]||[cell.textLabel.text isEqualToString:@"区域选择"])
	{
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
    if (self.index == indexPath.row)
    {
        if ([cell.textLabel.text isEqualToString:self.button.titleLabel.text])
        {
            [cell addSubview:self.arrow];
        }
    }
    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark ----------------UITableView  表的选中方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hiddenList];
    self.index = indexPath.row;
    if ([self.delegate respondsToSelector:@selector(dropDownListParame:)])
    {
        [self.delegate dropDownListParame:self.arr[indexPath.row]];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.rowHeight;
}


@end
