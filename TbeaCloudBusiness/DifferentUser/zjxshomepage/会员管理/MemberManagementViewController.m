//
//  MemberManagementViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/22.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#define TITLES @[@"实名认证",@"添加用户"]

#import "MemberManagementViewController.h"

@interface MemberManagementViewController ()

@end

@implementation MemberManagementViewController
- (void)viewDidLoad {
	[super viewDidLoad];
	[self initview];
	
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	button.layer.borderColor = [UIColor clearColor].CGColor;
	[button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
	button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
	[button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	
	UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
	UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
	[buttonright setImage:LOADIMAGE(@"morepointwhite", @"png") forState:UIControlStateNormal];
	[buttonright addTarget:self action: @selector(Clickmorefunction:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewright addSubview:buttonright];
	buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
	
	// Do any additional setup after loading the view.
}

#pragma mark 页面布局

-(void)initview
{
	self.title = @"会员列表";
	self.view.backgroundColor = COLORNOW(235, 235, 235);
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[self addtabviewheader];
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 130, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight-130)];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	
}

-(void)addtabviewheader
{
	UIView *tabviewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
	tabviewheader.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tabviewheader];
	[tabviewheader addSubview:[self searchbarview]];
	UIView *viewcash = [self cashdataview];
	[tabviewheader addSubview:viewcash];
}

-(UIView *)searchbarview
{
	UIView *viewsearch = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
	viewsearch.backgroundColor = COLORNOW(0, 170, 238);
	
	SearchTextFieldView *searchtext = [[SearchTextFieldView alloc] initWithFrame:CGRectMake(40, 10, SCREEN_WIDTH-60, 30) Pastr:@"扫码返利查询"];
	searchtext.delegate1 = self;
	[viewsearch addSubview:searchtext];
	
	return viewsearch;
	
	
}

//提现数据
-(UIView *)cashdataview
{
	UIView *viewcash = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 80)];
	viewcash.backgroundColor = [UIColor whiteColor];
	
	UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 20)];
	lable.text = @"数量";
	lable.font = FONTMEDIUM(15.0f);
	lable.textColor = [UIColor blackColor];
	lable.backgroundColor = [UIColor clearColor];
	[viewcash addSubview:lable];
	
	
	UILabel *lablenumber = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150, 10, 130, 20)];
	lablenumber.text = @"5647";
	lablenumber.font = FONTMEDIUM(15.0f);
	lablenumber.textColor = [UIColor blackColor];
	lablenumber.backgroundColor = [UIColor clearColor];
	lablenumber.textAlignment = NSTextAlignmentRight;
	[viewcash addSubview:lablenumber];
	
	UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 0.7)];
	imageline.backgroundColor = COLORNOW(220, 220, 220);
	[viewcash addSubview:imageline];
	
	UIImageView *imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 79.3, SCREEN_WIDTH, 0.7)];
	imageline1.backgroundColor = COLORNOW(220, 220, 220);
	[viewcash addSubview:imageline1];
	
	float widthnow = (SCREEN_WIDTH-20)/2;
	//用户
	ButtonItemLayoutView *buttonitemuser = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, XYViewBottom(imageline), widthnow, 40)];
	[buttonitemuser.button addTarget:self action:@selector(ClickSelectUser:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemuser.tag = EnMemberMangerSelectItem1;
	[buttonitemuser updatebuttonitem:EnButtonTextLeft TextStr:@"用户" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrowgrayunder", @"png")];
	[viewcash addSubview:buttonitemuser];
	
	//地区
	ButtonItemLayoutView *buttonitemarea = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow, XYViewBottom(imageline), widthnow, 40)];
	[buttonitemarea.button addTarget:self action:@selector(ClickSelectarea:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemarea.tag = EnMemberMangerSelectItem2;
	[buttonitemarea updatebuttonitem:EnButtonTextRight TextStr:@"地区" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrowgrayunder", @"png")];
	[viewcash addSubview:buttonitemarea];
	
	return viewcash;
}


-(void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBar.translucent = NO;
	[self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
	[self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
	UIColor* color = [UIColor whiteColor];
	NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes= dict;
}

#pragma mark pop弹出框
- (void)Clickmorefunction:(id)sender
{
	//	UIButton *button = (UIButton *)sender;
	
	NSMutableArray *arrayicons = [[NSMutableArray alloc] init];
	[arrayicons addObject:LOADIMAGE(@"实名认证grayicon", @"png")];
	[arrayicons addObject:LOADIMAGE(@"添加用户grayicon", @"png")];
	ybpopmenu = [YBPopupMenu showRelyOnView:sender titles:TITLES icons:arrayicons menuWidth:130 otherSettings:^(YBPopupMenu *popupMenu)
				 {
					 popupMenu.dismissOnSelected = NO;
					 popupMenu.isShowShadow = YES;
					 popupMenu.delegate = self;
					 popupMenu.offset = 5;
					 popupMenu.type = YBPopupMenuTypeDefault;
					 popupMenu.rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight|UIRectCornerAllCorners;
				 }];
	
}

- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
	if([TITLES[index] isEqualToString:@"实名认证"])
	{
		
	}
	else if([TITLES[index] isEqualToString:@"添加用户"])
	{
		
	}
	else
	{
		
	}
	[tableview reloadData];
	[ybpopmenu dismiss];
	NSLog(@"点击了 %@ 选项",TITLES[index]);
}


#pragma mark IBaction
-(void)ClickSelectUser:(id)sender
{
	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnMemberMangerSelectItem1];
	[buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
	[buttonitem1 updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
	if (flagnow==0)
	{
		enselectitem =  EnMemberMangerItemUser;
		flagnow = 1;
		arrayselectitem = @[@"全部用户",@"用户类型"];
		[self initandydroplist:sender];
		[self.view insertSubview:andydroplist belowSubview:sender];
		[andydroplist showList];
	}
	else
	{
		flagnow = 0;
		[andydroplist hiddenList];
	}

}

-(void)ClickSelectarea:(id)sender
{
	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnMemberMangerSelectItem2];
	[buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
	[buttonitem1 updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
	if (flagnow==0)
	{
		enselectitem =  EnMemberMangerItemArea;
		flagnow = 1;
		arrayselectitem = @[@"全部区域",@"地区选择"];
		[self initandydroplist:sender];
		[self.view insertSubview:andydroplist belowSubview:sender];
		[andydroplist showList];
	}
	else
	{
		flagnow = 0;
		[andydroplist hiddenList];
	}

}

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark TYYNavFilterDelegate
-(AndyDropDownList *)initandydroplist:(UIButton *)button
{
	andydroplist = [[AndyDropDownList alloc] initWithListDataSource:arrayselectitem rowHeight:44 view:button Frame:CGRectMake(0, 130, SCREEN_WIDTH, SCREEN_HEIGHT)];
	andydroplist.delegate = self;
	return andydroplist;
}

-(void)setAndyDropHideflag:(id)sender
{
	flagnow = 0;
}

-(void)dropDownListParame:(NSString *)aStr
{
	flagnow = 0;
	DLog(@"astr====%@",aStr);
	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnMemberMangerSelectItem1];
	ButtonItemLayoutView *buttonitem2 = [self.view viewWithTag:EnMemberMangerSelectItem2];
	if(enselectitem == EnMemberMangerItemUser)
	{
		if([aStr isEqualToString:@"用户类型"])
		{
			MemberMangementSelectUserTypeViewController *membermanger = [[MemberMangementSelectUserTypeViewController alloc] init];
			[self.navigationController pushViewController:membermanger animated:YES];
		}
	}
	else if(enselectitem == EnMemberMangerItemArea)
	{
		if([aStr isEqualToString:@"地区选择"])
		{
			MemberMangementSelectUserTypeViewController *membermanger = [[MemberMangementSelectUserTypeViewController alloc] init];
			[self.navigationController pushViewController:membermanger animated:YES];
		}
	}

}

#pragma mark tableview delegate
//隐藏那些没有cell的线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
	UIView *view = [UIView new];
	view.backgroundColor = [UIColor clearColor];
	[tableView setTableFooterView:view];
}

-(void)viewDidLayoutSubviews
{
	if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
		[tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
	}
	
	if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
		[tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
	}
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
		[cell setSeparatorInset:UIEdgeInsetsZero];
	}
	
	if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
		[cell setLayoutMargins:UIEdgeInsetsZero];
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	static NSString *reuseIdetify = @"cell";
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	for(UIView *view in cell.contentView.subviews)
	{
		[view removeFromSuperview];
	}
	
	cell.backgroundColor = [UIColor whiteColor];
	
	
	float nowwidth = (SCREEN_WIDTH-20)/2;
	
	UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
	imageheader.image = LOADIMAGE(@"scanrebatetest1", @"png");
	[cell.contentView addSubview:imageheader];
	
	NSString *strname = @"江南小颖";
	CGSize size = [AddInterface getlablesize:strname Fwidth:200 Fheight:20 Sfont:FONTN(14.0f)];
	UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewTop(imageheader), size.width, 20)];
	lablename.text =strname;
	lablename.font = FONTN(14.0f);
	lablename.textColor = COLORNOW(117, 117, 117);
	lablename.backgroundColor = [UIColor clearColor];
	[cell.contentView addSubview:lablename];
	
	UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(lablename)+5, XYViewTop(lablename)+5, 10, 10)];
	imageicon.image = LOADIMAGE(@"scanrebateheader1", @"png");
	[cell.contentView addSubview:imageicon];
	
	UILabel *lableaddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablename), XYViewBottom(lablename), SCREEN_WIDTH/2-20, 20)];
	lableaddr.text =@"成都市青羊区XX街道";
	lableaddr.font = FONTN(11.0f);
	lableaddr.textColor = COLORNOW(160, 160, 160);
	lableaddr.backgroundColor = [UIColor clearColor];
	[cell.contentView addSubview:lableaddr];
	
	UILabel *lablearea = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-nowwidth-10, 20, nowwidth, 20)];
	lablearea.text = @"四川省 成都市 万华区";
	lablearea.font = FONTN(14.0f);
	lablearea.textColor = COLORNOW(117, 117, 117);
	lablearea.backgroundColor = [UIColor clearColor];
	lablearea.textAlignment = NSTextAlignmentRight;
	[cell.contentView addSubview:lablearea];
	
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
