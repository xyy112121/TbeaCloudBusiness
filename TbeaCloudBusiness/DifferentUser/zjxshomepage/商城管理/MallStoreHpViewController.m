//
//  MallStoreHpViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/7/7.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MallStoreHpViewController.h"

@interface MallStoreHpViewController ()

@end

@implementation MallStoreHpViewController

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
	
	UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
	UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
	[buttonright setImage:LOADIMAGE(@"morepointwhite", @"png") forState:UIControlStateNormal];
	[buttonright addTarget:self action: @selector(Clickmorefunction:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewright addSubview:buttonright];
	buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
	
	// Do any additional setup after loading the view.
}

-(void)initview
{
	self.title = @"店铺名称";
	self.view.backgroundColor = COLORNOW(235, 235, 235);
	[[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	

	
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
    FCarrayheigt = [[NSMutableArray alloc] init];
	
	
	[self getstorehppage];//获取首页数据
	
	
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
-(void)DGClickFunctionGotoView:(NSDictionary *)sender
{
    MallStoreSettingViewController *mallsetting; //店铺设置
    MallStoreGoodsMangerViewController *goodsmanger;//商品管理
    MallStoreDynamicListViewController *malldynamic;//店铺动态
    MallStoreGoodsSalesNumberViewController *goodssales;//商品销量
    MallStoreSalesAccountListViewController *salesaccount;//销售流水
    WkWebViewViewController *webview;
    NSString *strmoduleid = [sender objectForKey:@"moduleid"];
    if([strmoduleid isEqualToString:@"dianpushezhi"]) //店铺设置
    {
        mallsetting = [[MallStoreSettingViewController alloc] init];
        [self.navigationController pushViewController:mallsetting animated:YES];
    }
    else if([strmoduleid isEqualToString:@"shangpinguanli"])//商品管理
    {
        goodsmanger = [[MallStoreGoodsMangerViewController alloc] init];
        [self.navigationController pushViewController:goodsmanger animated:YES];
    }
    else if([strmoduleid isEqualToString:@"dianpudongtai"]) //店铺动态
    {
        malldynamic = [[MallStoreDynamicListViewController alloc] init];
        [self.navigationController pushViewController:malldynamic animated:YES];
    }
    else if([strmoduleid isEqualToString:@"shangpinxiaoliang"]) //商品销量
    {
        goodssales = [[MallStoreGoodsSalesNumberViewController alloc] init];
        [self.navigationController pushViewController:goodssales animated:YES];
    }
    else if([strmoduleid isEqualToString:@"xiaoshouliushui"]) //销售流水
    {
        salesaccount = [[MallStoreSalesAccountListViewController alloc] init];
        [self.navigationController pushViewController:salesaccount animated:YES];
    }
    else if([strmoduleid isEqualToString:@"dingdanguanli"]) //订单管理
    {
        webview = [[WkWebViewViewController alloc] init];
        webview.FCstrurl = [NSString stringWithFormat:@"%@%@?userid=%@",Interfacehtmlurlheader,HtmlUrlStoreOrderMangerInfo,app.userinfo.userid];
        webview.FCstrtitle = @"订单管理";
        [self.navigationController pushViewController:webview animated:YES];
    }
}

-(void)DGClickMallStoreFunctionGotoView:(NSDictionary *)sender
{
	MallStoreSettingViewController *mallsetting; //店铺设置
    MallStoreGoodsMangerViewController *goodsmanger;//商品管理
    MallStoreDynamicListViewController *malldynamic;//店铺动态
    MallStoreGoodsSalesNumberViewController *goodssales;//商品销量
    WkWebViewViewController *webview;
	NSString *strmoduleid = [sender objectForKey:@"moduleid"];
	if([strmoduleid isEqualToString:@"dianpushezhi"]) //店铺设置
	{
		mallsetting = [[MallStoreSettingViewController alloc] init];
		[self.navigationController pushViewController:mallsetting animated:YES];
	}
	else if([strmoduleid isEqualToString:@"shangpinguanli"])//商品管理
    {
        goodsmanger = [[MallStoreGoodsMangerViewController alloc] init];
        [self.navigationController pushViewController:goodsmanger animated:YES];
    }
	else if([strmoduleid isEqualToString:@"dianpudongtai"]) //店铺动态
    {
        malldynamic = [[MallStoreDynamicListViewController alloc] init];
        [self.navigationController pushViewController:malldynamic animated:YES];
    }
    else if([strmoduleid isEqualToString:@"shangpinxiaoliang"]) //商品销量
    {
        goodssales = [[MallStoreGoodsSalesNumberViewController alloc] init];
        [self.navigationController pushViewController:goodssales animated:YES];
    }
    else if([strmoduleid isEqualToString:@"dingdanguanli"]) //订单管理
    {
        webview = [[WkWebViewViewController alloc] init];
        webview.FCstrurl = [NSString stringWithFormat:@"%@%@?userid=%@",Interfacehtmlurlheader,HtmlUrlStoreOrderMangerInfo,app.userinfo.userid];
        webview.FCstrtitle = @"订单管理";
        [self.navigationController pushViewController:webview animated:YES];
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
	return [[FCarrayheigt objectAtIndex:indexPath.row] floatValue];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [FCarrayheigt count];
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

	cell.textLabel.text = @"正在建设中";
	
	NSDictionary *dictemp;
    CGRect frame;
    dictemp = [FCarraystaticsitem objectAtIndex:indexPath.row];
    if([[dictemp objectForKey:@"style"] isEqualToString:@"style04"])
        frame = CGRectMake(0, 0, SCREEN_WIDTH, 180);
    else
        frame = CGRectMake(0, 0, SCREEN_WIDTH, 110);
    HpFunctionCellView *hp = [[HpFunctionCellView alloc] initWithFrame:frame celltype:EnHpFunctionCellType1 Dic:dictemp IndexPath:indexPath];
    hp.delegate1 = self;
	[cell.contentView addSubview:hp];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

#pragma mark IBAction

-(void)Clickmorefunction:(id)sender
{
	
}

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)celltablearrayheight
{
    for(int i=0;i< [FCarraystaticsitem count];i++)
    {
        NSDictionary *dictemp = [FCarraystaticsitem objectAtIndex:i];
        if([[dictemp objectForKey:@"style"] isEqualToString:@"style04"])
            [FCarrayheigt addObject:[NSString stringWithFormat:@"%f",180.0f]];
        else
            [FCarrayheigt addObject:[NSString stringWithFormat:@"%f",110.0f]];
    }
}


#pragma mark 接口
-(void)getstorehppage
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQStoreHpPageInterfaceCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
            [FCarrayheigt removeAllObjects];
			FCarrayfunction = [[dic objectForKey:@"data"] objectForKey:@"functionmodulelist"];
			FCarraystaticsitem = [[dic objectForKey:@"data"] objectForKey:@"staticsitemlist"];
            [self celltablearrayheight];
            MallStoreFuntionView *appfuntionview = [[MallStoreFuntionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) ArrayFunction:FCarrayfunction];
            appfuntionview.delegate1 = self;
            tableview.tableHeaderView=appfuntionview;
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
