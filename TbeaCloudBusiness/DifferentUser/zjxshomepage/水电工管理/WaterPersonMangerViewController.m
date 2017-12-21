//
//  WaterPersonMangerViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/29.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "WaterPersonMangerViewController.h"

@interface WaterPersonMangerViewController ()

@end

@implementation WaterPersonMangerViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
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
	self.title = @"水电工列表";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	enselectitem = EnSortMoreSelectUserType; //默认选择的用户类型
	arrayselectitem = [[NSMutableArray alloc] init];
	
	FCorderitemvalue = @"";
	FCzoneid = @"";
	FCorderid = @"";
	FCwatertypeid = @"";
	FCsearchname = @"";
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight-90)];
	tableview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tableview];
	[self addtabviewheader];
	[self setExtraCellLineHidden:tableview];
	[self getwatertype]; //先获取水电工类型
	
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf getwaterlist:@"1" Pagesize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf getwaterlist:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
    
	[self getwaterlist:@"1" Pagesize:@"10"];
}

-(void)addtabviewheader
{
	UIView *tabviewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
	tabviewheader.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tabviewheader];
	[tabviewheader addSubview:[self searchbarview]];
    if(viewtop == nil)
        viewtop = [self viewselectitem:CGRectMake(0, 50, SCREEN_WIDTH, 40)];
	[tabviewheader addSubview:viewtop];
}

-(UIView *)searchbarview
{
	UIView *viewsearch = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
	viewsearch.backgroundColor = COLORNOW(0, 170, 238);
	
	SearchTextFieldView *searchtext = [[SearchTextFieldView alloc] initWithFrame:CGRectMake(40, 10, SCREEN_WIDTH-60, 30) Pastr:@"水电工查询"];
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
	
	float widthnow = (SCREEN_WIDTH-20)/4;
	
	//水电工类型
	ButtonItemLayoutView *buttonitemusertype = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, XYViewBottom(line1), widthnow*2, 40)];
	[buttonitemusertype.button addTarget:self action:@selector(ClickSelectusertype:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemusertype.tag = EnWaterListSelectItembt1;
	[buttonitemusertype updatebuttonitem:EnButtonTextLeft TextStr:@"全部" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrowgrayunder", @"png")];
	[viewselectitem addSubview:buttonitemusertype];
	
	//区域
	ButtonItemLayoutView *buttonitemarea = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow*2, XYViewBottom(line1), widthnow, 40)];
	[buttonitemarea.button addTarget:self action:@selector(ClickSelectarea:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemarea.tag = EnWaterListSelectItembt2;
	[buttonitemarea updatebuttonitem:EnButtonTextLeft TextStr:@"区域" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrowgrayunder", @"png")];
	[viewselectitem addSubview:buttonitemarea];
	
	//金额
	ButtonItemLayoutView *buttonitemtixian = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow*3, XYViewBottom(line1), widthnow, 40)];
	[buttonitemtixian.button addTarget:self action:@selector(ClickSelecttixian:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemtixian.tag = EnWaterListSelectItembt3;
	[buttonitemtixian updatebuttonitem:EnButtonTextRight TextStr:@"提现累计" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
	[viewselectitem addSubview:buttonitemtixian];
	
	return viewselectitem;
}



-(void)viewWillAppear:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:NO];
	self.navigationController.navigationBar.translucent = NO;
	[self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
	[self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
	UIColor* color = [UIColor whiteColor];
	NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes= dict;
}

#pragma mark ActionDelegate
-(void)DGClickGoToSearch:(id)sender
{
    SearchPageViewController *searchpage = [[SearchPageViewController alloc] init];
    UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:searchpage];
    searchpage.FCSearchFromType = @"electrician";
    [self.navigationController presentViewController:nctl animated:YES completion:nil];
}

-(void)DGSelectDateDone:(NSString *)starttime EndTime:(NSString *)endtime
{
	
}

-(void)DGAreaSelectDone:(NSArray *)sender
{
	for(int i=0;i<[sender count];i++)
	{
		NSDictionary *dictemp = [sender objectAtIndex:i];
		FCzoneid = [FCzoneid length]==0?[dictemp objectForKey:@"id"]:[NSString stringWithFormat:@"%@,%@",FCzoneid,[dictemp objectForKey:@"id"]];
	}
	[self getwaterlist:@"1" Pagesize:@"10"];
}


#pragma mark IBaction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}


-(void)ClickSelecttixian:(id)sender
{
	//排序分
	//金额  从小到大   从大到小
	//数量  从小到大   从大到小
	//远近  从远到近   从近到远
	//激活  已激活  未激活
	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnWaterListSelectItembt3];
    if([FCorderid isEqualToString:@""])
    {
        FCorderid= @"desc";
        //        [buttonitem1 updatelabstr:@"从大到小"];
        //        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
	else if([FCorderid isEqualToString:@"desc"])
	{
		FCorderid= @"asc";
//        [buttonitem1 updatelabstr:@"从小到大"];
//        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
		[buttonitem1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
	}
	else
	{
		FCorderid= @"desc";
//        [buttonitem1 updatelabstr:@"从大到小"];
//        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
		[buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
	}
	
	[self getwaterlist:@"1" Pagesize:@"10"];
}

-(void)ClickSelectarea:(id)sender
{
//	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnWaterListSelectItembt2];
//    [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
//    [buttonitem1 updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
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

-(void)ClickSelectusertype:(id)sender
{
	
//	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnWaterListSelectItembt1];
//    [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
//    [buttonitem1 updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
	[arrayselectitem removeAllObjects];
	if (flagnow==0)
	{
		enselectitem =  EnSortMoreSelectUserType;
		flagnow = 1;
		for(int i=0;i<[FCarrayelectric count];i++)
		{
			NSDictionary *dictemp = [FCarrayelectric objectAtIndex:i];
			[arrayselectitem addObject:[dictemp objectForKey:@"name"]];
		}
		if([arrayselectitem count]>0)
		{
			[self initandydroplist:sender];
			[self.view insertSubview:andydroplist belowSubview:sender];
			[andydroplist showList];
		}
		else
		{
			[MBProgressHUD showError:@"当前无类型,无法选择" toView:app.window];
		}
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
	if(enselectitem == EnSortMoreSelectArea)  //选择的区域
	{
		if([aStr isEqualToString:@"区域选择"])
		{
			AreaSelectViewController *areaseelct = [[AreaSelectViewController alloc] init];
            areaseelct.delegate1 = self;
			[self.navigationController pushViewController:areaseelct animated:YES];
		}
        else
        {
            FCzoneid = @"";
            [self getwaterlist:@"1" Pagesize:@"10"];
        }
	}
	else if(enselectitem == EnSortMoreSelectUserType) //选择的用户
	{
		ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnWaterListSelectItembt1];
		[buttonitem1 updatelabstr:aStr];
		FCwatertypeid = [AddInterface returnselectid:FCarrayelectric SelectValue:aStr];
        [self getwaterlist:@"1" Pagesize:@"10"];
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
	WaterPersonCellView *scancell = [[WaterPersonCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 59) DicFrom:dictemp UserType:FCwatertypeid];
	[cell.contentView addSubview:scancell];
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
	WaterPersonTiXianHistoryViewController *waterperson = [[WaterPersonTiXianHistoryViewController alloc] init];
    waterperson.FCelectricianid = [dictemp objectForKey:@"userid"];
	[self.navigationController pushViewController:waterperson animated:YES];
}


#pragma mark 接口
-(void)getwatertype
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQWaterTypeCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			FCarrayelectric = [[dic objectForKey:@"data"] objectForKey:@"electricianownertypelist"];
			
		}
		else
		{
			[MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		}
	} Failur:^(NSString *strmsg) {
		[MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
		
	}];
}

-(void)getwaterlist:(NSString *)page Pagesize:(NSString *)pagesize
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fdistributorid"] = [self.FCzjxid length]==0?@"":self.FCzjxid;
	params[@"name"] = FCsearchname;
	params[@"electricianownertypeid"] = FCwatertypeid;
	params[@"zoneid"] = FCzoneid;
	params[@"orderitem"] = FCorderitemvalue;
	params[@"order"] = FCorderid;
	params[@"page"] = page;
	params[@"pagesize"] = pagesize;
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQWaterPersonMangerCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			
			FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"electricianlist"];
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
		[MBProgressHUD showError:@"请求失败,请检查网络喔" toView:self.view];
		
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
