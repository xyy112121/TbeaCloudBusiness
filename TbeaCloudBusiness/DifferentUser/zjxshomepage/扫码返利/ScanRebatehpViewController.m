//
//  ScanRebatehpViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/21.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ScanRebatehpViewController.h"


@interface ScanRebatehpViewController ()

@end

@implementation ScanRebatehpViewController

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
	
	UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
	UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
	buttonright.titleLabel.font = FONTN(16.0f);
	[buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[buttonright setTitle:@"生成" forState:UIControlStateNormal];
	[buttonright addTarget:self action: @selector(createscanrebatecode:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewright addSubview:buttonright];
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
	
    // Do any additional setup after loading the view.
}

#pragma mark 页面布局

-(void)initview
{
	self.title = @"扫码返利";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
	tableview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
	[self getscanrebatelist];
	
}

-(void)addtabviewheader
{
	UIView *tabviewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
	tabviewheader.backgroundColor = [UIColor clearColor];
	tableview.tableHeaderView = tabviewheader;
	[tabviewheader addSubview:[self searchbarview]];
	UIView *viewcash = [self cashdataview];
	[tabviewheader addSubview:viewcash];
	[tabviewheader addSubview:[self viewselectitem:CGRectMake(0, XYViewBottom(viewcash), SCREEN_WIDTH, 90)]];
}

-(UIView *)searchbarview
{
	UIView *viewsearch = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
	viewsearch.backgroundColor = COLORNOW(0, 170, 238);
	
	SearchTextFieldView *searchtext = [[SearchTextFieldView alloc] initWithFrame:CGRectMake(60, 10, SCREEN_WIDTH-120, 30) Pastr:@"扫码返利查询"];
	searchtext.delegate1 = self;
	[viewsearch addSubview:searchtext];
	
	return viewsearch;
	
	
}

//提现数据
-(UIView *)cashdataview
{
	UIView *viewcash = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 100)];
	viewcash.backgroundColor = COLORNOW(240, 240, 240);
	
	UIImageView *imageviewbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
	imageviewbg.backgroundColor = [UIColor whiteColor];
	[viewcash addSubview:imageviewbg];
	
	UIImageView *imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
	imageviewicon.image = LOADIMAGE(@"smallicon1", @"png");
	[viewcash addSubview:imageviewicon];
	
	UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageviewicon)+10, XYViewTop(imageviewicon), 100, 20)];
	lable.text = @"提现数据";
	lable.font = FONTN(15.0f);
	lable.textColor = [UIColor blackColor];
	lable.backgroundColor = [UIColor clearColor];
	[viewcash addSubview:lable];
	
	//已支付
	UILabel *lableispayname = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lable), XYViewBottom(lable)+10, 100, 20)];
	lableispayname.text = @"已支付";
	lableispayname.font = FONTN(14.0f);
	lableispayname.textColor = COLORNOW(117, 117, 117);
	lableispayname.backgroundColor = [UIColor clearColor];
	[viewcash addSubview:lableispayname];
	
	UILabel *lablemoneyflag1 = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lableispayname), XYViewBottom(lableispayname)+5, 10,10)];
	lablemoneyflag1.text = @"￥";
	lablemoneyflag1.font = FONTMEDIUM(11.0f);
	lablemoneyflag1.textColor = [UIColor blackColor];
	lablemoneyflag1.backgroundColor = [UIColor clearColor];
	[viewcash addSubview:lablemoneyflag1];
	
	UILabel *lableispayvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(lablemoneyflag1)+1, XYViewTop(lablemoneyflag1)-3, SCREEN_WIDTH/2-30, 20)];
	lableispayvalue.text = [NSString stringWithFormat:@"%@",[FCdictakemoney objectForKey:@"havepayed"]];
	lableispayvalue.font = FONTMEDIUM(18.0f);
	lableispayvalue.textColor = [UIColor blackColor];
	lableispayvalue.backgroundColor = [UIColor clearColor];
	[viewcash addSubview:lableispayvalue];
	
	
	
	//待支付
	UILabel *lablenopayname = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+20, XYViewTop(lableispayname), 100, 20)];
	lablenopayname.text = @"待支付";
	lablenopayname.font = FONTN(14.0f);
	lablenopayname.textColor = COLORNOW(117, 117, 117);
	lablenopayname.backgroundColor = [UIColor clearColor];
	[viewcash addSubview:lablenopayname];
	
	UILabel *lablemoneyflag2 = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablenopayname), XYViewBottom(lablenopayname)+5, 10,10)];
	lablemoneyflag2.text = @"￥";
	lablemoneyflag2.font = FONTMEDIUM(11.0f);
	lablemoneyflag2.textColor = [UIColor blackColor];
	lablemoneyflag2.backgroundColor = [UIColor clearColor];
	[viewcash addSubview:lablemoneyflag2];
	
	UILabel *lablenopayvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(lablemoneyflag2)+1, XYViewTop(lablemoneyflag2)-3, SCREEN_WIDTH/2-30, 20)];
	lablenopayvalue.text =  [NSString stringWithFormat:@"%@",[FCdictakemoney objectForKey:@"needpay"]];;
	lablenopayvalue.font = FONTMEDIUM(18.0f);
	lablenopayvalue.textColor = [UIColor blackColor];
	lablenopayvalue.backgroundColor = [UIColor clearColor];
	[viewcash addSubview:lablenopayvalue];
	
	
	
	//更多
	UIButton *buttonmore = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonmore.frame = CGRectMake(SCREEN_WIDTH-50, 0, 40, 40);
	buttonmore.backgroundColor = [UIColor clearColor];
	[buttonmore setImage:LOADIMAGE(@"morepoint", @"png") forState:UIControlStateNormal];
	[buttonmore addTarget:self action:@selector(gototixiandata:) forControlEvents:UIControlEventTouchUpInside];
	[viewcash addSubview:buttonmore];
	
	return viewcash;
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
	
	
	UIButton *buttonmonth = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonmonth.frame = CGRectMake(17, 10, 80, 30);
	buttonmonth.backgroundColor = [UIColor clearColor];
	[buttonmonth setTitle:@"提现排名" forState:UIControlStateNormal];
	buttonmonth.titleLabel.font = FONTB(18.0f);
	[buttonmonth setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[viewselectitem addSubview:buttonmonth];
	
	//更多
	UIButton *buttonmore = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonmore.frame = CGRectMake(SCREEN_WIDTH-50, XYViewTop(buttonmonth), 40, 30);
	buttonmore.backgroundColor = [UIColor clearColor];
	[buttonmore setImage:LOADIMAGE(@"morepoint", @"png") forState:UIControlStateNormal];
	[buttonmore addTarget:self action:@selector(gotosortmore:) forControlEvents:UIControlEventTouchUpInside];
	[viewselectitem addSubview:buttonmore];
	
	//全部
	UIButton *buttonitemleft = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonitemleft.frame = CGRectMake(XYViewL(buttonmonth)+5, XYViewBottom(line1)+5, 60, 30);
	buttonitemleft.backgroundColor = [UIColor clearColor];
	[buttonitemleft setTitle:@"水电工" forState:UIControlStateNormal];
	buttonitemleft.titleLabel.font = FONTB(14.0f);
	buttonitemleft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//	buttonitemleft.tag = EnScanRebateHpBtLeft;
//	[buttonitemleft addTarget:self action:@selector(ClickSelectUserType:) forControlEvents:UIControlEventTouchUpInside];
	[buttonitemleft setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
	[viewselectitem addSubview:buttonitemleft];
	
	//提现金额
	UIButton *buttonitemright = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonitemright.frame = CGRectMake(SCREEN_WIDTH-80, XYViewTop(buttonitemleft), 60, 30);
	buttonitemright.backgroundColor = [UIColor clearColor];
	[buttonitemright setTitle:@"金额" forState:UIControlStateNormal];
	buttonitemright.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
	buttonitemright.titleLabel.font = FONTB(14.0f);
	[buttonitemright setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
	[viewselectitem addSubview:buttonitemright];
	
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



#pragma mark IBaction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

//生成二维码
-(void)createscanrebatecode:(id)sender
{
	CreateQRCodeViewController *createqrcode = [[CreateQRCodeViewController alloc] init];
	[self.navigationController pushViewController:createqrcode animated:YES];
}

//提现数据
-(void)gototixiandata:(id)sender
{
	TiXianDataHpViewController *tixiandata = [[TiXianDataHpViewController alloc] init];
	[self.navigationController pushViewController:tixiandata animated:YES];
}

//排行更多
-(void)gotosortmore:(id)sender
{
	SortMoreViewController *sortmore = [[SortMoreViewController alloc] init];
	[self.navigationController pushViewController:sortmore animated:YES];
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
	ScanRebatehpCellview *scancell = [[ScanRebatehpCellview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 59) DicFrom:dictemp CellIndex:indexPath];
	[cell.contentView addSubview:scancell];
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
	TiXianHistoryViewController *tixiandata = [[TiXianHistoryViewController alloc] init];
//	tixiandata.enfromusertype = scanrebateusertype;
    tixiandata.FCpersontype = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"personorcompany"]];
    tixiandata.FCpayeeid = [dictemp objectForKey:@"electricianid"];
	[self.navigationController pushViewController:tixiandata animated:YES];
}


#pragma mark 接口
-(void)getscanrebatelist
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQZJXScanRebactListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			FCdictakemoney = [[dic objectForKey:@"data"] objectForKey:@"takemoneytotleinfo"];
			FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"takemoneyrankinglist"];
			[self addtabviewheader];
			
			tableview.delegate = self;
			tableview.dataSource = self;
			[tableview reloadData];
			
		}
		else
		{
			[MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		}
	} Failur:^(NSString *strmsg) {
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
