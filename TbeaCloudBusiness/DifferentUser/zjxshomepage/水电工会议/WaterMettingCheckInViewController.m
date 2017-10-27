//
//  WaterMettingCheckInViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/6.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "WaterMettingCheckInViewController.h"

@interface WaterMettingCheckInViewController ()

@end

@implementation WaterMettingCheckInViewController

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
	self.title = @"会议签到";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	enselectitem = EnWaterMettingCheckInUser; //默认选择的时间
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
	tableview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tableview];
	[self addtabviewheader];
	[self setExtraCellLineHidden:tableview];
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getmettingqiandao:@"1" PageSize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getmettingqiandao:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
    [self getmettingqiandao:@"1" PageSize:@"10"];
}

-(void)addtabviewheader
{
	UIView *tabviewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
	tabviewheader.backgroundColor = [UIColor clearColor];
	tableview.tableHeaderView = tabviewheader;
	[tabviewheader addSubview:[self viewselectitem:CGRectMake(0, 0, SCREEN_WIDTH, 80)]];
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
	
	UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 79.5, SCREEN_WIDTH, 0.7)];
	line2.backgroundColor = COLORNOW(200, 200, 200);
	[viewselectitem addSubview:line2];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(18, 10, 140, 20)];
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textColor = [UIColor blackColor];
	labelname.text = @"签到人数:46";
	labelname.clipsToBounds = YES;
    labelname.tag = EnWaterMettingJoinMemberNumTag;
	labelname.font = FONTMEDIUM(15.0f);
	[viewselectitem addSubview:labelname];
	
	float widthnow = (SCREEN_WIDTH-20)/3;
	//用户
	ButtonItemLayoutView *buttonmetting = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, XYViewBottom(line1), widthnow, 40)];
	[buttonmetting.button addTarget:self action:@selector(ClickSelectUser:) forControlEvents:UIControlEventTouchUpInside];
	buttonmetting.tag = EnWaterMettingCheckInSelectItembt1;
	[buttonmetting updatebuttonitem:EnButtonTextLeft TextStr:@"用户" Font:FONTN(14.0f) Color:COLORNOW(0, 170, 236) Image:LOADIMAGE(@"arrawgray", @"png")];
	[viewselectitem addSubview:buttonmetting];
	
	//区域
	ButtonItemLayoutView *buttonitemarea = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow, XYViewBottom(line1), widthnow, 40)];
	[buttonitemarea.button addTarget:self action:@selector(ClickSelectArea:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemarea.tag = EnWaterMettingCheckInSelectItembt2;
	[buttonitemarea updatebuttonitem:EnButtonTextCenter TextStr:@"区域" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrowgrayunder", @"png")];
	[viewselectitem addSubview:buttonitemarea];
	
	//时间
	ButtonItemLayoutView *buttonitemtime = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow*2, XYViewBottom(line1), widthnow, 40)];
	[buttonitemtime.button addTarget:self action:@selector(ClickSelectTime:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemtime.tag = EnWaterMettingCheckInSelectItembt3;
	[buttonitemtime updatebuttonitem:EnButtonTextRight TextStr:@"时间" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
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
    ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnWaterMettingCheckInSelectItembt2];
    [buttonitem updatelabstr:selectzone];
    
    [self getmettingqiandao:@"1" PageSize:@"10"];
}

#pragma mark IBaction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)ClickSelectArea:(id)sender
{
    ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnWaterMettingCheckInSelectItembt2];
    [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
    [buttonitem1 updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
    if (flagnow==0)
    {
        enselectitem =  EnWaterMettingCheckInArea;
        flagnow = 1;
        arrayselectitem = @[@"全部区域",@"区域选择"];
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

-(void)ClickSelectUser:(id)sender
{
    ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnWaterMettingCheckInSelectItembt1];
    if([FCorderid isEqualToString:@"desc"])
    {
        FCorderid= @"asc";
        FCorderitem = @"signtime";
        //  [buttonitem1 updatelabstr:@"从小到大"];
        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
        [buttonitem1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else
    {
        FCorderid= @"desc";
        FCorderitem = @"signtime";
        //   [buttonitem1 updatelabstr:@"从大到小"];
        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    [self getmettingqiandao:@"1" PageSize:@"10"];
    
}

-(void)ClickSelectTime:(id)sender
{
    ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnWaterMettingCheckInSelectItembt3];
    if([FCorderid isEqualToString:@"desc"])
    {
        FCorderid= @"asc";
        FCorderitem = @"signuser";
        //  [buttonitem1 updatelabstr:@"从小到大"];
        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
        [buttonitem1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else
    {
        FCorderid= @"desc";
        FCorderitem = @"signuser";
        //   [buttonitem1 updatelabstr:@"从大到小"];
        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    [self getmettingqiandao:@"1" PageSize:@"10"];
}

#pragma mark TYYNavFilterDelegate
-(AndyDropDownList *)initandydroplist:(UIButton *)button
{
	andydroplist = [[AndyDropDownList alloc] initWithListDataSource:arrayselectitem rowHeight:44 view:button Frame:CGRectMake(0, 81, SCREEN_WIDTH, SCREEN_HEIGHT)];
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
	if(enselectitem == EnWaterMettingCheckInArea)
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
            ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnWaterMettingCheckInSelectItembt2];
            [buttonitem1 updatelabstr:@"全部区域"];
        }

	}
//	else if(enselectitem == EnWaterMettingCheckInTime)
//	{
//		if([aStr isEqualToString:@"自定义"])
//		{
//			TimeSelectViewController *tiemselect = [[TimeSelectViewController alloc] init];
//			[self.navigationController pushViewController:tiemselect animated:YES];
//		}
//	}

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
	
	float nowwidth = (SCREEN_WIDTH-40)/3;
	
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    
	UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
    NSString *strpic1 = [dictemp objectForKey:@"thumbpicture"];//[InterfaceResource stringByAppendingString:[[dictemp objectForKey:@"thumbpicture"] length]>0?[dictemp objectForKey:@"thumbpicture"]:@"noimage.png"];
    [imageheader setImageWithURL:[NSURL URLWithString:strpic1] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
    imageheader.layer.cornerRadius = 15.0f;
    imageheader.clipsToBounds = YES;
	[cell.contentView addSubview:imageheader];
	
	NSString *strname = [dictemp objectForKey:@"name"];
	CGSize size = [AddInterface getlablesize:strname Fwidth:200 Fheight:20 Sfont:FONTN(14.0f)];
	UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+5, 15, size.width, 20)];
	lablename.text =strname;
	lablename.font = FONTN(14.0f);
	lablename.textColor = COLORNOW(117, 117, 117);
	lablename.backgroundColor = [UIColor clearColor];
	[cell.contentView addSubview:lablename];
	
	UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(lablename)+5, XYViewTop(lablename)+5, 10, 10)];
    NSString *strpic2 = [dictemp objectForKey:@"persontypeicon"];//[InterfaceResource stringByAppendingString:[[dictemp objectForKey:@"persontypeicon"] length]>0?[dictemp objectForKey:@"persontypeicon"]:@"noimage.png"];
    [imageicon setImageWithURL:[NSURL URLWithString:strpic2] placeholderImage:LOADIMAGE(@"scanrebateheader1", @"png")];
	[cell.contentView addSubview:imageicon];
	
	UILabel *lablearea = [[UILabel alloc] initWithFrame:CGRectMake(20+nowwidth, 15, nowwidth, 20)];
	lablearea.text = [dictemp objectForKey:@"zone"];
	lablearea.font = FONTN(14.0f);
	lablearea.textColor = COLORNOW(117, 117, 117);
	lablearea.backgroundColor = [UIColor clearColor];
	lablearea.textAlignment = NSTextAlignmentCenter;
	[cell.contentView addSubview:lablearea];
	
	UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-nowwidth-30, 15, nowwidth+30, 20)];
	lablemoneyvalue.text = [dictemp objectForKey:@"signtime"];
	lablemoneyvalue.font = FONTN(14.0f);
	lablemoneyvalue.textColor = [UIColor blackColor];
	lablemoneyvalue.backgroundColor = [UIColor clearColor];
	[cell.contentView addSubview:lablemoneyvalue];
	
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//	TiXianDataDetailViewController *tixiandata = [[TiXianDataDetailViewController alloc] init];
//	[self.navigationController pushViewController:tixiandata animated:YES];
}




#pragma mark 接口
-(void)getmettingqiandao:(NSString *)page PageSize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"meetingid"] = self.FCmettingid;
    params[@"zoneid"] = FCzoneid;;
    params[@"orderitem"] = FCorderitem;
    params[@"order"] = FCorderid;
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQWaterMettingCheckInCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            UILabel *label1 = [tableview.tableHeaderView viewWithTag:EnWaterMettingJoinMemberNumTag];
            label1.text = [NSString stringWithFormat:@"签到人数:%@",[[[dic objectForKey:@"data"] objectForKey:@"meetingsigntotleinfo"] objectForKey:@"totlesignnumber"]];
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"meetingsignlist"];
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
