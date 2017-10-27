//
//  CreqteQRCodeListViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/7/3.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "CreqteQRCodeListViewController.h"

@interface CreqteQRCodeListViewController ()

@end

@implementation CreqteQRCodeListViewController

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
	self.title = @"生成查看";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	FCactivitestatusid = @"all";
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 126, SCREEN_WIDTH, SCREEN_HEIGHT-64-100)];
	tableview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tableview];
	
	[self setExtraCellLineHidden:tableview];
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getcreateqrcodelist:@"1" Pagesize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getcreateqrcodelist:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
	[self getcreateqrcodelist:@"1" Pagesize:@"10"];
}

-(void)addtabviewheader
{
	UIView *tabviewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 126)];
	tabviewheader.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tabviewheader];
	[tabviewheader addSubview:[self initviewselectitem:CGRectMake(0, 0, SCREEN_WIDTH, 126)]];
}


//表头
-(UIView *)initviewselectitem:(CGRect)frame
{
	UIView *viewselectitem = [[UIView alloc] initWithFrame:frame];
	viewselectitem.backgroundColor = [UIColor whiteColor];
	//两根灰线
	UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 86, SCREEN_WIDTH, 0.7)];
	line1.backgroundColor = COLORNOW(200, 200, 200);
	[viewselectitem addSubview:line1];
	
	UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 125.5, SCREEN_WIDTH, 0.7)];
	line2.backgroundColor = COLORNOW(200, 200, 200);
	[viewselectitem addSubview:line2];
	
	[self QRCodeListheader:viewselectitem];
	
	float widthnow = (SCREEN_WIDTH-20)/4;
	
	//状态
	ButtonItemLayoutView *buttonstatus = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-widthnow-10, XYViewBottom(line1), widthnow, 40)];
	[buttonstatus.button addTarget:self action:@selector(ClickSelectstatus:) forControlEvents:UIControlEventTouchUpInside];
	buttonstatus.tag = EnCreateQRCodeListSelectItem1;
	[buttonstatus updatebuttonitem:EnButtonTextRight TextStr:@"状态" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
	[viewselectitem addSubview:buttonstatus];
	
	return viewselectitem;
}

-(void)QRCodeListheader:(UIView *)viewheader
{
	//面额
	UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(17, 10, 60, 20)];
	lablename.text =@"面额";
	lablename.font = FONTMEDIUM(17.0f);
	lablename.textColor = [UIColor blackColor];
	lablename.backgroundColor = [UIColor clearColor];
	[viewheader addSubview:lablename];
	
	UILabel *lablemoneyflag1 = [[UILabel alloc] initWithFrame:CGRectMake(90, 10+5, 10,10)];
	lablemoneyflag1.text = @"￥";
	lablemoneyflag1.font = FONTMEDIUM(11.0f);
	lablemoneyflag1.textColor = [UIColor blackColor];
	lablemoneyflag1.backgroundColor = [UIColor clearColor];
	[viewheader addSubview:lablemoneyflag1];
	
	UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(lablemoneyflag1)+1, XYViewTop(lablemoneyflag1)-3, 200, 20)];
	lablemoneyvalue.text = [NSString stringWithFormat:@"%@",[FCrebateinfo objectForKey:@"money"]];
	lablemoneyvalue.font = FONTMEDIUM(19.0f);
	lablemoneyvalue.textColor = [UIColor blackColor];
	lablemoneyvalue.backgroundColor = [UIColor clearColor];
	[viewheader addSubview:lablemoneyvalue];
	
	//数量
	UILabel *lablenumber = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablename), XYViewBottom(lablename)+3, 60, 20)];
	lablenumber.text =@"数量";
	lablenumber.font = FONTMEDIUM(17.0f);
	lablenumber.textColor = [UIColor blackColor];
	lablenumber.backgroundColor = [UIColor clearColor];
	[viewheader addSubview:lablenumber];
	
	UILabel *lablenumbervalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablemoneyflag1), XYViewTop(lablenumber), 200, 20)];
	lablenumbervalue.text = [NSString stringWithFormat:@"%@",[FCrebateinfo objectForKey:@"number"]];
	lablenumbervalue.font = FONTMEDIUM(19.0f);
	lablenumbervalue.textColor = [UIColor blackColor];
	lablenumbervalue.backgroundColor = [UIColor clearColor];
	[viewheader addSubview:lablenumbervalue];
	
	//日期
	UILabel *labledate = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablename), XYViewBottom(lablenumber)+3, 60, 20)];
	labledate.text =@"日期";
	labledate.font = FONTMEDIUM(17.0f);
	labledate.textColor = [UIColor blackColor];
	labledate.backgroundColor = [UIColor clearColor];
	[viewheader addSubview:labledate];
	
	UILabel *labledatevalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablemoneyflag1), XYViewTop(labledate), 200, 20)];
	labledatevalue.text = [NSString stringWithFormat:@"%@",[FCrebateinfo objectForKey:@"time"]];
	labledatevalue.font = FONTN(15.0f);
	labledatevalue.textColor = [UIColor blackColor];
	labledatevalue.backgroundColor = [UIColor clearColor];
	[viewheader addSubview:labledatevalue];
	
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


#pragma mark IBaction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)ClickSelectstatus:(id)sender
{
	//排序分
	//金额  从小到大   从大到小
	//数量  从小到大   从大到小
	//远近  从远到近   从近到远
	//激活(状态)  已激活  未激活
	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnCreateQRCodeListSelectItem1];
	if([FCactivitestatusid isEqualToString:@"all"])
	{
		FCactivitestatusid= @"activitied";
		[buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
		[buttonitem1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];

	}
	else if([FCactivitestatusid isEqualToString:@"activitied"])
	{
		FCactivitestatusid= @"notactivity";
		[buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
		[buttonitem1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
	}
	else
	{
		FCactivitestatusid= @"all";
		[buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
		[buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
	}
	
	[self getcreateqrcodelist:@"1" Pagesize:@"10"];
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
	NSString *strtiem = [dictemp objectForKey:@"rebatecode"];
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, widthnow*3, 20)];
	labeltime.text = strtiem;;
	labeltime.textColor = [UIColor blackColor];
	labeltime.font = FONTN(15.0f);
	labeltime.textAlignment = NSTextAlignmentLeft;
	[cell.contentView addSubview:labeltime];
	
	UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-widthnow-10, 10, widthnow, 20)];
	lablemoneyvalue.text = [dictemp objectForKey:@"activitystatus"];
	lablemoneyvalue.font = FONTN(15.0f);
	lablemoneyvalue.textColor = [UIColor blackColor];
	lablemoneyvalue.textAlignment = NSTextAlignmentRight;
	lablemoneyvalue.backgroundColor = [UIColor clearColor];
	[cell.contentView addSubview:lablemoneyvalue];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

#pragma mark 接口
//获取列表
-(void)getcreateqrcodelist:(NSString *)page Pagesize:(NSString *)pagesize
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"rebateqrcodegenerateid"] = self.FCcreateid;
	params[@"page"] = page;
	params[@"pagesize"] = pagesize;
	params[@"activitystatusid"] = FCactivitestatusid;
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQCreateQRCodeListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			FCrebateinfo = [[dic objectForKey:@"data"] objectForKey:@"rebateqrcodegenerateinfo"];
			FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"qrcodelist"];
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
