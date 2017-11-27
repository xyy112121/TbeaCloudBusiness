//
//  WaterMettingViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/3.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "WaterMettingViewController.h"

@interface WaterMettingViewController ()

@end

@implementation WaterMettingViewController

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
	self.title = @"水电工会议";
    self.view.backgroundColor = [UIColor whiteColor];
	flagnow=0;
    
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    arrayselectitem = [[NSMutableArray alloc] init];
    FCmettingcode=@"";
    FCzoneid=@"";
    FCmeetingstatusid=@"";
    FCmeetingstarttime=@"";
    FCmeetingendttime=@"";
    FCorderitem=@"";
    FCorderid=@"";
    
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 220, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight-220)];
	tableview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    [self addtabviewheader];
    
    [self gethpmettingstatus];
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf gethpmetting:@"1" PageSize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf gethpmetting:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
    
    [self gethpmetting:@"1" PageSize:@"10"];
}

-(void)addtabviewheader
{
	UIView *tabviewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
	tabviewheader.backgroundColor = [UIColor clearColor];
	[tabviewheader addSubview:[self searchbarview]];
	UIView *viewcash = [self cashdataview];
	[tabviewheader addSubview:viewcash];
    
    UIImageView *imagegraybg = [[UIImageView alloc] initWithFrame:CGRectMake(0, XYViewBottom(viewcash), SCREEN_WIDTH, 10)];
    imagegraybg.backgroundColor = COLORNOW(235, 235, 235);
    [tabviewheader addSubview:imagegraybg];
    
	[tabviewheader addSubview:[self viewselectitemtop:CGRectMake(0, XYViewBottom(viewcash)+10, SCREEN_WIDTH, 90)]];
	
	[self.view addSubview:tabviewheader];
}

-(UIView *)searchbarview
{
	UIView *viewsearch = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
	viewsearch.backgroundColor = COLORNOW(0, 170, 238);
	
	SearchTextFieldView *searchtext = [[SearchTextFieldView alloc] initWithFrame:CGRectMake(60, 10, SCREEN_WIDTH-120, 30) Pastr:@"会议查询"];
	searchtext.delegate1 = self;
	[viewsearch addSubview:searchtext];
	
	return viewsearch;
	
	
}

-(UIView *)cashdataview
{
	UIView *viewcash = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 70)];
	viewcash.backgroundColor = [UIColor whiteColor];
	
	//会议列表
	UIButton *buttonmettinglist = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonmettinglist.frame = CGRectMake(30, 10, 60, 60);
	buttonmettinglist.backgroundColor = [UIColor clearColor];
    [buttonmettinglist setImage:LOADIMAGE(@"metting会议列表", @"png") forState:UIControlStateNormal];
	[buttonmettinglist addTarget:self action:@selector(gotomettinglist:) forControlEvents:UIControlEventTouchUpInside];
	[viewcash addSubview:buttonmettinglist];
	
	//水电工签到
	UIButton *buttonwatercheckin = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonwatercheckin.frame = CGRectMake(XYViewR(buttonmettinglist)+20, XYViewTop(buttonmettinglist), 60, 60);
	buttonwatercheckin.backgroundColor = [UIColor clearColor];
    [buttonwatercheckin setImage:LOADIMAGE(@"metting水电工签到", @"png") forState:UIControlStateNormal];
	[buttonwatercheckin addTarget:self action:@selector(gotowatercheckin:) forControlEvents:UIControlEventTouchUpInside];
	[viewcash addSubview:buttonwatercheckin];
	
	return viewcash;
}

//表头
-(UIView *)viewselectitemtop:(CGRect)frame
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
	
	//月排行
	UIButton *buttonmonth = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonmonth.frame = CGRectMake(17, 10, 80, 30);
	buttonmonth.backgroundColor = [UIColor clearColor];
	[buttonmonth setTitle:@"最新会议" forState:UIControlStateNormal];
	buttonmonth.titleLabel.font = FONTB(17.0f);
	[buttonmonth setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[viewselectitem addSubview:buttonmonth];
	
	
	//更多
	UIButton *buttonmore = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonmore.frame = CGRectMake(SCREEN_WIDTH-50, XYViewTop(buttonmonth), 40, 30);
	buttonmore.backgroundColor = [UIColor clearColor];
	[buttonmore setImage:LOADIMAGE(@"morepoint", @"png") forState:UIControlStateNormal];
	[buttonmore addTarget:self action:@selector(gotomettingmore:) forControlEvents:UIControlEventTouchUpInside];
	[viewselectitem addSubview:buttonmore];
	
	float widthnow = (SCREEN_WIDTH-20)/8;
	
	//会议编号
	ButtonItemLayoutView *buttonmetting = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, XYViewBottom(line1), widthnow*3, 40)];
	[buttonmetting.button addTarget:self action:@selector(ClickSelectmettingcode:) forControlEvents:UIControlEventTouchUpInside];
	buttonmetting.tag = EnWaterMettingSelectItembt1;
	[buttonmetting updatebuttonitem:EnButtonTextLeft TextStr:@"会议编号" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
	[viewselectitem addSubview:buttonmetting];
	
	//区域
	ButtonItemLayoutView *buttonitemarea = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow*3, XYViewBottom(line1), widthnow*1.5, 40)];
	[buttonitemarea.button addTarget:self action:@selector(ClickSelectarea:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemarea.tag = EnWaterMettingSelectItembt2;
	[buttonitemarea updatebuttonitem:EnButtonTextCenter TextStr:@"区域" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrowgrayunder", @"png")];
	[viewselectitem addSubview:buttonitemarea];
	
	//状态
	ButtonItemLayoutView *buttonitemstatus = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow*4.5, XYViewBottom(line1), widthnow*1.5, 40)];
	[buttonitemstatus.button addTarget:self action:@selector(ClickSelectStatus:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemstatus.tag = EnWaterMettingSelectItembt3;
	[buttonitemstatus updatebuttonitem:EnButtonTextCenter TextStr:@"状态" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrowgrayunder", @"png")];
	[viewselectitem addSubview:buttonitemstatus];
	
	//时间
	ButtonItemLayoutView *buttonitemtime = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow*6, XYViewBottom(line1), widthnow*2, 40)];
	[buttonitemtime.button addTarget:self action:@selector(ClickSelecttime:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemtime.tag = EnWaterMettingSelectItembt4;
	[buttonitemtime updatebuttonitem:EnButtonTextCenter TextStr:@"时间" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
	[viewselectitem addSubview:buttonitemtime];
	
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
-(void)DGClickGoToSearch:(id)sender
{
    SearchPageViewController *searchpage = [[SearchPageViewController alloc] init];
    UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:searchpage];
    searchpage.FCSearchFromType = @"servicemeeting";
    [self.navigationController presentViewController:nctl animated:YES completion:nil];
}

-(void)DGSelectDateDone:(NSString *)starttime EndTime:(NSString *)endtime
{
    
}

-(void)DGAreaSelectDone:(NSArray *)sender
{
    NSString *selectzone;
    for(int i=0;i<[sender count];i++)
    {
        NSDictionary *dictemp = [sender objectAtIndex:i];
        FCzoneid = [FCzoneid length]==0?[dictemp objectForKey:@"id"]:[NSString stringWithFormat:@"%@,%@",FCzoneid,[dictemp objectForKey:@"id"]];
        
        selectzone = [selectzone length]==0?[dictemp objectForKey:@"name"]:[NSString stringWithFormat:@"%@,%@",selectzone,[dictemp objectForKey:@"name"]];
    }
    ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnWaterMettingSelectItembt2];
    [buttonitem updatelabstr:selectzone];
    
    [self gethpmetting:@"1" PageSize:@"10"];
}

#pragma mark IBaction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)gotomettingmore:(id)sender
{
    WaterMettingListViewController *watermettinglist = [[WaterMettingListViewController alloc] init];
    [self.navigationController pushViewController:watermettinglist animated:YES];
}

-(void)ClickSelectmettingcode:(id)sender
{
	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnWaterMettingSelectItembt1];
    if([FCorderid isEqualToString:@"desc"])
    {
        FCorderid= @"asc";
        FCorderitem = @"meetingcode";
        //  [buttonitem1 updatelabstr:@"从小到大"];
        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
        [buttonitem1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else
    {
        FCorderid= @"desc";
        FCorderitem = @"meetingcode";
        //   [buttonitem1 updatelabstr:@"从大到小"];
        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    [self gethpmetting:@"1" PageSize:@"10"];
}

-(void)ClickSelectarea:(id)sender
{
    
    ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnWaterMettingSelectItembt2];
    [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
    [buttonitem1 updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
    [arrayselectitem removeAllObjects];
    if (flagnow==0)
    {
        enselectitem =  EnWaterMettingarea;
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

-(void)ClickSelectStatus:(id)sender
{
	ButtonItemLayoutView *buttonitem3 = [self.view viewWithTag:EnWaterMettingSelectItembt3];
	[buttonitem3 updatelablecolor:COLORNOW(0, 170, 236)];
	[buttonitem3 updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
    [arrayselectitem removeAllObjects];
	if (flagnow==0)
	{
		enselectitem =  EnWaterMettingstatus;
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

-(void)ClickSelecttime:(id)sender
{
	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnWaterMettingSelectItembt4];
    if([FCorderid isEqualToString:@"desc"])
    {
        FCorderid= @"asc";
        FCorderitem = @"meetingtime";
      //  [buttonitem1 updatelabstr:@"从小到大"];
        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
        [buttonitem1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else
    {
        FCorderid= @"desc";
        FCorderitem = @"meetingtime";
     //   [buttonitem1 updatelabstr:@"从大到小"];
        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    [self gethpmetting:@"1" PageSize:@"10"];
}

-(void)gotomettinglist:(id)sender
{
	WaterMettingListViewController *watermettinglist = [[WaterMettingListViewController alloc] init];
	[self.navigationController pushViewController:watermettinglist animated:YES];
}

-(void)gotowatercheckin:(id)sender
{
	WaterMettingCheckInListViewController *watermettinglist = [[WaterMettingCheckInListViewController alloc] init];
	[self.navigationController pushViewController:watermettinglist animated:YES];
}

#pragma mark TYYNavFilterDelegate
-(AndyDropDownList *)initandydroplist:(UIButton *)button
{
	andydroplist = [[AndyDropDownList alloc] initWithListDataSource:arrayselectitem rowHeight:44 view:button Frame:CGRectMake(0, 220, SCREEN_WIDTH, SCREEN_HEIGHT-220)];
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
	if(enselectitem == EnWaterMettingarea)
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
            ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnWaterMettingSelectItembt2];
            [buttonitem1 updatelabstr:@"全部区域"];
        }
		
	}
	else if(enselectitem == EnWaterMettingstatus)
	{
        FCmeetingstatusid = [AddInterface returnselectid:FCarraystatus SelectValue:aStr];
	}
    [self gethpmetting:@"1" PageSize:@"10"];
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
	
	
	float widthnow = (SCREEN_WIDTH-20)/8;
	
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    
	UILabel *lablecode = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, widthnow*3, 20)];
	lablecode.text = [dictemp objectForKey:@"meetingcode"];
	lablecode.font = FONTN(13.0f);
	lablecode.textColor = [UIColor blackColor];
	lablecode.textAlignment = NSTextAlignmentLeft;
	lablecode.backgroundColor = [UIColor clearColor];
	[cell.contentView addSubview:lablecode];
	
	
	UILabel *lablearea = [[UILabel alloc] initWithFrame:CGRectMake(10+widthnow*3, 10, widthnow*1.5, 20)];
	lablearea.text = [dictemp objectForKey:@"zone"];
	lablearea.font = FONTN(13.0f);
	lablearea.textColor = [UIColor blackColor];
	lablearea.textAlignment = NSTextAlignmentCenter;
	lablearea.backgroundColor = [UIColor clearColor];
	[cell.contentView addSubview:lablearea];
	
	UILabel *lablestatus = [[UILabel alloc] initWithFrame:CGRectMake(10+widthnow*4.5, 10, widthnow*1.5, 20)];
	lablestatus.text = [dictemp objectForKey:@"meetingstatus"];
	lablestatus.font = FONTN(13.0f);
	lablestatus.textColor = [UIColor blackColor];
	lablestatus.textAlignment = NSTextAlignmentCenter;
	lablestatus.backgroundColor = [UIColor clearColor];
	[cell.contentView addSubview:lablestatus];
	
	NSString *strtiem = [dictemp objectForKey:@"meetingtime"];
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-widthnow*2-10, 10, widthnow*2, 20)];
	labeltime.text = strtiem;;
	labeltime.textColor = [UIColor blackColor];
	labeltime.font = FONTN(13.0f);
	labeltime.textAlignment = NSTextAlignmentCenter;
	[cell.contentView addSubview:labeltime];
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    WaterMettingDetailViewController *mettingdetail = [[WaterMettingDetailViewController alloc] init];
    mettingdetail.FCmettingid = [dictemp objectForKey:@"id"];
    [self.navigationController pushViewController:mettingdetail animated:YES];
}

#pragma mark 接口
-(void)gethpmettingstatus
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQWaterMettingStatusHpCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraystatus = [[dic objectForKey:@"data"] objectForKey:@"meetingstatuslist"];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}

-(void)gethpmetting:(NSString *)page PageSize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"meetingcode"] = FCmettingcode;
    params[@"zoneid"] = FCzoneid;
    params[@"meetingstatusid"] = FCmeetingstatusid;
    params[@"meetingstarttime"] = FCmeetingstarttime;
    params[@"meetingendtime"] = FCmeetingendttime;
    params[@"orderitem"] = FCorderitem;
    params[@"order"] = FCorderid;
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQWaterMettingViewHpCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"meetinglist"];
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
