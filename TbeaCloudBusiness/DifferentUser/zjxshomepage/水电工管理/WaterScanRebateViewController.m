//
//  WaterScanRebateViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/1.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "WaterScanRebateViewController.h"

@interface WaterScanRebateViewController ()

@end

@implementation WaterScanRebateViewController
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
	self.title = @"扫码数据";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	selecttype = EnWaterScanType;
//	enselectitem = EnWaterScanSelectDate; //默认选择的时间
	
    FCarrayxinhao = [[NSArray alloc] init];
    arrayselectitem = [[NSMutableArray alloc] init];
    FCstartdate=@"";
    FCenddate=@"";
    FCcommoditymodelspecification=@"";
    FCconfirmstatusid=@"";
    FCorderitem=@"";
    FCorder=@"desc";
    
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	[self addtabviewheader];
	[self setExtraCellLineHidden:tableview];
    
    [self getwaterrebatestatus];//获取状态
    
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getwaterrebatelist:@"1" Pagesize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getwaterrebatelist:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
    
    [self getwaterrebatelist:@"1" Pagesize:@"10"];
}

-(void)addtabviewheader
{
	UIView *tabviewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
	tabviewheader.backgroundColor = [UIColor clearColor];
	tableview.tableHeaderView = tabviewheader;
	[tabviewheader addSubview:[self viewselectitem:CGRectMake(0, 0, SCREEN_WIDTH, 90)]];
}


//表头
-(UIView *)viewselectitem:(CGRect)frame
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
	
	//支付
	UIButton *buttonzhifu = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonzhifu.frame = CGRectMake(17, 10, 60, 30);
	buttonzhifu.backgroundColor = [UIColor clearColor];
	[buttonzhifu setTitle:@"扫码" forState:UIControlStateNormal];
	buttonzhifu.titleLabel.font = FONTB(17.0f);
	buttonzhifu.tag = EnWaterScanCodeBt;
	[buttonzhifu addTarget:self action:@selector(clickScan:) forControlEvents:UIControlEventTouchUpInside];
	[buttonzhifu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[viewselectitem addSubview:buttonzhifu];
	
	//未支付
	UIButton *buttonallweizhifu = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonallweizhifu.frame = CGRectMake(XYViewR(buttonzhifu), 10, 60, 30);
	buttonallweizhifu.backgroundColor = [UIColor clearColor];
	[buttonallweizhifu setTitle:@"提现" forState:UIControlStateNormal];
	buttonallweizhifu.titleLabel.font = FONTN(15.0f);
	buttonallweizhifu.tag = EnWaterTiXianBt;
	[buttonallweizhifu addTarget:self action:@selector(clickTiXian:) forControlEvents:UIControlEventTouchUpInside];
	[buttonallweizhifu setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
	[viewselectitem addSubview:buttonallweizhifu];
	
	if(selecttype == EnWaterScanType)
        [self addscancodeselectitem:viewselectitem Line1:line1];
    else if(selecttype == EnWaterTiXianType)
        [self addtixianselectitem:viewselectitem Line1:line1];
	
	return viewselectitem;
}


-(void)addscancodeselectitem:(UIView *)viewselectitem Line1:(UIImageView *)line1
{
    float widthnow = (SCREEN_WIDTH-20)/3;
    //时间
    ButtonItemLayoutView *buttonitemtime = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, XYViewBottom(line1), widthnow, 40)];
    [buttonitemtime.button addTarget:self action:@selector(ClickSelecttime:) forControlEvents:UIControlEventTouchUpInside];
    buttonitemtime.tag = EnTixianDataSelectItembt1;
    [buttonitemtime updatebuttonitem:EnButtonTextLeft TextStr:@"时间" Font:FONTN(14.0f) Color:COLORNOW(0, 170, 236) Image:LOADIMAGE(@"arrowblueunder", @"png")];
    [viewselectitem addSubview:buttonitemtime];
    
    //全部用户
    ButtonItemLayoutView *buttonitemstatus = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow+10, XYViewBottom(line1), widthnow, 40)];
    [buttonitemstatus.button addTarget:self action:@selector(ClickSelectStatus:) forControlEvents:UIControlEventTouchUpInside];
    buttonitemstatus.tag = EnTixianDataSelectItembt2;
    [buttonitemstatus updatebuttonitem:EnButtonTextCenter TextStr:@"状态" Font:FONTN(14.0f) Color:COLORNOW(0, 170, 236) Image:LOADIMAGE(@"arrowblueunder", @"png")];
    [viewselectitem addSubview:buttonitemstatus];
    
    //金额
    ButtonItemLayoutView *buttonitemmoney = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow*2, XYViewBottom(line1), widthnow, 40)];
    [buttonitemmoney.button addTarget:self action:@selector(ClickSelectMoney:) forControlEvents:UIControlEventTouchUpInside];
    buttonitemmoney.tag = EnTixianDataSelectItembt3;
    [buttonitemmoney updatebuttonitem:EnButtonTextRight TextStr:@"金额" Font:FONTN(14.0f) Color:COLORNOW(0, 170, 236) Image:LOADIMAGE(@"arrawgray", @"png")];
    [viewselectitem addSubview:buttonitemmoney];
}

-(void)addtixianselectitem:(UIView *)viewselectitem Line1:(UIImageView *)line1
{
    float widthnow = (SCREEN_WIDTH-20)/3;
    //时间
    ButtonItemLayoutView *buttonitemtime = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, XYViewBottom(line1), widthnow, 40)];
    [buttonitemtime.button addTarget:self action:@selector(ClickSelecttime:) forControlEvents:UIControlEventTouchUpInside];
    buttonitemtime.tag = EnTixianDataSelectItembt1;
    [buttonitemtime updatebuttonitem:EnButtonTextLeft TextStr:@"时间" Font:FONTN(14.0f) Color:COLORNOW(0, 170, 236) Image:LOADIMAGE(@"arrowblueunder", @"png")];
    [viewselectitem addSubview:buttonitemtime];
    
    //区域
    ButtonItemLayoutView *buttonitemarea = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow+10, XYViewBottom(line1), widthnow, 40)];
    buttonitemarea.tag = EnTixianDataSelectItembt2;
    [buttonitemarea updatebuttonitem:EnButtonTextCenter TextStr:@"地区" Font:FONTN(14.0f) Color:COLORNOW(0, 170, 236) Image:nil];
    [viewselectitem addSubview:buttonitemarea];
    
    //金额
    ButtonItemLayoutView *buttonitemmoney = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow*2, XYViewBottom(line1), widthnow, 40)];
    [buttonitemmoney.button addTarget:self action:@selector(ClickSelectMoney:) forControlEvents:UIControlEventTouchUpInside];
    buttonitemmoney.tag = EnTixianDataSelectItembt3;
    [buttonitemmoney updatebuttonitem:EnButtonTextRight TextStr:@"金额" Font:FONTN(14.0f) Color:COLORNOW(0, 170, 236) Image:LOADIMAGE(@"arrawgray", @"png")];
    [viewselectitem addSubview:buttonitemmoney];
}

-(void)addtotlemoneyinfo:(NSString *)totlemoney
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBarAndNavigationHeight-50, SCREEN_WIDTH, 50)];
    view.backgroundColor = COLORNOW(240, 133, 56);
    view.tag = EnWaterPersonScanTiXianMoneyView;
    [self.view addSubview:view];
    
    UILabel *labeltixian = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 100, 20)];
    labeltixian.text = @"提现金额";
    labeltixian.textColor = [UIColor whiteColor];
    labeltixian.font = FONTN(15.0f);
    [view addSubview:labeltixian];
    
    UILabel *labeltixianvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-150, 15, 150, 20)];
    labeltixianvalue.text = [NSString stringWithFormat:@"￥%@",totlemoney];
    labeltixianvalue.textColor = [UIColor whiteColor];
    labeltixianvalue.font = FONTN(15.0f);
    labeltixianvalue.textAlignment = NSTextAlignmentRight;
    [view addSubview:labeltixianvalue];
}

-(void)viewWillAppear:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:NO animated:YES];
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


#pragma mark IBaction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)clickScan:(id)sender
{
    if(selecttype == EnWaterScanType)
    {
        
    }
    else
    {
        selecttype = EnWaterScanType;
        tableview.tableHeaderView = nil;
        [self addtabviewheader];
    }
	UIButton *button1 = [self.view viewWithTag:EnWaterScanCodeBt];
	UIButton *button2 = [self.view viewWithTag:EnWaterTiXianBt];
    button1.titleLabel.font = FONTB(17.0f);
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.titleLabel.font = FONTB(15.0f);
    [button2 setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
    
    
    ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnTixianDataSelectItembt1];
    ButtonItemLayoutView *buttonitem2 = [self.view viewWithTag:EnTixianDataSelectItembt2];
    ButtonItemLayoutView *buttonitem3 = [self.view viewWithTag:EnTixianDataSelectItembt3];
    [buttonitem1 updatelablecolor:COLORNOW(117, 117, 117)];
    [buttonitem2 updatelablecolor:COLORNOW(117, 117, 117)];
    [buttonitem3 updatelablecolor:COLORNOW(117, 117, 117)];
	
	
	enselectitem = EnWaterScanSelectDate;
	[tableview reloadData];
	
	flagnow = 0;
	[andydroplist hiddenList];
    [self getwaterrebatelist:@"1" Pagesize:@"10"];
}

-(void)clickTiXian:(id)sender
{
    if(selecttype == EnWaterTiXianType)
    {
       
    }
    else
    {
        selecttype = EnWaterTiXianType;
        tableview.tableHeaderView = nil;
         [self addtabviewheader];
    }
	UIButton *button1 = [self.view viewWithTag:EnWaterScanCodeBt];
	UIButton *button2 = [self.view viewWithTag:EnWaterTiXianBt];
    button2.titleLabel.font = FONTB(17.0f);
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.titleLabel.font = FONTB(15.0f);
    [button1 setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
    
	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnTixianDataSelectItembt1];
	ButtonItemLayoutView *buttonitem2 = [self.view viewWithTag:EnTixianDataSelectItembt2];
	ButtonItemLayoutView *buttonitem3 = [self.view viewWithTag:EnTixianDataSelectItembt3];
	[buttonitem1 updatelablecolor:COLORNOW(117, 117, 117)];
    [buttonitem2 updatelablecolor:COLORNOW(117, 117, 117)];
    [buttonitem3 updatelablecolor:COLORNOW(117, 117, 117)];
	
	
	enselectitem = EnWaterScanSelectDate;
	[tableview reloadData];
	
	flagnow = 0;
	[andydroplist hiddenList];
    
    [self getwaterrebatelist:@"1" Pagesize:@"10"];
}


-(void)ClickSelectMoney:(id)sender
{
    ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnTixianDataSelectItembt3];
    if([FCorder isEqualToString:@"desc"])
    {
        FCorder= @"asc";
        FCorderitem = @"money";
        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
        [buttonitem1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else
    {
        FCorder= @"desc";
        FCorderitem = @"money";
        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    [self getwaterrebatelist:@"1" Pagesize:@"10"];
}

-(void)ClickSelectStatus:(id)sender
{
    ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnTixianDataSelectItembt2];
    [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
    [buttonitem1 updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
    
    if (flagnow==0)
    {
        flagnow = 1;
        [arrayselectitem removeAllObjects];
        enselectitem =  EnWaterScanSelectStatus; 
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

-(void)ClickSelecttime:(id)sender
{
    //排序分
    //金额  从小到大   从大到小
    //数量  从小到大   从大到小
    //远近  从远到近   从近到远
    //激活(状态)  已激活  未激活
    [arrayselectitem removeAllObjects];
    ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnTixianDataSelectItembt1];
    [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
    [buttonitem1 updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
    if (flagnow==0)
    {
        enselectitem =  EnWaterScanSelectDate;
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
        FCstartdate = @"";
        FCenddate = @"";
        FCorderitem = @"time";
        FCorder = @"desc";
        ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnRebateQRCodeHistoryButton1];
        [buttonitem updatelabstr:astr];
        if([astr isEqualToString:@"默认"]||[astr isEqualToString:@"正序"])
        {
            [self getwaterrebatelist:@"1" Pagesize:@"10"];
        }
        else if([astr isEqualToString:@"倒序"])
        {
            FCorder = @"asc";
            [self getwaterrebatelist:@"1" Pagesize:@"10"];
        }
        else if([astr isEqualToString:@"自定义"])
        {
            FCorderitem = @"";
            TimeSelectViewController *timeselect = [[TimeSelectViewController alloc] init];
            timeselect.delegate1 = self;
            [self.navigationController pushViewController:timeselect animated:YES];
        }
	}
	else if(enselectitem == EnTiXianDataSelectUser)  // 选择的型号
	{
		
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
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
	WaterPersonScanCodeCellView *watercelltype = [[WaterPersonScanCodeCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49.5) DicFrom:dictemp Type:selecttype];

	[cell.contentView addSubview:watercelltype];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
	if(selecttype == EnWaterScanType)
	{
		ScanCodeDetailViewController *scancode = [[ScanCodeDetailViewController alloc] init];
        scancode.FCqrcodeactivityid = [dictemp objectForKey:@"rebatescanid"];
		[self.navigationController pushViewController:scancode animated:YES];
	}
	else
	{
		TiXianDataDetailViewController *tixiandata = [[TiXianDataDetailViewController alloc] init];
        tixiandata.FCtakemoneyid = [dictemp objectForKey:@"takemoneyid"];
		[self.navigationController pushViewController:tixiandata animated:YES];
	}
}

#pragma mark 接口
//获取状态
-(void)getwaterrebatestatus
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:REWaterScanRebateStatusCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraystatus = [[dic objectForKey:@"data"] objectForKey:@"confirmstatuslist"];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}

-(void)getwaterrebatelist:(NSString *)page Pagesize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"electricianid"] = self.FCelectricianid;
    params[@"startdate"] = FCstartdate;
    params[@"enddate"] = FCenddate;
    params[@"confirmstatusid"] = FCconfirmstatusid;
    params[@"orderitem"] = FCorderitem;
    params[@"order"] = FCorder;
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    
    NSString *requeststr;
    if(selecttype == EnWaterTiXianType)
    {
        requeststr = RQWaterTiXianRebateListCode;
    }
    else if(selecttype == EnWaterScanType)
    {
        requeststr = RQWaterScanRebateListCode;
    }
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:requeststr ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            if(selecttype == EnWaterScanType)
            {
                [[self.view viewWithTag:EnWaterPersonScanTiXianMoneyView] removeFromSuperview];
                FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"rebatescanlist"];
            }
            else
            {
                FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"takemoneylist"];
                
                [self addtotlemoneyinfo:[[[dic objectForKey:@"data"] objectForKey:@"takemoneytotleinfo"] objectForKey:@"totlemoney"]];
            }
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
