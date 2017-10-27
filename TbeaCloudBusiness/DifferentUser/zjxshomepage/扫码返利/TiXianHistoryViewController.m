//
//  TiXianHistoryViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/26.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "TiXianHistoryViewController.h"

@interface TiXianHistoryViewController ()

@end

@implementation TiXianHistoryViewController

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
	self.title = @"提现历史";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	arrayselectitem = [[NSMutableArray alloc] init];
	FCorderitem = @"";
	FCorderid = @"desc";
	FCstarttime = @"";
	FCendtime = @"";
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT-64-100)];
	tableview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
	
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf gettixianhistorylist:@"1" Pagesize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf gettixianhistorylist:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
	[self gettixianhistorylist:@"1" Pagesize:@"10"];
}

-(void)addtabviewheader
{
	UIView *tabviewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
	tabviewheader.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tabviewheader];
	[tabviewheader addSubview:[self getviewselectitem:CGRectMake(0, 0, SCREEN_WIDTH, 100)]];
}


//表头
-(UIView *)getviewselectitem:(CGRect)frame
{
	UIView *viewselectitem = [[UIView alloc] initWithFrame:frame];
	viewselectitem.backgroundColor = [UIColor whiteColor];
	//两根灰线
	UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 0.7)];
	line1.backgroundColor = COLORNOW(200, 200, 200);
	[viewselectitem addSubview:line1];
	
	UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 99.5, SCREEN_WIDTH, 0.7)];
	line2.backgroundColor = COLORNOW(200, 200, 200);
	[viewselectitem addSubview:line2];
	
//	if(self.enfromusertype == EnScanRebateUserWater) //水电工
//		[self wateruserheader:viewselectitem];
//	else
		[self jingxiaoshangheader:viewselectitem];  //经销商
	
	float widthnow = (SCREEN_WIDTH-20)/4;
	//时间
	ButtonItemLayoutView *buttonstatus = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, XYViewBottom(line1), widthnow, 40)];
	[buttonstatus.button addTarget:self action:@selector(ClickSelectTime:) forControlEvents:UIControlEventTouchUpInside];
	buttonstatus.tag = EnTixianDataSelectItembt1;
	[buttonstatus updatebuttonitem:EnButtonTextLeft TextStr:@"时间" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrowgrayunder", @"png")];
	[viewselectitem addSubview:buttonstatus];
	
	//金额
	ButtonItemLayoutView *buttonitemmoney = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-widthnow, XYViewBottom(line1), widthnow, 40)];
	[buttonitemmoney.button addTarget:self action:@selector(ClickSelectMoney:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemmoney.tag = EnTixianDataSelectItembt3;
	[buttonitemmoney updatebuttonitem:EnButtonTextRight TextStr:@"金额" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
	[viewselectitem addSubview:buttonitemmoney];
	
	
	return viewselectitem;
}


-(void)jingxiaoshangheader:(UIView *)viewheader
{
	UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    NSString *strpic = [FCdicpayeeinfo objectForKey:@"thumbpicture"];//[InterfaceResource stringByAppendingString:[[FCdicpayeeinfo objectForKey:@"thumbpicture"] length]>0?[FCdicpayeeinfo objectForKey:@"thumbpicture"]:@"noimage.png"];
	[imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
	imageheader.contentMode = UIViewContentModeScaleAspectFill;
	[viewheader addSubview:imageheader];
	
	NSString *strname = [FCdicpayeeinfo objectForKey:@"personname"];
	CGSize size = [AddInterface getlablesize:strname Fwidth:200 Fheight:20 Sfont:FONTMEDIUM(16.0f)];
	UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewTop(imageheader), size.width, 20)];
	lablename.text =strname;
	lablename.font = FONTMEDIUM(16.0f);
	lablename.textColor = COLORNOW(117, 117, 117);
	lablename.backgroundColor = [UIColor clearColor];
	[viewheader addSubview:lablename];
	
	UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(lablename)+5, XYViewTop(lablename)+5, 30, 10)];
    NSString *stricon = [FCdicpayeeinfo objectForKey:@"persontypeicon"];//[InterfaceResource stringByAppendingString:[[FCdicpayeeinfo objectForKey:@"persontypeicon"] length]>0?[FCdicpayeeinfo objectForKey:@"persontypeicon"]:@"noimage.png"];
	[imageicon setImageWithURL:[NSURL URLWithString:stricon]];
	[viewheader addSubview:imageicon];
	
	UILabel *lableaddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablename), XYViewBottom(lablename), SCREEN_WIDTH/2-20, 20)];
	lableaddr.text =[FCdicpayeeinfo objectForKey:@"companyname"];
	lableaddr.font = FONTN(11.0f);
	lableaddr.textColor = COLORNOW(160, 160, 160);
	lableaddr.backgroundColor = [UIColor clearColor];
	[viewheader addSubview:lableaddr];
	
	NSString *strmoney = [NSString stringWithFormat:@"%@",[FCdicpayeeinfo objectForKey:@"totlemoney"]];
	CGSize size2 = [AddInterface getlablesize:strmoney Fwidth:120 Fheight:20 Sfont:FONTMEDIUM(17.0f)];
	UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-size2.width-10, 20, size2.width, 20)];
	lablemoneyvalue.text =strmoney;
	lablemoneyvalue.font = FONTMEDIUM(17.0f);
	lablemoneyvalue.textColor = [UIColor blackColor];
	lablemoneyvalue.textAlignment = NSTextAlignmentRight;
	lablemoneyvalue.backgroundColor = [UIColor clearColor];
	[viewheader addSubview:lablemoneyvalue];
	
	UILabel *lablemoneyflag1 = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablemoneyvalue)-10, XYViewTop(lablemoneyvalue)+4, 10,10)];
	lablemoneyflag1.text = @"￥";
	lablemoneyflag1.font = FONTMEDIUM(11.0f);
	lablemoneyflag1.textColor = [UIColor blackColor];
	lablemoneyflag1.backgroundColor = [UIColor clearColor];
	[viewheader addSubview:lablemoneyflag1];
	
}

-(void)wateruserheader:(UIView *)viewheader
{
	
	UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    NSString *strpic = [FCdicpayeeinfo objectForKey:@"thumbpicture"];//[InterfaceResource stringByAppendingString:[[FCdicpayeeinfo objectForKey:@"thumbpicture"] length]>0?[FCdicpayeeinfo objectForKey:@"thumbpicture"]:@"noimage.png"];
	[imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
	imageheader.contentMode = UIViewContentModeScaleAspectFill;
	[viewheader addSubview:imageheader];
	
	NSString *strname = [FCdicpayeeinfo objectForKey:@"personname"];
	CGSize size = [AddInterface getlablesize:strname Fwidth:200 Fheight:20 Sfont:FONTN(14.0f)];
	UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewTop(imageheader)+10, size.width, 20)];
	lablename.text =strname;
	lablename.font = FONTN(14.0f);
	lablename.textColor = COLORNOW(117, 117, 117);
	lablename.backgroundColor = [UIColor clearColor];
	[viewheader addSubview:lablename];
	
	UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(lablename)+5, XYViewTop(lablename)+5, 30, 10)];
    strpic = [FCdicpayeeinfo objectForKey:@"persontypeicon"];//[InterfaceResource stringByAppendingString:[[FCdicpayeeinfo objectForKey:@"persontypeicon"] length]>0?[FCdicpayeeinfo objectForKey:@"persontypeicon"]:@"noimage.png"];
	[imageheader setImageWithURL:[NSURL URLWithString:strpic]];
	[viewheader addSubview:imageicon];
	
	
	NSString *strmoney = [NSString stringWithFormat:@"%@",[FCdicpayeeinfo objectForKey:@"totlemoney"]];
	CGSize size2 = [AddInterface getlablesize:strmoney Fwidth:120 Fheight:20 Sfont:FONTMEDIUM(17.0f)];
	UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-size2.width-10, 20, size2.width, 20)];
	lablemoneyvalue.text =strmoney;
	lablemoneyvalue.font = FONTMEDIUM(17.0f);
	lablemoneyvalue.textColor = [UIColor blackColor];
	lablemoneyvalue.textAlignment = NSTextAlignmentRight;
	lablemoneyvalue.backgroundColor = [UIColor clearColor];
	[viewheader addSubview:lablemoneyvalue];
	
	UILabel *lablemoneyflag1 = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablemoneyvalue)-10, XYViewTop(lablemoneyvalue)+4, 10,10)];
	lablemoneyflag1.text = @"￥";
	lablemoneyflag1.font = FONTMEDIUM(11.0f);
	lablemoneyflag1.textColor = [UIColor blackColor];
	lablemoneyflag1.backgroundColor = [UIColor clearColor];
	[viewheader addSubview:lablemoneyflag1];
	
	
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
    [self gettixianhistorylist:@"1" Pagesize:@"10"];
}


#pragma mark IBaction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)ClickSelectMoney:(id)sender
{
	//排序分
	//金额  从小到大   从大到小
	//数量  从小到大   从大到小
	//远近  从远到近   从近到远
	//激活  已激活  未激活
	FCorderitem = @"money";
	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnSortMoreSelectItembt3];
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
	[self gettixianhistorylist:@"1" Pagesize:@"10"];
}

-(void)ClickSelectTime:(id)sender
{
	//排序分
	//金额  从小到大   从大到小
	//数量  从小到大   从大到小
	//远近  从远到近   从近到远
	//激活(状态)  已激活  未激活
	[arrayselectitem removeAllObjects];
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
	FCstarttime = @"";
	FCendtime = @"";
	FCorderitem = @"time";
	FCorderid = @"desc";
	ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnRebateQRCodeHistoryButton1];
	[buttonitem updatelabstr:astr];
	if([astr isEqualToString:@"默认"]||[astr isEqualToString:@"正序"])
	{
		[self gettixianhistorylist:@"1" Pagesize:@"10"];
	}
	else if([astr isEqualToString:@"倒序"])
	{
		FCorderid = @"asc";
		[self gettixianhistorylist:@"1" Pagesize:@"10"];
	}
	else if([astr isEqualToString:@"自定义"])
	{
		FCorderitem = @"";
		TimeSelectViewController *timeselect = [[TimeSelectViewController alloc] init];
		timeselect.delegate1 = self;
		[self.navigationController pushViewController:timeselect animated:YES];
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
	
	NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
	
	float widthnow = (SCREEN_WIDTH-20)/4;
	NSString *strtiem = [dictemp objectForKey:@"time"];
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, widthnow*2, 20)];
	labeltime.text = strtiem;;
	labeltime.textColor = [UIColor blackColor];
	labeltime.font = FONTN(13.0f);
	labeltime.textAlignment = NSTextAlignmentLeft;
	[cell.contentView addSubview:labeltime];
	
	NSString *strmoney = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"money"]];
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
	
}

#pragma mark 接口
//获取列表
-(void)gettixianhistorylist:(NSString *)page Pagesize:(NSString *)pagesize
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"personorcompany"] = self.FCpersontype;
	params[@"payeeid"] = self.FCpayeeid;
	params[@"starttime"] = FCstarttime;
	params[@"endtime"] = FCendtime;
	params[@"orderitem"] = FCorderitem;
	params[@"order"] = FCorderid;
	params[@"pagesize"] = pagesize;
	params[@"page"] = page;
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQTixianHistoryListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"takemoneylist"];
			FCdicpayeeinfo = [[dic objectForKey:@"data"] objectForKey:@"payeeinfo"];
			[self addtabviewheader];
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
