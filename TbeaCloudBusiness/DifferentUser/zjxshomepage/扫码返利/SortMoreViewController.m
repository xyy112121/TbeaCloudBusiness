//
//  SortMoreViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/26.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "SortMoreViewController.h"

@interface SortMoreViewController ()

@end

@implementation SortMoreViewController

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
	self.title = @"提现排名";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	arrayselectitem = [[NSMutableArray alloc] init];
	FCorderid = @"";
	FCorderitem = @"money";
	FCstarttime = @"";
	FCendtime = @"";
	FCzonelds = @"";
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight-90)];
	tableview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tableview];
	[self addtabviewheader];
	[self setExtraCellLineHidden:tableview];
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getrebatesortlist:@"1" Pagesize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getrebatesortlist:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
	[self getrebatesortlist:@"1" Pagesize:@"10"];
	
}

-(void)addtabviewheader
{
	UIView *tabviewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
	tabviewheader.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tabviewheader];
	[tabviewheader addSubview:[self searchbarview]];
	[tabviewheader addSubview:[self viewselectitem:CGRectMake(0, 50, SCREEN_WIDTH, 40)]];
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

//选择经销商的时候进行时间选择
-(void)jingxiaoshangtimeselect
{
	UIView *viewtimeselect = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
	viewtimeselect.backgroundColor = [UIColor whiteColor];
	viewtimeselect.tag = EnSortMoreTimeSelectViewTag1;
	
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 70, 20)];
	labeltime.text = @"时间选择";
	labeltime.textColor = [UIColor blackColor];
	labeltime.backgroundColor = [UIColor clearColor];
	labeltime.font = FONTB(16.0f);
	[viewtimeselect addSubview:labeltime];
	
	UIImageView *imageclock = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labeltime)+10, 18, 14, 14)];
	imageclock.image = LOADIMAGE(@"clickicon", @"png");
	[viewtimeselect addSubview:imageclock];
	
	
	
	
	[self.view addSubview:viewtimeselect];
}

//表头
-(UIView *)viewselectitem:(CGRect)frame
{
	UIView *viewselectitem = [[UIView alloc] initWithFrame:frame];
	viewselectitem.backgroundColor = [UIColor whiteColor];
	//两根灰线
	UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.7)];
	line1.backgroundColor = COLORNOW(200, 200, 200);
	[viewselectitem addSubview:line1];
	
	UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.7)];
	line2.backgroundColor = COLORNOW(200, 200, 200);
	[viewselectitem addSubview:line2];
	
	float nowwidth = (SCREEN_WIDTH-20)/3;
	
	//编码
	UIButton *buttonitemusertype = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonitemusertype.frame =CGRectMake(15, 0, nowwidth-5, 40);
	buttonitemusertype.backgroundColor = [UIColor clearColor];
	[buttonitemusertype setTitle:@"水电工" forState:UIControlStateNormal];
	buttonitemusertype.titleLabel.font = FONTB(14.0f);
	buttonitemusertype.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	[buttonitemusertype setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
	[viewselectitem addSubview:buttonitemusertype];
	
	//区域
	ButtonItemLayoutView *buttonitemarea = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+nowwidth, 0, nowwidth, 40)];
	[buttonitemarea.button addTarget:self action:@selector(ClickSelectarea:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemarea.tag = EnSortMoreSelectItembt2;
	[buttonitemarea updatebuttonitem:EnButtonTextCenter TextStr:@"区域" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrowgrayunder", @"png")];
	[viewselectitem addSubview:buttonitemarea];
	
	//金额
	ButtonItemLayoutView *buttonitemmoney = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-nowwidth, 0, nowwidth, 40)];
	[buttonitemmoney.button addTarget:self action:@selector(ClickSelectMoney:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemmoney.tag = EnSortMoreSelectItembt3;
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
	
}

-(void)DGClickGoToSearch:(id)sender
{
    SearchPageViewController *searchpage = [[SearchPageViewController alloc] init];
    UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:searchpage];
    searchpage.FCSearchFromType = @"scanrebate";
    [self.navigationController presentViewController:nctl animated:YES completion:nil];
}


-(void)DGAreaSelectDone:(NSArray *)sender
{
	NSString *selectzone;
	for(int i=0;i<[sender count];i++)
	{
		NSDictionary *dictemp = [sender objectAtIndex:i];
		FCzonelds = [FCzonelds length]==0?[dictemp objectForKey:@"id"]:[NSString stringWithFormat:@"%@,%@",FCzonelds,[dictemp objectForKey:@"id"]];
		
		selectzone = [selectzone length]==0?[dictemp objectForKey:@"name"]:[NSString stringWithFormat:@"%@,%@",selectzone,[dictemp objectForKey:@"name"]];
	}
	ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnSortMoreSelectItembt2];
	[buttonitem updatelabstr:selectzone];
	
	[self getrebatesortlist:@"1" Pagesize:@"10"];
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
    if([FCorderid isEqualToString:@""])
    {
        FCorderid= @"desc";
        [buttonitem1 updatelabstr:@"金额"];
        //        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
	else if([FCorderid isEqualToString:@"desc"])
	{
		FCorderid= @"asc";
		[buttonitem1 updatelabstr:@"金额"];
//        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
		[buttonitem1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
	}
	else
	{
		FCorderid= @"desc";
		[buttonitem1 updatelabstr:@"金额"];
//        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
		[buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
	}
	[self getrebatesortlist:@"1" Pagesize:@"10"];
}

-(void)ClickSelectarea:(id)sender
{
	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnSortMoreSelectItembt2];
	[buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
	[buttonitem1 updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
	[arrayselectitem removeAllObjects];
	if (flagnow==0)
	{
		enselectitem =  EnSortMoreSelectArea;
		flagnow = 1;
		[arrayselectitem addObject:@"全部区域"];
		[arrayselectitem addObject:@"区域选择"];
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
	andydroplist = [[AndyDropDownList alloc] initWithListDataSource:arrayselectitem rowHeight:44 view:button Frame:CGRectMake(0, 90, SCREEN_WIDTH, SCREEN_HEIGHT)];
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

	if([aStr isEqualToString:@"区域选择"])
	{
		AreaSelectViewController *areaseelct = [[AreaSelectViewController alloc] init];
		areaseelct.delegate1 = self;
		[self.navigationController pushViewController:areaseelct animated:YES];
	}
	else
	{
		FCzonelds = @"";
//        ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnSortMoreSelectItembt2];
//        [buttonitem1 updatelabstr:@"全部区域"];
		[self getrebatesortlist:@"1" Pagesize:@"10"];
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
	SortMoreCellView *scancell = [[SortMoreCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 59) DicFrom:dictemp UserType:enusertype];
	[cell.contentView addSubview:scancell];
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
	TiXianHistoryViewController *tixiandata = [[TiXianHistoryViewController alloc] init];
	tixiandata.FCpersontype = [dictemp objectForKey:@"personorcompany"];
	tixiandata.FCpayeeid = [dictemp objectForKey:@"electricianid"];
	
	
	[self.navigationController pushViewController:tixiandata animated:YES];
}

#pragma mark 接口
//获取列表
-(void)getrebatesortlist:(NSString *)page Pagesize:(NSString *)pagesize
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fdistributorid"] = _FCfdistributorid;
	params[@"zoneids"] = FCzonelds;
//	params[@"starttime"] = FCstarttime;
//	params[@"endtime"] = FCendtime;
	params[@"orderitem"] = FCorderitem;
	params[@"order"] = FCorderid;
	params[@"pagesize"] = pagesize;
	params[@"page"] = page;
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQRebateMoreSortListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"takemoneyrankinglist"];
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
