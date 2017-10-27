//
//  CheckInHistoryViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "CheckInHistoryViewController.h"

@interface CheckInHistoryViewController ()

@end

@implementation CheckInHistoryViewController

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
	self.title = @"签到历史";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	enselectitem = EnCheckInSelectmetting; //默认选择的会议
    arrayselectitem = [[NSMutableArray alloc] init];
    FCelectricianid = @"";
    FCmeetingcode = @"";
    FCzoneid = @"";
    FCstartdate = @"";
    FCenddate = @"";
    FCorderitem = @"";
    FCorder = @"desc";
    
    
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT-64-100)];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	
	[self setExtraCellLineHidden:tableview];
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getcheckinhistory:@"1" PageSize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getcheckinhistory:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
    
    
    [self getcheckinhistory:@"1" PageSize:@"10"];
}

-(void)addtabviewheader
{
	UIView *tabviewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
	tabviewheader.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tabviewheader];
	[tabviewheader addSubview:[self viewselectitem:CGRectMake(0, 0, SCREEN_WIDTH, 100)]];
}


//表头
-(UIView *)viewselectitem:(CGRect)frame
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
	
	[self wateruserheader:viewselectitem];
	
	float widthnow = (SCREEN_WIDTH-20)/3;
	
	//会议编号
	ButtonItemLayoutView *buttonmetting = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, XYViewBottom(line1), widthnow, 40)];
//	[buttonmetting.button addTarget:self action:@selector(ClickSelectmetting:) forControlEvents:UIControlEventTouchUpInside];
	buttonmetting.tag = EnWaterCheckInSelectItembt1;
	[buttonmetting updatebuttonitem:EnButtonTextLeft TextStr:@"会议编号" Font:FONTN(14.0f) Color:COLORNOW(0, 170, 236) Image:nil];
	[viewselectitem addSubview:buttonmetting];
	
	//区域
	ButtonItemLayoutView *buttonitemarea = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow, XYViewBottom(line1), widthnow, 40)];
	[buttonitemarea.button addTarget:self action:@selector(ClickSelectarea:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemarea.tag = EnWaterCheckInSelectItembt2;
	[buttonitemarea updatebuttonitem:EnButtonTextCenter TextStr:@"区域" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrowgrayunder", @"png")];
	[viewselectitem addSubview:buttonitemarea];
	
	//时间
	ButtonItemLayoutView *buttonitemtime = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow*2, XYViewBottom(line1), widthnow, 40)];
	[buttonitemtime.button addTarget:self action:@selector(ClickSelecttime:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemtime.tag = EnWaterCheckInSelectItembt3;
	[buttonitemtime updatebuttonitem:EnButtonTextRight TextStr:@"时间" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrowgrayunder", @"png")];
	[viewselectitem addSubview:buttonitemtime];
	
	return viewselectitem;
}

-(void)wateruserheader:(UIView *)viewheader
{
	float nowwidth = (SCREEN_WIDTH-40)/4;
	
	UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
	imageheader.image = LOADIMAGE(@"scanrebatetest1", @"png");
	[viewheader addSubview:imageheader];
	
	NSString *strname = @"江南小颖";
	CGSize size = [AddInterface getlablesize:strname Fwidth:200 Fheight:20 Sfont:FONTN(14.0f)];
	UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewTop(imageheader)+10, size.width, 20)];
	lablename.text =strname;
	lablename.font = FONTN(14.0f);
	lablename.textColor = COLORNOW(117, 117, 117);
	lablename.backgroundColor = [UIColor clearColor];
	[viewheader addSubview:lablename];
	
	UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(lablename)+5, XYViewTop(lablename)+5, 10, 10)];
	imageicon.image = LOADIMAGE(@"scanrebateheader1", @"png");
	[viewheader addSubview:imageicon];
	
	
	UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-nowwidth-10, 20, nowwidth, 20)];
	lablemoneyvalue.text = @"2140";
	lablemoneyvalue.font = FONTMEDIUM(17.0f);
	lablemoneyvalue.textAlignment = NSTextAlignmentRight;
	lablemoneyvalue.textColor = [UIColor blackColor];
	lablemoneyvalue.backgroundColor = [UIColor clearColor];
	[viewheader addSubview:lablemoneyvalue];
	
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


-(void)ClickSelectarea:(id)sender
{
	
	ButtonItemLayoutView *buttonitem2 = [self.view viewWithTag:EnWaterCheckInSelectItembt2];
	
	
	[buttonitem2 updatelablecolor:COLORNOW(0, 170, 236)];

	[buttonitem2 updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
	if (flagnow==0)
	{
		enselectitem =  EnCheckInSelectarea;
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

-(void)ClickSelecttime:(id)sender
{
	ButtonItemLayoutView *buttonitem3 = [self.view viewWithTag:EnWaterCheckInSelectItembt3];
	[buttonitem3 updatelablecolor:COLORNOW(0, 170, 236)];
	[buttonitem3 updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
    
	if (flagnow==0)
	{
		enselectitem =  EnCheckInSelecttime;
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
	andydroplist = [[AndyDropDownList alloc] initWithListDataSource:arrayselectitem rowHeight:44 view:button Frame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT)];
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
        ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnWaterCheckInSelectItembt3];
//        [buttonitem updatelabstr:astr];
        [buttonitem updatelablecolor:COLORNOW(0, 170, 238)];
        [buttonitem updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
        if([astr isEqualToString:@"默认"]||[astr isEqualToString:@"正序"])
        {
            [self getcheckinhistory:@"1" PageSize:@"10"];
        }
        else if([astr isEqualToString:@"倒序"])
        {
            FCorder = @"asc";
            [self getcheckinhistory:@"1" PageSize:@"10"];
        }
        else if([astr isEqualToString:@"自定义"])
        {
            FCorderitem = @"";
            TimeSelectViewController *timeselect = [[TimeSelectViewController alloc] init];
            timeselect.delegate1 = self;
            [self.navigationController pushViewController:timeselect animated:YES];
        }
    }
    else if(enselectitem == EnCheckInSelectarea)
    {
        if([astr isEqualToString:@"区域选择"])
        {
            AreaSelectViewController *areaseelct = [[AreaSelectViewController alloc] init];
            areaseelct.delegate1 = self;
            [self.navigationController pushViewController:areaseelct animated:YES];
        }
        else
        {
            FCzoneid = @"";
            ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnWaterCheckInSelectItembt2];
//            [buttonitem1 updatelabstr:@"全部区域"];
            [buttonitem1 updatelablecolor:COLORNOW(0, 170, 238)];
            [self getcheckinhistory:@"1" PageSize:@"10"];
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
	
	float widthnow = (SCREEN_WIDTH-20)/3;
	
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    
	UILabel *lablecode = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, widthnow, 20)];
	lablecode.text = [dictemp objectForKey:@"meetingcode"];
	lablecode.font = FONTN(13.0f);
	lablecode.textColor = [UIColor blackColor];
	lablecode.textAlignment = NSTextAlignmentLeft;
	lablecode.backgroundColor = [UIColor clearColor];
	[cell.contentView addSubview:lablecode];
	
	
	UILabel *lablearea = [[UILabel alloc] initWithFrame:CGRectMake(10+widthnow, 10, widthnow, 20)];
	lablearea.text = [dictemp objectForKey:@"zone"];
	lablearea.font = FONTN(13.0f);
	lablearea.textColor = [UIColor blackColor];
	lablearea.textAlignment = NSTextAlignmentCenter;
	lablearea.backgroundColor = [UIColor clearColor];
	[cell.contentView addSubview:lablearea];
	
	NSString *strtiem = [dictemp objectForKey:@"attendtime"];
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-widthnow-30, 10, widthnow+20, 20)];
	labeltime.text = strtiem;;
	labeltime.textColor = [UIColor blackColor];
	labeltime.font = FONTN(13.0f);
	labeltime.textAlignment = NSTextAlignmentRight;
	[cell.contentView addSubview:labeltime];
	
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//	WaterLoginViewController *login = [[WaterLoginViewController alloc] init];
//	[self.navigationController pushViewController:login animated:YES];
}


#pragma mark 接口
-(void)getcheckinhistory:(NSString *)page PageSize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"electricianid"] = FCelectricianid;
    params[@"meetingcode"] = FCmeetingcode;
    params[@"zoneid"] = FCzoneid;
    params[@"startdate"] = FCstartdate;
    params[@"enddate"] = FCenddate;
    params[@"orderitem"] = FCorderitem;
    params[@"order"] = FCorder;
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:REWaterPersonQianDaoHistory ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"attendmeetinglist"];
            FCdicdata = [[dic objectForKey:@"data"] objectForKey:@"electricianinfo"];
            tableview.delegate = self;
            tableview.dataSource = self;
            [self addtabviewheader];
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
