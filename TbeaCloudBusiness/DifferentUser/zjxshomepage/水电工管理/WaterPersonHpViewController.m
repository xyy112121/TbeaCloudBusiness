//
//  WaterPersonHpViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/31.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "WaterPersonHpViewController.h"

@interface WaterPersonHpViewController ()

@end

@implementation WaterPersonHpViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	[self initview];
	
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 22, 40, 40)];
	[button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
	[button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:button];
	

    
	// Do any additional setup after loading the view.
}

#pragma mark 页面布局

-(void)initview
{
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
	tableview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tableview];
	
	[self setExtraCellLineHidden:tableview];
    [self getwateruserhome];
}

-(void)addtabviewheader
{
	WaterPersonHpHeaderView *waterheader = [[WaterPersonHpHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240) DicFrom:FCdicdata];
	waterheader.delegate1 = self;
	tableview.tableHeaderView = waterheader;
}

-(void)viewWillAppear:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark ActionDelegate
-(void)DGClickWaterFunctionHp:(int)tagnow
{
	WaterScanRebateViewController *waterscan;
	CheckInHistoryViewController *checkinhistory;
    WaterLoginDetailViewController *logindetail;
	switch (tagnow)
	{
		case EnWaterHpFunctionRebateBt:
			 waterscan = [[WaterScanRebateViewController alloc] init];
                waterscan.FCelectricianid = [[FCdicdata objectForKey:@"electricianbaseinfo"] objectForKey:@"userid"];
			 [self.navigationController pushViewController:waterscan animated:YES];
			 break;
		case EnWaterHpFunctionLoginBt:
			 logindetail = [[WaterLoginDetailViewController alloc] init];
			 [self.navigationController pushViewController:logindetail animated:YES];
			 break;
        case EnWaterHpFunctionMettingBt:
            checkinhistory = [[CheckInHistoryViewController alloc] init];
            checkinhistory.FCelectricianid = [[FCdicdata objectForKey:@"electricianbaseinfo"] objectForKey:@"userid"];
            [self.navigationController pushViewController:checkinhistory animated:YES];
            break;
	}
}

-(void)DGCLickWaterPersonHeader:(id)sender
{
	WaterPersonInfoViewController *personinfo = [[WaterPersonInfoViewController alloc] init];
    personinfo.FCelectricianid = [[FCdicdata objectForKey:@"electricianbaseinfo"] objectForKey:@"userid"];
	[self.navigationController pushViewController:personinfo animated:YES];
}

#pragma mark IBaction
-(void)gotopersonmanger:(id)sender
{
    
}

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
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
	return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	return 6;
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
	
	switch (indexPath.row)
	{
		case 0:
			functiontype = EnWaterPersonScanRebate;
			break;
		case 1:
			functiontype = EnWaterPersonMetting;
			break;
		case 2:
			functiontype = EnWaterPersonService;
			break;
        case 3:
            functiontype = EnWaterPersonOrder;
            break;
		case 4:
			functiontype = EnWaterPersonLogin;
			break;
		case 5:
			functiontype = EnWaterPersonSocialinfo;
			break;

	}
	
	WaterPersonCellHpView *scancell = [[WaterPersonCellHpView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 59) DicFrom:FCdicdata Type:functiontype];
	scancell.delegate1 = self;
	[cell.contentView addSubview:scancell];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}



#pragma mark 接口
-(void)getwateruserhome
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"electricianid"]= self.FCelectricianid;
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQZJXWaterEleMangerPersonHpCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCdicdata = [dic objectForKey:@"data"];
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
