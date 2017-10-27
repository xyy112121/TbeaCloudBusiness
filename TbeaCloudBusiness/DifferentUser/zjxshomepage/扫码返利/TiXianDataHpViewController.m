//
//  TiXianDataHpViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/25.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "TiXianDataHpViewController.h"

@interface TiXianDataHpViewController ()

@end

@implementation TiXianDataHpViewController

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
	
	// Do any additional setup after loading the view.
}

#pragma mark 页面布局

-(void)initview
{
	self.title = @"提现数据";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	arrayselectitem = [[NSMutableArray alloc] init];
	FCorderitem = @"";
	FCorderid = @"desc";
	FCstarttime = @"";
	FCendtime = @"";
	FCpaystatusid = @"";
	FCpayeeusertypeid = @"";
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, SCREEN_HEIGHT-64-90)];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
	//获取选择状态
	[self gettixianusertype];
	[self getpaystatustype];
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf gettixiandatalist:@"1" Pagesize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf gettixiandatalist:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
	
}

-(void)updatetabviewheader
{
	UIView *view = [self.view viewWithTag:EnTiXianDataHeaderViewTag];
	[[view viewWithTag:EnTiXianDataHeaderLabelMoneyTag] removeFromSuperview];
	[[view viewWithTag:EnTiXianDataHeaderLabelFlagTag] removeFromSuperview];
	
	NSString *strmoney = [NSString stringWithFormat:@"%@",[FCdictotleinfo objectForKey:@"totlemoney"]];
	CGSize size2 = [AddInterface getlablesize:strmoney Fwidth:150 Fheight:20 Sfont:FONTMEDIUM(17.0f)];
	UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-size2.width-10, 15, size2.width, 20)];
	lablemoneyvalue.text =strmoney;
	lablemoneyvalue.font = FONTMEDIUM(17.0f);
	lablemoneyvalue.textColor = [UIColor blackColor];
	lablemoneyvalue.textAlignment = NSTextAlignmentRight;
	lablemoneyvalue.backgroundColor = [UIColor clearColor];
	lablemoneyvalue.tag = EnTiXianDataHeaderLabelMoneyTag;
	[view addSubview:lablemoneyvalue];
	
	UILabel *lablemoneyflag1 = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablemoneyvalue)-10, XYViewTop(lablemoneyvalue)+4, 10,10)];
	lablemoneyflag1.text = @"￥";
	lablemoneyflag1.font = FONTMEDIUM(11.0f);
	lablemoneyflag1.textColor = [UIColor blackColor];
	lablemoneyflag1.backgroundColor = [UIColor clearColor];
	lablemoneyflag1.tag = EnTiXianDataHeaderLabelFlagTag;
	[view addSubview:lablemoneyflag1];
}

-(void)addtabviewheader
{
	UIView *tabviewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
	tabviewheader.backgroundColor = [UIColor clearColor];
	
	UIView *view = [self getviewselectitem:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
	view.tag = EnTiXianDataHeaderViewTag;
	[self.view addSubview:view];
}


//表头
-(UIView *)getviewselectitem:(CGRect)frame
{
	UIView *viewselectitem = [[UIView alloc] initWithFrame:frame];
	viewselectitem.backgroundColor = [UIColor whiteColor];
	
	//两根灰线
	UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 0.7)];
	line1.backgroundColor = COLORNOW(200, 200, 200);
	[viewselectitem addSubview:line1];
	
	UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 89.5, SCREEN_WIDTH, 0.7)];
	line2.backgroundColor = COLORNOW(200, 200, 200);
	[viewselectitem addSubview:line2];
	
	if([FCarraypaystatus count]>0)
	{
		//支付
		NSDictionary *dictemp = [FCarraypaystatus objectAtIndex:0];
		UIButton *buttonzhifu = [UIButton buttonWithType:UIButtonTypeCustom];
		buttonzhifu.frame = CGRectMake(17, 10, 60, 30);
		buttonzhifu.backgroundColor = [UIColor clearColor];
		[buttonzhifu setTitle:[dictemp objectForKey:@"name"] forState:UIControlStateNormal];
		buttonzhifu.titleLabel.font = FONTB(17.0f);
		buttonzhifu.tag = EnTiXianDataZhifuBttag;
		[buttonzhifu addTarget:self action:@selector(clickzhifu:) forControlEvents:UIControlEventTouchUpInside];
		[buttonzhifu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[viewselectitem addSubview:buttonzhifu];
	}
	
	if([FCarraypaystatus count]>1)
	{
		//未支付
		NSDictionary *dictemp = [FCarraypaystatus objectAtIndex:1];
		UIButton *buttonallweizhifu = [UIButton buttonWithType:UIButtonTypeCustom];
		buttonallweizhifu.frame = CGRectMake(80, 10, 60, 30);
		buttonallweizhifu.backgroundColor = [UIColor clearColor];
		[buttonallweizhifu setTitle:[dictemp objectForKey:@"name"] forState:UIControlStateNormal];
		buttonallweizhifu.titleLabel.font = FONTN(15.0f);
		buttonallweizhifu.tag = EnTiXianDataWeiZhifuBttag;
		[buttonallweizhifu addTarget:self action:@selector(clickweizhifu:) forControlEvents:UIControlEventTouchUpInside];
		[buttonallweizhifu setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
		[viewselectitem addSubview:buttonallweizhifu];
	}
	
	
	
	
	
	float widthnow = (SCREEN_WIDTH-20)/4;
	//时间
	ButtonItemLayoutView *buttonstatus = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, XYViewBottom(line1), widthnow, 40)];
	[buttonstatus.button addTarget:self action:@selector(ClickSelectTime:) forControlEvents:UIControlEventTouchUpInside];
	buttonstatus.tag = EnTixianDataSelectItembt1;
	[buttonstatus updatebuttonitem:EnButtonTextLeft TextStr:@"时间" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrowgrayunder", @"png")];
	[viewselectitem addSubview:buttonstatus];
	
	//全部用户
	ButtonItemLayoutView *buttonitemalluser = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow*2, XYViewBottom(line1), widthnow, 40)];
	[buttonitemalluser.button addTarget:self action:@selector(ClickSelectUser:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemalluser.tag = EnTixianDataSelectItembt2;
	[buttonitemalluser updatebuttonitem:EnButtonTextCenter TextStr:@"用户" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrowgrayunder", @"png")];
	[viewselectitem addSubview:buttonitemalluser];
	
	
	//金额
	ButtonItemLayoutView *buttonitemmoney = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-widthnow, XYViewBottom(line1), widthnow, 40)];
	[buttonitemmoney.button addTarget:self action:@selector(ClickSelectMoney:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemmoney.tag = EnTixianDataSelectItembt3;
	[buttonitemmoney updatebuttonitem:EnButtonTextRight TextStr:@"金额" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
	[viewselectitem addSubview:buttonitemmoney];
	
	return viewselectitem;
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

#pragma mark ActionDelegate
-(void)DGSelectDateDone:(NSString *)starttime EndTime:(NSString *)endtime
{
    FCstarttime = starttime;
    FCendtime = endtime;
    [self gettixiandatalist:@"1" Pagesize:@"10"];
}


#pragma mark IBaction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)clickzhifu:(id)sender
{
	UIButton *button1 = [self.view viewWithTag:EnTiXianDataZhifuBttag];
	UIButton *button2 = [self.view viewWithTag:EnTiXianDataWeiZhifuBttag];
	button1.titleLabel.font = FONTB(17.0f);
	[button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	button2.titleLabel.font = FONTB(15.0f);
	[button2 setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
	
	[button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	
	NSDictionary *dictemp = [FCarraypaystatus objectAtIndex:0];
	FCpaystatusid = [dictemp objectForKey:@"id"];
	
	
	zhifutype = EnTiXianDataZhifu;
	[self gettixiandatalist:@"1" Pagesize:@"10"];
}

-(void)clickweizhifu:(id)sender
{
	UIButton *button1 = [self.view viewWithTag:EnTiXianDataZhifuBttag];
	UIButton *button2 = [self.view viewWithTag:EnTiXianDataWeiZhifuBttag];
	button2.titleLabel.font = FONTB(17.0f);
	[button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	button1.titleLabel.font = FONTB(15.0f);
	[button1 setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
	
	NSDictionary *dictemp = [FCarraypaystatus objectAtIndex:1];
	FCpaystatusid = [dictemp objectForKey:@"id"];
	
	zhifutype = EnTiXianDataWeiZhifu;
	[self gettixiandatalist:@"1" Pagesize:@"10"];
}

-(void)ClickSelectMoney:(id)sender
{
	//排序分
	//金额  从小到大   从大到小
	//数量  从小到大   从大到小
	//远近  从远到近   从近到远
	//激活  已激活  未激活
	FCorderitem = @"money";
	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnTixianDataSelectItembt3];
	if([FCorderid isEqualToString:@"desc"])
	{
		FCorderid= @"asc";
		[buttonitem1 updatelabstr:@"金额"];
		[buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
		[buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
	}
	else
	{
		FCorderid= @"desc";
		[buttonitem1 updatelabstr:@"金额"];
		[buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
		[buttonitem1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
	}
	[self gettixiandatalist:@"1" Pagesize:@"10"];
}

-(void)ClickSelectUser:(id)sender
{
	//排序分
	//金额  从小到大   从大到小
	//数量  从小到大   从大到小
	//远近  从远到近   从近到远
	//激活(状态)  已激活  未激活
	enselectitem = EnTiXianDataSelectUser;
	[arrayselectitem removeAllObjects];
	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnTixianDataSelectItembt2];
	[buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
	[buttonitem1 updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
	if (flagnow==0)
	{
		flagnow = 1;
		for(int i=0;i<[FCarrayPayeeUsertype count];i++)
		{
			NSDictionary *dictemp = [FCarrayPayeeUsertype objectAtIndex:i];
			[arrayselectitem addObject:[dictemp objectForKey:@"name"]];
		}
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

-(void)ClickSelectTime:(id)sender
{
	//排序分
	//金额  从小到大   从大到小
	//数量  从小到大   从大到小
	//远近  从远到近   从近到远
	//激活(状态)  已激活  未激活
	enselectitem = EnTiXianDataSelectDate;
	[arrayselectitem removeAllObjects];
	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnTixianDataSelectItembt1];
	[buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
	[buttonitem1 updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
	if (flagnow==0)
	{
		flagnow = 1;
		[arrayselectitem addObject:@"默认"];
		[arrayselectitem addObject:@"正序"];
		[arrayselectitem addObject:@"倒序"];
		[arrayselectitem addObject:@"自定义"];
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

#pragma mark TYYNavFilterDelegate
-(AndyDropDownList *)initandydroplist:(UIButton *)button
{
	andydroplist = [[AndyDropDownList alloc] initWithListDataSource:arrayselectitem rowHeight:44 view:button Frame:CGRectMake(0, 91, SCREEN_WIDTH, SCREEN_HEIGHT)];
	andydroplist.delegate = self;
	return andydroplist;
}

-(void)setAndyDropHideflag:(id)sender
{
	flagnow = 0;
}

-(void)dropDownListParame:(NSString *)astr
{
	flagnow = 0;
	DLog(@"astr====%@",astr);
	if(enselectitem == EnTiXianDataSelectDate)
	{
		FCstarttime = @"";
		FCendtime = @"";
		FCorderitem = @"time";
		FCorderid = @"desc";
		ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnTixianDataSelectItembt1];
		[buttonitem updatelabstr:astr];
		[buttonitem updatelablecolor:COLORNOW(0, 170, 238)];
		[buttonitem updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
		if([astr isEqualToString:@"默认"]||[astr isEqualToString:@"正序"])
		{
			[self gettixiandatalist:@"1" Pagesize:@"10"];
		}
		else if([astr isEqualToString:@"倒序"])
		{
			FCorderid = @"asc";
			[self gettixiandatalist:@"1" Pagesize:@"10"];
		}
		else if([astr isEqualToString:@"自定义"])
		{
			FCorderitem = @"";
			TimeSelectViewController *timeselect = [[TimeSelectViewController alloc] init];
			timeselect.delegate1 = self;
			[self.navigationController pushViewController:timeselect animated:YES];
		}
	}
	else if(enselectitem == EnTiXianDataSelectUser)
	{
		ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnTixianDataSelectItembt2];
		[buttonitem updatelabstr:astr];
		[buttonitem updatelablecolor:COLORNOW(0, 170, 238)];
		[buttonitem updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
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
	return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	return [FCarraydata count];
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
	
	NSDictionary *dic = [FCarraydata objectAtIndex:indexPath.row];
	
	float widthnow = (SCREEN_WIDTH-20)/4;
	NSString *strtiem = [dic objectForKey:@"time"];
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, widthnow*2, 20)];
	labeltime.text = strtiem;;
	labeltime.textColor = [UIColor blackColor];
	labeltime.font = FONTN(13.0f);
	labeltime.textAlignment = NSTextAlignmentLeft;
	[cell.contentView addSubview:labeltime];
	
	
	NSString *str = [dic objectForKey:@"personname"];
	CGSize size = [AddInterface getlablesize:str Fwidth:100 Fheight:20 Sfont:FONTN(13.0f)];
	UILabel *labeluser = [[UILabel alloc] initWithFrame:CGRectMake(10+widthnow*2+(widthnow-size.width-15)/2, 10, size.width, 20)];
	labeluser.text = str;
	labeluser.textColor = [UIColor blackColor];
	labeluser.font = FONTN(13.0f);
	labeluser.backgroundColor = [UIColor clearColor];
	labeluser.textAlignment = NSTextAlignmentCenter;
	[cell.contentView addSubview:labeluser];
	
	UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labeluser)+3, 15, 10, 10)];
    NSString *strpic = [dic objectForKey:@"persontypeicon"];//[InterfaceResource stringByAppendingString:[[dic objectForKey:@"persontypeicon"] length]>0?[dic objectForKey:@"persontypeicon"]:@"noimage.png"];
    [imageicon setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebateheader1", @"png")];
    imageicon.contentMode = UIViewContentModeScaleAspectFill;
	[cell.contentView addSubview:imageicon];
	
	NSString *strmoney = [NSString stringWithFormat:@"%@",[dic objectForKey:@"money"]];
	CGSize size2 = [AddInterface getlablesize:strmoney Fwidth:widthnow Fheight:20 Sfont:FONTMEDIUM(17.0f)];
	UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-size2.width-10, 10, size2.width, 20)];
	lablemoneyvalue.text =strmoney;
	lablemoneyvalue.font = FONTMEDIUM(17.0f);
	lablemoneyvalue.textColor = [UIColor blackColor];
	lablemoneyvalue.textAlignment = NSTextAlignmentRight;
	lablemoneyvalue.backgroundColor = [UIColor clearColor];
	[cell.contentView addSubview:lablemoneyvalue];
	
	UILabel *lablemoneyflag1 = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablemoneyvalue)-10, XYViewTop(lablemoneyvalue)+4, 10,10)];
	lablemoneyflag1.text = @"￥";
	lablemoneyflag1.font = FONTMEDIUM(11.0f);
	lablemoneyflag1.textColor = [UIColor blackColor];
	lablemoneyflag1.backgroundColor = [UIColor clearColor];
	[cell.contentView addSubview:lablemoneyflag1];
	
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *dic = [FCarraydata objectAtIndex:indexPath.row];
	TiXianDataDetailViewController *tixiandata = [[TiXianDataDetailViewController alloc] init];
	tixiandata.FCtakemoneyid = [dic objectForKey:@"takemoneyid"];
	[self.navigationController pushViewController:tixiandata animated:YES];
}

#pragma mark  接口
//获取用户类型
-(void)gettixianusertype
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQGetMoneyUsertypeCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			FCarrayPayeeUsertype = [[dic objectForKey:@"data"] objectForKey:@"getpayeetypelist"];
		}
		else
		{
			[MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		}
	} Failur:^(NSString *strmsg) {
		[MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
		
	}];
}

//获取状态类型
-(void)getpaystatustype
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQPayMoneyStatustypeCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			FCarraypaystatus = [[dic objectForKey:@"data"] objectForKey:@"paystatuslist"];
			if([FCarraypaystatus count]>0)
			{
				NSDictionary *dictemp = [FCarraypaystatus objectAtIndex:0];
				FCpaystatusid = [dictemp objectForKey:@"id"];
				[self addtabviewheader];
				[self gettixiandatalist:@"1" Pagesize:@"10"];
			}
		}
		else
		{
			[MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		}
	} Failur:^(NSString *strmsg) {
		[MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
		
	}];
}


//获取列表
-(void)gettixiandatalist:(NSString *)page Pagesize:(NSString *)pagesize
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"paystatusid"] = FCpaystatusid;
	params[@"payeetypeid"] = FCpayeeusertypeid;;
	params[@"starttime"] = FCstarttime;
	params[@"endtime"] = FCendtime;
	params[@"orderitem"] = FCorderitem;
	params[@"order"] = FCorderid;
	params[@"pagesize"] = pagesize;
	params[@"page"] = page;
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQTiXianDataListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"takemoneylist"];
			FCdictotleinfo = [[dic objectForKey:@"data"] objectForKey:@"totlemoneyinfo"];
			[self updatetabviewheader];
			tableview.delegate = self;
			tableview.dataSource = self;
			[tableview reloadData];
		}
		else
		{
			[MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		}
        if([FCarraydata count]>9)
            tableview.mj_footer.hidden = NO;
        [tableview.mj_header endRefreshing];
        [tableview.mj_footer endRefreshing];
    } Failur:^(NSString *strmsg) {
        [tableview.mj_header endRefreshing];
        [tableview.mj_footer endRefreshing];
		[MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
		
	}];
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
