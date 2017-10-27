//
//  HistoryRecordViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/24.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "HistoryRecordViewController.h"

@interface HistoryRecordViewController ()

@end

@implementation HistoryRecordViewController

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
	self.title = @"历史记录";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	FCorderid = @"desc";
	FCorderitem = @"";
	FCstatusid = @"";
	FCendtime = @"";
	FCstarttime = @"";
	arrayselectitem = [[NSMutableArray alloc] init];
	[self getjihuostatuslist];
	
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-64-40)];
	tableview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tableview];
	[self addtabviewheader];
	[self setExtraCellLineHidden:tableview];
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getcreateqrcodehistorylist:@"1" Pagesize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getcreateqrcodehistorylist:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
    
	[self getcreateqrcodehistorylist:@"1" Pagesize:@"10"];
}

-(void)addtabviewheader
{
//	UIView *tabviewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//	tabviewheader.backgroundColor = [UIColor clearColor];
//	tableview.tableHeaderView = tabviewheader;;
	[self.view addSubview:[self viewselectitem:CGRectMake(0, 0, SCREEN_WIDTH, 40)]];
}

//表头
-(UIView *)viewselectitem:(CGRect)frame
{
	UIView *viewselectitem = [[UIView alloc] initWithFrame:frame];
	viewselectitem.backgroundColor = [UIColor whiteColor];
	//两根灰线
	UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 0.7)];
	line1.backgroundColor = COLORNOW(200, 200, 200);
	[viewselectitem addSubview:line1];
	
	float nowwidth = (SCREEN_WIDTH-20)/4;
	
	//时间
	ButtonItemLayoutView *buttonstatus = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, 0, nowwidth, 40)];
	[buttonstatus.button addTarget:self action:@selector(ClickSelectTime:) forControlEvents:UIControlEventTouchUpInside];
	buttonstatus.tag = EnRebateQRCodeHistoryButton1;
	[buttonstatus updatebuttonitem:EnButtonTextCenter TextStr:@"时间" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrowgrayunder", @"png")];
	[viewselectitem addSubview:buttonstatus];
	
	
	//金额
	ButtonItemLayoutView *buttonitemmoney = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(XYViewR(buttonstatus), 0, nowwidth, 40)];
	[buttonitemmoney.button addTarget:self action:@selector(ClickSelectMoney:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemmoney.tag = EnRebateQRCodeHistoryButton2;
	[buttonitemmoney updatebuttonitem:EnButtonTextCenter TextStr:@"金额" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrowgrayunder", @"png")];
	[viewselectitem addSubview:buttonitemmoney];

	
	//数量
	ButtonItemLayoutView *buttonitemnumber = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(XYViewR(buttonitemmoney), 0, nowwidth, 40)];
	[buttonitemnumber.button addTarget:self action:@selector(ClickSelectNumber:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemnumber.tag = EnRebateQRCodeHistoryButton3;
	[buttonitemnumber updatebuttonitem:EnButtonTextCenter TextStr:@"数量" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrowgrayunder", @"png")];
	[viewselectitem addSubview:buttonitemnumber];

	
	//激活
	ButtonItemLayoutView *buttonitemjihuo = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(XYViewR(buttonitemnumber), 0, nowwidth, 40)];
	[buttonitemjihuo.button addTarget:self action:@selector(ClickSelectJihuo:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemjihuo.tag = EnRebateQRCodeHistoryButton4;
	[buttonitemjihuo updatebuttonitem:EnButtonTextCenter TextStr:@"激活" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrowgrayunder", @"png")];
	[viewselectitem addSubview:buttonitemjihuo];
	
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
	[self getcreateqrcodehistorylist:@"1" Pagesize:@"10"];
}

#pragma mark IBaction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)ClickSelectTime:(id)sender
{
	//排序分
	//金额  从小到大   从大到小
	//数量  从小到大   从大到小
	//远近  从远到近   从近到远
	//激活(状态)  已激活  未激活
	[arrayselectitem removeAllObjects];
	enselectitem = EnCreateQRCodeHistorySelectTime;
	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnRebateQRCodeHistoryButton1];
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

-(void)ClickSelectMoney:(id)sender
{
	//排序分
	//金额  从小到大   从大到小
	//数量  从小到大   从大到小
	//远近  从远到近   从近到远
	//激活(状态)  已激活  未激活
	[arrayselectitem removeAllObjects];
	enselectitem = EnCreateQRCodeHistorySelectMoney;
	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnRebateQRCodeHistoryButton2];
	[buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
	[buttonitem1 updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
	if (flagnow==0)
	{
		flagnow = 1;
		[arrayselectitem addObject:@"默认"];
		[arrayselectitem addObject:@"从大到小"];
		[arrayselectitem addObject:@"从小到大"];
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

-(void)ClickSelectNumber:(id)sender
{
	//排序分
	//金额  从小到大   从大到小
	//数量  从小到大   从大到小
	//远近  从远到近   从近到远
	//激活(状态)  已激活  未激活
	[arrayselectitem removeAllObjects];
	enselectitem = EnCreateQRCodeHistorySelectNumber;
	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnRebateQRCodeHistoryButton3];
	[buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
	[buttonitem1 updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
	if (flagnow==0)
	{
		flagnow = 1;
		[arrayselectitem addObject:@"默认"];
		[arrayselectitem addObject:@"从大到小"];
		[arrayselectitem addObject:@"从小到大"];
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

-(void)ClickSelectJihuo:(id)sender
{
	[arrayselectitem removeAllObjects];
	enselectitem = EnCreateQRCodeHistorySelectJiHuo;
	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnRebateQRCodeHistoryButton4];
	[buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
	[buttonitem1 updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
	if (flagnow==0)
	{
		flagnow = 1;
		for(int i=0;i<[FCarraystatus count];i++)
		{
			NSDictionary *dictemp = [FCarraystatus objectAtIndex:i];
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

#pragma mark TYYNavFilterDelegate
-(AndyDropDownList *)initandydroplist:(UIButton *)button
{
	andydroplist = [[AndyDropDownList alloc] initWithListDataSource:arrayselectitem rowHeight:44 view:button];
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
	
	if(enselectitem==EnCreateQRCodeHistorySelectTime)
	{
		FCstarttime = @"";
		FCendtime = @"";
		FCorderitem = @"time";
		FCorderid = @"desc";
		ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnRebateQRCodeHistoryButton1];
		[buttonitem updatelabstr:astr];
		if([astr isEqualToString:@"默认"]||[astr isEqualToString:@"正序"])
		{
			[self getcreateqrcodehistorylist:@"1" Pagesize:@"10"];
		}
		else if([astr isEqualToString:@"倒序"])
		{
			FCorderid = @"asc";
			[self getcreateqrcodehistorylist:@"1" Pagesize:@"10"];
		}
		else if([astr isEqualToString:@"自定义"])
		{
			FCorderitem = @"";
			TimeSelectViewController *timeselect = [[TimeSelectViewController alloc] init];
			timeselect.delegate1 = self;
			[self.navigationController pushViewController:timeselect animated:YES];
		}
	}
	else if(enselectitem==EnCreateQRCodeHistorySelectNumber)
	{
		FCorderitem = @"count";
		FCorderid = @"desc";
		ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnRebateQRCodeHistoryButton3];
		[buttonitem updatelabstr:astr];
		if([astr isEqualToString:@"默认"]||[astr isEqualToString:@"从大到小"])
		{
		}
		else if([astr isEqualToString:@"从小到大"])
		{
			FCorderid = @"asc";
		}
		[self getcreateqrcodehistorylist:@"1" Pagesize:@"10"];
	}
	else if(enselectitem==EnCreateQRCodeHistorySelectMoney)
	{
		FCorderitem = @"money";
		FCorderid = @"desc";
		ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnRebateQRCodeHistoryButton2];
		[buttonitem updatelabstr:astr];
		if([astr isEqualToString:@"默认"]||[astr isEqualToString:@"从大到小"])
		{
		}
		else if([astr isEqualToString:@"从小到大"])
		{
			FCorderid = @"asc";
		}
		[self getcreateqrcodehistorylist:@"1" Pagesize:@"10"];
	}
	else if(enselectitem==EnCreateQRCodeHistorySelectJiHuo)
	{
		ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnRebateQRCodeHistoryButton4];
		[buttonitem updatelabstr:astr];
		FCstatusid = [AddInterface returnselectid:FCarraystatus SelectValue:astr];
		[self getcreateqrcodehistorylist:@"1" Pagesize:@"10"];
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
	return 50;
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
	
	float widthnow = (SCREEN_WIDTH-20)/4;
	
	NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
	
	NSString *strtiem = [dictemp objectForKey:@"generatetime"];
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, widthnow, 38)];
	labeltime.text = strtiem;
	labeltime.numberOfLines = 2;
	labeltime.textColor = [UIColor blackColor];
	labeltime.font = FONTN(13.0f);
	labeltime.textAlignment = NSTextAlignmentCenter;
	[cell.contentView addSubview:labeltime];

	
	NSString *strmoney =[NSString stringWithFormat:@"%@",[dictemp objectForKey:@"money"]];
	CGSize size = [AddInterface getlablesize:strmoney Fwidth:widthnow Fheight:20 Sfont:FONTMEDIUM(15.0f)];
	UILabel *labelmoney = [[UILabel alloc] initWithFrame:CGRectMake(10+widthnow+(widthnow-size.width)/2, 15, size.width, 20)];
	labelmoney.text = strmoney;
	labelmoney.textColor = [UIColor blackColor];
	labelmoney.font = FONTMEDIUM(15.0f);
	labelmoney.textAlignment = NSTextAlignmentCenter;
	[cell.contentView addSubview:labelmoney];
	
	UILabel *lablemoneyflag1 = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelmoney)-10, XYViewTop(labelmoney)+4, 10,10)];
	lablemoneyflag1.text = @"￥";
	lablemoneyflag1.font = FONTMEDIUM(11.0f);
	lablemoneyflag1.textColor = [UIColor blackColor];
	lablemoneyflag1.backgroundColor = [UIColor clearColor];
	[cell.contentView addSubview:lablemoneyflag1];
	
	
	UILabel *labelnumber = [[UILabel alloc] initWithFrame:CGRectMake(10+widthnow*2, 6, widthnow, 38)];
	labelnumber.text = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"generatenumber"]];
	labelnumber.textColor = [UIColor blackColor];
	labelnumber.font = FONTMEDIUM(15.0f);
	labelnumber.textAlignment = NSTextAlignmentCenter;
	[cell.contentView addSubview:labelnumber];
	
	
	UILabel *labeljihuo = [[UILabel alloc] initWithFrame:CGRectMake(10+widthnow*3, 6, widthnow, 38)];
	labeljihuo.text = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"activitynumber"]];
	labeljihuo.textColor = [UIColor blackColor];
	labeljihuo.font = FONTMEDIUM(15.0f);
	labeljihuo.textAlignment = NSTextAlignmentCenter;
	[cell.contentView addSubview:labeljihuo];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
	JiHuoViewController *jihuoview = [[JiHuoViewController alloc] init];
	jihuoview.FCqrcodeid = [dictemp objectForKey:@"id"];
	[self.navigationController pushViewController:jihuoview animated:YES];
	
	
}

#pragma mark 接口
//获取激状态
-(void)getjihuostatuslist
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];

	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQGetJiHuoStatusCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			FCarraystatus = [[dic objectForKey:@"data"] objectForKey:@"activitystatuslist"];
			if([FCarraystatus count]>0)
			{
				NSDictionary *dictemp = [FCarraystatus objectAtIndex:0];
				FCstatusid = [dictemp objectForKey:@"id"];
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
-(void)getcreateqrcodehistorylist:(NSString *)page Pagesize:(NSString *)pagesize
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"starttime"] = FCstarttime;
	params[@"endtime"] = FCendtime;
	params[@"activitystatusid"] = FCstatusid;
	params[@"orderitem"] = FCorderitem;
	params[@"order"] = FCorderid;
	params[@"pagesize"] = pagesize;
	params[@"page"] = page;
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQCreateQRCodeHistoryListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"rebateqrcodelist"];
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
