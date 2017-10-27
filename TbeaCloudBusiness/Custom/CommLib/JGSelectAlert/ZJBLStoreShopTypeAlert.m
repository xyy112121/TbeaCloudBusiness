//
//  ZJBLStoreShopTypeAlert.m
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/4/20.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import "ZJBLStoreShopTypeAlert.h"
#import "UIColor+JGHexColor.h"


@interface SelectAlertCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation SelectAlertCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithHexCode:@"#333333"];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end


@interface ZJBLStoreShopTypeAlert () {
    float alertHeight;//弹框整体高度，默认250
    float buttonHeight;//按钮高度，默认40
}


@property (nonatomic, assign) BOOL showCloseButton;//是否显示关闭按钮
@property (nonatomic, strong) UIView *alertView;//弹框视图
@property (nonatomic, strong) UITableView *selectTableView;//选择列表

@end


@implementation ZJBLStoreShopTypeAlert

+ (ZJBLStoreShopTypeAlert *)showWithTitle:(NSString *)title
                                   titles:(NSArray *)titles
                                deleGate1:(id<ActionDelegate>)delegate1
                              selectIndex:(SelectIndex)selectIndex
                              selectValue:(SelectValue)selectValue
                          showCloseButton:(BOOL)showCloseButton    {
    
    ZJBLStoreShopTypeAlert *alert = [[ZJBLStoreShopTypeAlert alloc] initWithTitle:title titles:titles selectIndex:selectIndex selectValue:selectValue deleGate1:delegate1 showCloseButton:showCloseButton];
    return alert;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 8;
        _alertView.layer.masksToBounds = YES;
    }
    return _alertView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.backgroundColor = [UIColor clearColor];
		[_closeButton setImage:LOADIMAGE(@"userclose", @"png") forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}


- (UIButton *)doneButton {
	if (!_doneButton) {
		_doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
		_doneButton.backgroundColor = [UIColor colorWithRed:0 green:170/255.0 blue:238/255.0 alpha:1];
		[_doneButton setTitle:@"确认" forState:UIControlStateNormal];
		[_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		_doneButton.titleLabel.font = [UIFont systemFontOfSize:16];
		_doneButton.layer.cornerRadius = 3.0f;
		_doneButton.clipsToBounds = YES;
		[_doneButton addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
	}
	return _doneButton;
}


- (UITableView *)selectTableView {
    if (!_selectTableView) {
        _selectTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		_selectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _selectTableView.delegate = self;
        _selectTableView.dataSource = self;
    }
    return _selectTableView;
}

- (instancetype)initWithTitle:(NSString *)title titles:(NSArray *)titles selectIndex:(SelectIndex)selectIndex selectValue:(SelectValue)selectValue deleGate1:(id<ActionDelegate>)delegate1 showCloseButton:(BOOL)showCloseButton {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        alertHeight = 250;
        buttonHeight = 50;
        
        self.titleLabel.text = title;
        _titles = titles;
        _selectIndex = [selectIndex copy];
        _selectValue = [selectValue copy];
        _showCloseButton = showCloseButton;
        _delegatehp = delegate1;
        [self addSubview:self.alertView];
        [self.alertView addSubview:self.titleLabel];
        [self.alertView addSubview:self.selectTableView];
		[self.alertView addSubview:self.doneButton];
        if (_showCloseButton) {
            [self.alertView addSubview:self.closeButton];
        }
        [self initUI];
        
        [self show];
    }
    return self;
}

- (void)show {
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.alertView.alpha = 0.0;
    [UIView animateWithDuration:0.1 animations:^{
        self.alertView.alpha = 1;
    }];
}

- (void)initUI {
    self.alertView.frame = CGRectMake(50, ([UIScreen mainScreen].bounds.size.height-alertHeight)/2.0-40, [UIScreen mainScreen].bounds.size.width-100, alertHeight);
    self.titleLabel.frame = CGRectMake(10, 5, _alertView.frame.size.width, 40);
	
	self.doneButton.frame = CGRectMake(10, _alertView.frame.size.height-buttonHeight, _alertView.frame.size.width-20, buttonHeight-10);
	
	
	
    float reduceHeight = buttonHeight;
    if (_showCloseButton) {
        self.closeButton.frame = CGRectMake(self.alertView.frame.size.width-30, 10,30, 30);
        reduceHeight = buttonHeight*2;
    }
    self.selectTableView.frame = CGRectMake(0, buttonHeight, _alertView.frame.size.width, _alertView.frame.size.height-reduceHeight);
	
	UIImageView *imageviewline1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 49, self.selectTableView.frame.size.width-20, 0.7)];
	imageviewline1.backgroundColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1];
	[self.alertView addSubview:imageviewline1];
	

}


#pragma UITableViewDelegate
//隐藏那些没有cell的线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
	UIView *view = [UIView new];
	view.backgroundColor = [UIColor clearColor];
	[tableView setTableFooterView:view];
}

-(void)viewDidLayoutSubviews
{
	if ([self.selectTableView respondsToSelector:@selector(setSeparatorInset:)]) {
		[self.selectTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
	}
	
	if ([self.selectTableView respondsToSelector:@selector(setLayoutMargins:)]) {
		[self.selectTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    float real = (alertHeight - buttonHeight)/(float)_titles.count;
//    if (_showCloseButton) {
//        real = (alertHeight - buttonHeight*2)/(float)_titles.count;
//    }
//    return real<=45 ? 45:real;
    
    return 45;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectcell"];
    if (!cell) {
        cell = [[SelectAlertCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectcell"];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	for(UIView *view in cell.contentView.subviews)
	{
		if(view.tag == 3079)
		[view removeFromSuperview];
	}
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(10, cell.contentView.frame.size.height-0.7, self.selectTableView.frame.size.width-20, 0.7)];
	imageviewline.tag = 3079;
	imageviewline.backgroundColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1];
	[cell.contentView addSubview:imageviewline];
	
    cell.titleLabel.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectIndex) {
        self.selectIndex(indexPath.row);
    }
    if (self.selectValue) {
        self.selectValue(_titles[indexPath.row]);
    }
	
	for(int i=0;i<100;i++)
	{
		NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
		SelectAlertCell *cell = [tableView cellForRowAtIndexPath:index];
		cell.titleLabel.textColor = [UIColor colorWithHexCode:@"#333333"];
	}
	
	SelectAlertCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	cell.titleLabel.textColor = COLORNOW(0, 170, 238);
//    [self closeAction];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
	DLog(@"pt====%f,%f",pt.x,pt.y);
    if (!CGRectContainsPoint([self.alertView frame], pt)) {
        [self closeAction];
    }
}

- (void)closeAction {
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)doneAction{
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if([_delegatehp respondsToSelector:@selector(DGClickselectItemDone:)])
        {
            [_delegatehp DGClickselectItemDone:nil];
        }
        
    }];
}

- (void)dealloc {
    //    NSLog(@"SelectAlert被销毁了");
}


@end
