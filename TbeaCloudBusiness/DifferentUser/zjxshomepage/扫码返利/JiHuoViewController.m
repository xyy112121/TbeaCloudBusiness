//
//  JiHuoViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/25.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "JiHuoViewController.h"

@interface JiHuoViewController ()

@end

@implementation JiHuoViewController

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
	self.title = @"已激活";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	FCorderid = @"";
	FCorderitem = @"";
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight-40)];
	tableview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tableview];
	[self addtabviewheader];
	[self setExtraCellLineHidden:tableview];
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getjihuolist:@"1" Pagesize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getjihuolist:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
	[self getjihuolist:@"1" Pagesize:@"10"];
}

-(void)addtabviewheader
{
	UIView *tabviewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
	tabviewheader.backgroundColor = [UIColor clearColor];
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
	
	//编码
	UIButton *buttonitemall = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonitemall.frame =CGRectMake(15, 0, nowwidth-5, 40);
	buttonitemall.backgroundColor = [UIColor clearColor];
	[buttonitemall setTitle:@"编码" forState:UIControlStateNormal];
	buttonitemall.titleLabel.font = FONTB(14.0f);
	buttonitemall.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	[buttonitemall setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
	[viewselectitem addSubview:buttonitemall];
	
	//扫描时间
	ButtonItemLayoutView *buttonitemtime = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+nowwidth*2, 0, nowwidth, 40)];
	[buttonitemtime.button addTarget:self action:@selector(ClickSelecttime:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemtime.tag = EnJiHuoPageSelectButton2;
	[buttonitemtime updatebuttonitem:EnButtonTextCenter TextStr:@"扫描时间" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
	[viewselectitem addSubview:buttonitemtime];
	
	//用户
	UIButton *buttonitemuser = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonitemuser.frame =CGRectMake(ScreenWidth-nowwidth-15, 0, nowwidth-5, 40);
	buttonitemuser.backgroundColor = [UIColor clearColor];
	[buttonitemuser setTitle:@"用户" forState:UIControlStateNormal];
	buttonitemuser.titleLabel.font = FONTB(14.0f);
	buttonitemuser.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
	[buttonitemuser setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
	[viewselectitem addSubview:buttonitemuser];
	
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

-(void)ClickSelecttime:(id)sender
{
	//排序分
	//金额  从小到大   从大到小
	//数量  从小到大   从大到小
	//远近  从远到近   从近到远
	//激活  已激活  未激活
	FCorderitem = @"time";
	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnJiHuoPageSelectButton2];
	if([FCorderid isEqualToString:@"desc"])
	{
		FCorderid= @"asc";
		[buttonitem1 updatelabstr:@"从小到大"];
		[buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
		[buttonitem1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
	}
	else
	{
		FCorderid= @"desc";
		[buttonitem1 updatelabstr:@"从大到小"];
		[buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
		[buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
	}
	
	[self getjihuolist:@"1" Pagesize:@"10"];
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
	float widthnow = (SCREEN_WIDTH-20)/4;
	UILabel *labelcode = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, widthnow*2, 30)];
	labelcode.text = [dictemp objectForKey:@"rebatecode"];
	labelcode.textColor = [UIColor blackColor];
	labelcode.font = FONTN(14.0f);
	labelcode.textAlignment = NSTextAlignmentCenter;
	[cell.contentView addSubview:labelcode];
	
	NSString *strtiem = [NSString stringWithFormat:@"%@\n%@",[dictemp objectForKey:@"activityday"],[dictemp objectForKey:@"activitytime"]];;
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(10+widthnow*2, 6, widthnow, 38)];
	labeltime.text = strtiem;
	labeltime.numberOfLines = 2;
	labeltime.textColor = [UIColor blackColor];
	labeltime.font = FONTN(13.0f);
	labeltime.textAlignment = NSTextAlignmentCenter;
	[cell.contentView addSubview:labeltime];
	
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-widthnow-15, 6, widthnow-5, 38)];
	labelname.text = [dictemp objectForKey:@"actuvityuser"];
	labelname.textColor = [UIColor blackColor];
	labelname.font = FONTN(14.0f);
	labelname.textAlignment = NSTextAlignmentRight;
	[cell.contentView addSubview:labelname];
	
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
	ScanCodeDetailViewController *scancode = [[ScanCodeDetailViewController alloc] init];
	scancode.FCqrcodeactivityid = [dictemp objectForKey:@"id"];
	[self.navigationController pushViewController:scancode animated:YES];
	
	
}

#pragma mark 接口
//获取激活列表
-(void)getjihuolist:(NSString *)page Pagesize:(NSString *)pagesize
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"qrcodegenerateid"] = self.FCqrcodeid;
	params[@"orderitem"] = FCorderitem;
	params[@"order"] = FCorderid;
	params[@"pagesize"] = pagesize;
	params[@"page"] = page;
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQCreateQRCodeHistoryJiHuoList ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"rebateqrcodeactivitylist"];
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
