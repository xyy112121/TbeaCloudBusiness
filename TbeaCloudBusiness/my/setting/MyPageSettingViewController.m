//
//  MyPageSettingViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/16.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyPageSettingViewController.h"

@interface MyPageSettingViewController ()

@end

@implementation MyPageSettingViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	
	[self initview];
	
	[self.navigationController setNavigationBarHidden:NO animated:YES];
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
	self.title = @"设置";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];

	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
    
    UIButton *buttonlogout = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonlogout.frame = CGRectMake(20, SCREEN_HEIGHT-64-80, SCREEN_WIDTH-40, 40);
    buttonlogout.backgroundColor = COLORNOW(238, 89, 83);
    [buttonlogout setTitle:@"退出登录" forState:UIControlStateNormal];
    buttonlogout.layer.cornerRadius = 3.0f;
    buttonlogout.clipsToBounds = YES;
    [buttonlogout addTarget:self action:@selector(clicklogout:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonlogout];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getmysettinginfo];
	self.navigationController.navigationBar.translucent = NO;
	[self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
	[self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
	UIColor* color = [UIColor whiteColor];
	NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes= dict;
}

#pragma mark IBAction
-(void)clicklogout:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你确定要退出登录吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSFileManager *filemanger = [NSFileManager defaultManager];
        [filemanger removeItemAtPath:UserMessage error:nil];
        app.userinfo.userid = @"";
        app.userinfo.userstate = @"0";
        app.userinfo.usertel = @"";
        app.userinfo.username = @"";
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
	return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 5;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//	return 0.001;
//	
//}
//
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//	return nil;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	static NSString *reuseIdetify = @"cell";
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	for(UIView *view in cell.contentView.subviews)
	{
		[view removeFromSuperview];
	}
	
	cell.backgroundColor = [UIColor whiteColor];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-70, 20)];
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textColor = COLORNOW(117, 117, 117);
	labelname.font = FONTN(15.0f);
	[cell.contentView addSubview:labelname];
	
	UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150, 10, 120, 20)];
	labelvalue.backgroundColor = [UIColor clearColor];
	labelvalue.textColor = COLORNOW(117, 117, 117);
	labelvalue.font = FONTN(15.0f);
	labelvalue.textAlignment = NSTextAlignmentRight;
	
	switch (indexPath.row)
	{
		case 0:
			labelname.text = @"手机号码";
			
			labelvalue.text = FCtel;
			[cell.contentView addSubview:labelvalue];
			break;
		case 1:
			labelname.text = @"密码设置";
			break;
		case 2:
			labelname.text = @"收货地址";
			labelvalue.text = FCreceivenum;
			labelvalue.font = FONTMEDIUM(15.0f);
			labelvalue.textColor = [UIColor blackColor];
			[cell.contentView addSubview:labelvalue];
			break;
		case 3:
			labelname.text = @"背景图";
			break;
		case 4:
			labelname.text = @"通用";
			break;
	}
	
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	MyPageModifyPhoneViewController *modifyphone;
	SettingModifyPwdViewController *modifypwd;
	SettingAddressViewController *address;
	SettingCustomViewController *settingcustom;
    SettingBGImageViewController *bgimage;
	switch (indexPath.row)
	{
		case 0:
			modifyphone = [[MyPageModifyPhoneViewController alloc] init];
			[self.navigationController pushViewController:modifyphone animated:YES];
			break;
		case 1:
			modifypwd = [[SettingModifyPwdViewController alloc] init];
			[self.navigationController pushViewController:modifypwd animated:YES];
			break;
		case 2:
			address = [[SettingAddressViewController alloc] init];
			[self.navigationController pushViewController:address animated:YES];
			break;
        case 3:
            bgimage = [[SettingBGImageViewController alloc] init];
            [self.navigationController pushViewController:bgimage animated:YES];
            break;
		case 4:
			settingcustom = [[SettingCustomViewController alloc] init];
			[self.navigationController pushViewController:settingcustom animated:YES];
			break;
	}
	
}


#pragma mark 接口
-(void)getmysettinginfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQUserCenterSettingHpCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCtel = [[[dic objectForKey:@"data"] objectForKey:@"baseinfo"] objectForKey:@"mobilenumber"];
            FCreceivenum = [NSString stringWithFormat:@"%@",[[[dic objectForKey:@"data"] objectForKey:@"baseinfo"] objectForKey:@"recvaddrnumber"]];
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
