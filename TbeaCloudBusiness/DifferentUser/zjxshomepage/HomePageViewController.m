//
//  HomePageViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "HomePageViewController.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	
	
    // Do any additional setup after loading the view.
}

-(void)loginview
{
	LoginPageViewController *login = [[LoginPageViewController alloc] init];
	login.delegate1 = self;
	UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:login];
	[self.navigationController presentViewController:nctl animated:NO completion:nil];
}

-(void)initview
{
    [tableview removeFromSuperview];
	self.navigationItem.title = @"";
	self.view.backgroundColor = [UIColor whiteColor];
	[[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];

    [self getupdateversion];
	[self gethppage];//获取首页数据
    [self addnavigation:nil];
    [self getURLPrefix];//获取url前缀
    
}

-(void)addnavigation:(id)sender
{
    [[self.navigationController.navigationBar viewWithTag:EnHpNavigationViewTag] removeFromSuperview];
    HpNavigateView *hpna = [[HpNavigateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) FromFlag:@"1"];
    hpna.delegate1 = self;
    hpna.tag = EnHpNavigationViewTag;
    [self.navigationController.navigationBar addSubview:hpna];
}



-(void)viewWillAppear:(BOOL)animated
{
    if(![AddInterface judgeislogin])
        [self loginview];
    else
    {
        [self initview];
        if(![app.userinfo.userpermission isEqualToString:@"identified"]&&([app.userinfo.usertype isEqualToString:@"seller"]||[app.userinfo.usertype isEqualToString:@"distributor"]))
        {
            [self addAlertView];
        }
        else
        {
            [alert removeFromSuperview];
        }
    }
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[self.navigationController.navigationBar viewWithTag:EnHpNavigationViewTag] removeFromSuperview];
    [self addnavigation:nil];
	self.navigationController.navigationBar.translucent = NO;
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
	[self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[self.navigationController.navigationBar viewWithTag:EnHpNavigationViewTag] removeFromSuperview];
}


#pragma mark 警告弹出框及代理
-(void)addAlertView
{
	self.view.backgroundColor =[UIColor whiteColor];
	alert =[[AlertViewExtension alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, SCREEN_HEIGHT)];
	alert.delegate=self;
	[alert setbackviewframeWidth:300 Andheight:160];
	[alert settipeTitleStr:@"为建设诚信商业平台,商家须补全资料并进行实名认证后才可使用系统功能!" Andfont:14.0f Title:@"功能受限" BtStr:@"前往认证"];
	[app.window addSubview:alert];
}

-(void)clickBtnSelector:(UIButton *)btn
{
	if (btn.tag == 1920) {
        [alert removeFromSuperview];
        if([app.userinfo.userpermission isEqualToString:@"notidentify"])
        {
            UserInfoMakeUpViewController *userinfo = [[UserInfoMakeUpViewController alloc] init];
            userinfo.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:userinfo animated:YES];
        }
        else
        {
            UserInfoMakeUpingViewController *userinfo = [[UserInfoMakeUpingViewController alloc] init];
            userinfo.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:userinfo animated:YES];
        }
	}
}

#pragma mark ActionDelegate

-(void)DGclickMessage:(id)sender
{
    MyMessageViewController *mymessage = [[MyMessageViewController alloc] init];
    mymessage.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mymessage animated:YES];
}

-(void)DGClickGoToSearch:(id)sender
{
    SearchPageViewController *searchpage = [[SearchPageViewController alloc] init];
    UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:searchpage];
    searchpage.FCSearchFromType = @"all";
    [self.navigationController presentViewController:nctl animated:YES completion:nil];
}

-(void)DGClickSearchResultTextField:(NSString *)str
{
    SearchResultViewController *resultview = [[SearchResultViewController alloc] init];
    [self.navigationController pushViewController:resultview animated:YES];
}

-(void)DGLoginSuccess:(id)sender
{
	[self initview];
}

-(void)DGCLickScanCode:(id)sender
{
    
//    NSURL*URL = [NSURL URLWithString:@"ccwbapp://news/123123123123123"];//上面的配置就是在这里用，提供一个标识；
//    [[UIApplication sharedApplication] openURL:URL];
    ScanQRCodeARViewController *scancode = [[ScanQRCodeARViewController alloc] init];
    scancode.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scancode animated:YES];
}

-(void)DGClickFunctionGotoView:(NSDictionary *)sender
{
	ScanRebatehpViewController *scanrebate; //扫码返得
	WaterPersonMangerViewController *watermanger;//水电工管理
	WaterMettingViewController *watermetting;//水电工会议
	MallStoreHpViewController *mallstore;//商城系统
    ComWaterMettingHpViewController *comwater;
    DistributorRebateHpViewController *distributorrebate;
    ComWaterPersonMangerZJXViewController *comwaterperson;
    JXIndexViewController *tebianfenxiao;
    TbeaDetectUserHPViewController *tbelec;
    DistributorMangerViewController *distributormanger;
    TbeaHPViewController *tbhp;
	NSString *strmoduleid = [sender objectForKey:@"moduleid"];
	if([strmoduleid isEqualToString:@"shuidiangongguanli"]) //水电工管理
	{
		watermanger = [[WaterPersonMangerViewController alloc] init];
		watermanger.hidesBottomBarWhenPushed = YES;
		[self.navigationController pushViewController:watermanger animated:YES];
	}
    else if([strmoduleid isEqualToString:@"distributor_shuidiangongguanli"]) //分销商水电工管理
    {
        watermanger = [[WaterPersonMangerViewController alloc] init];
        watermanger.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:watermanger animated:YES];
    }
	else if([strmoduleid isEqualToString:@"shuidiangonghuiyi"]) //水电工会议
	{
		watermetting = [[WaterMettingViewController alloc] init];
		watermetting.hidesBottomBarWhenPushed = YES;
		[self.navigationController pushViewController:watermetting animated:YES];
	}
	else if([strmoduleid isEqualToString:@"shaomafanli"]) //总经销商扫码返利
	{
		scanrebate = [[ScanRebatehpViewController alloc] init];
		scanrebate.hidesBottomBarWhenPushed = YES;
		[self.navigationController pushViewController:scanrebate animated:YES];
	}
    else if([strmoduleid isEqualToString:@"distributor_shaomafanli"]) //分销商的扫码返利
    {
        distributorrebate = [[DistributorRebateHpViewController alloc] init];
        distributorrebate.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:distributorrebate animated:YES];
    }
    else if([strmoduleid isEqualToString:@"tebianweishi"]) //总经销商 特变卫士
    {
        tbhp = [[TbeaHPViewController alloc] init];
        tbhp.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tbhp animated:YES];
    }
    else if([strmoduleid isEqualToString:@"electricalcheckor_tebianweishi"]) //检测人员特变卫士
    {
        tbelec = [[TbeaDetectUserHPViewController alloc] init];
        tbelec.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tbelec animated:YES];
    }
	else if([strmoduleid isEqualToString:@"shangchengxitong"]) //商城系统
	{
		mallstore = [[MallStoreHpViewController alloc] init];
		mallstore.hidesBottomBarWhenPushed = YES;
		[self.navigationController pushViewController:mallstore animated:YES];
	}
    else if([strmoduleid isEqualToString:@"marketer_shuidiangonghuiyi"]) //公司人员水电工会议
    {
        comwater = [[ComWaterMettingHpViewController alloc] init];
        comwater.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:comwater animated:YES];
    }
    else if([strmoduleid isEqualToString:@"marketer_shuidiangongguanli"]) //公司人员水电工管理
    {
        comwaterperson = [[ComWaterPersonMangerZJXViewController alloc] init];
        comwaterperson.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:comwaterperson animated:YES];
    }
    else if([strmoduleid isEqualToString:@"tbea"]) //点击特变电工
    {
        self.tabBarController.selectedIndex = 1;
    }
    else if([strmoduleid isEqualToString:@"qitayingyong"]) //其它就用
    {
        self.tabBarController.selectedIndex = 2;
    }
    else if([strmoduleid isEqualToString:@"tebianfenxiao"]) //分销系统
    {
        tebianfenxiao = [[JXIndexViewController alloc] init];
        tebianfenxiao.hidesBottomBarWhenPushed = YES;
         [self.navigationController pushViewController:tebianfenxiao animated:YES];
    }
    else if([strmoduleid isEqualToString:@"fenxiaoshang"])
    {
        distributormanger = [[DistributorMangerViewController alloc] init];
        distributormanger.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:distributormanger animated:YES];
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
	if(([arraymessage count]>0)&& indexPath.row == 0)
		return 60;
	return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if([arraymessage count]>0)
		return [arraystaticsitem count]+1;
	else
		return [arraystaticsitem count];
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
	
	if(([arraymessage count]>0)&&indexPath.row==0)
	{
		TbeaHpCellView *hpcell = [[TbeaHpCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60) ArrayFrom:arraymessage];
		[cell.contentView addSubview:hpcell];
	}
	else
	{
		NSDictionary *dictemp;
		if([arraymessage count]>0)
			dictemp = [arraystaticsitem objectAtIndex:indexPath.row-1];
		else
			dictemp = [arraystaticsitem objectAtIndex:indexPath.row];
        
		HpFunctionCellView *hp = [[HpFunctionCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110) celltype:EnHpFunctionCellType1 Dic:dictemp IndexPath:indexPath];
        hp.delegate1 = self;
		[cell.contentView addSubview:hp];
	}
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


#pragma mark 接口

//获取url前缀
-(void)getURLPrefix
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"terminaltype"] = @"ios";
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQGetURLHeaderFrontCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            app.GBURLPreFix = [[dic objectForKey:@"data"] objectForKey:@"url"];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}

-(void)getupdateversion
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"terminaltype"] = @"ios";
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQUpdateNewVersionCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            NSDictionary *versioninfo = [[dic objectForKey:@"data"] objectForKey:@"versioninfo"];
            NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
            NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
            NSString *serversion = [NSString stringWithFormat:@"%@",[versioninfo objectForKey:@"versionname"]];
            NSString *verswitch = [NSString stringWithFormat:@"%@",[versioninfo objectForKey:@"tipswitch"]];
            NSString *jumpurl = [NSString stringWithFormat:@"%@",[versioninfo objectForKey:@"jumpurl"]];
            NSString *mustupgrade = [versioninfo objectForKey:@"mustupgrade"];
            if([verswitch isEqualToString:@"off"])
            {
                return ;
            }
            else if([serversion isEqualToString:@"0.0"])
            {
                return ;
            }
            else if([jumpurl length]==0)
            {
                return ;
            }
            else if([mustupgrade isEqualToString:@"YES"])
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"有新版本,你确定要更新吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"现在更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    NSString *postUrl = jumpurl;
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:postUrl] options:@{} completionHandler:nil];
                    //     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:postUrl]];
                    DLog(@"posturl===%@",postUrl);
                    
                }];
                
                // Add the actions.
                [alertController addAction:otherAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else if(![serversion isEqualToString:currentVersion])
            {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"有新版本,你确定要更新吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"稍后再更新" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    
                }];
                
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"现在更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    NSString *postUrl = jumpurl;
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:postUrl] options:@{} completionHandler:nil];
                    DLog(@"posturl===%@",postUrl);
                    
                }];
                
                // Add the actions.
                [alertController addAction:cancelAction];
                [alertController addAction:otherAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}

-(void)gethppage
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQHpPageCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			arrayfunction = [[dic objectForKey:@"data"] objectForKey:@"functionmodulelist"];
			arraystaticsitem = [[dic objectForKey:@"data"] objectForKey:@"staticsitemlist"];
			arraymessage = [[dic objectForKey:@"data"] objectForKey:@"systemmessagelist"];
			//添加顶部应用菜单
			if([arrayfunction count]>0)
			{
                float nowheight = 170;
                if([arrayfunction count]>0&&[arrayfunction count]<5)
                    nowheight = 90;
				AppFuntionView *appfuntionview = [[AppFuntionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, nowheight) ArrayFunction:arrayfunction];
				appfuntionview.delegate1 = self;
				tableview.tableHeaderView=appfuntionview;
			}
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
