//
//  ScanCodeDetailViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/25.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ScanCodeDetailViewController.h"

@interface ScanCodeDetailViewController ()

@end

@implementation ScanCodeDetailViewController

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
	self.title = @"扫码详情";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
	tableview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tableview];
	
	[self setExtraCellLineHidden:tableview];
	[self getjihuodetail];
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
	return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(section == 0)
		return 5;
	return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if(section == 0)
		return 1;
	return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
	viewheader.backgroundColor = COLORNOW(235, 235, 235);

	return viewheader;
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
	
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, 20)];
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textColor = COLORNOW(117, 117, 117);
	labelname.font = FONTN(15.0f);
	[cell.contentView addSubview:labelname];
	
	UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(labelname)+5, 10, SCREEN_WIDTH-105, 20)];
	labelvalue.backgroundColor = [UIColor clearColor];
	labelvalue.textColor = [UIColor blackColor];
	labelvalue.font = FONTN(15.0f);

	
	UIImageView *imageheader;
	UIImageView *imageicon;
	UILabel *labelusername;
	CGSize sizeuser;
	NSDictionary *dicrebateinfo = [FCdicscancodedetail objectForKey:@"rebateqrcodeinfo"];
	NSDictionary *dicactivityinfo = [FCdicscancodedetail objectForKey:@"rebateqrcodeactivityinfo"];
	if(indexPath.section == 0)
	{
		switch (indexPath.row)
		{
			case 0:
				labelname.text = @"返利编码";
				labelvalue.text = [dicrebateinfo objectForKey:@"rebatecode"];
				[cell.contentView addSubview:labelvalue];
				break;
			case 1:
				labelname.text = @"生成日期";
				
				labelvalue.text = [dicrebateinfo objectForKey:@"generatetime"];
				[cell.contentView addSubview:labelvalue];
				break;
            case 2:
                labelname.text = @"产品名称";
                
                labelvalue.text = [dicrebateinfo objectForKey:@"commoditycategory"];
                [cell.contentView addSubview:labelvalue];
                break;
			case 3:
				labelname.text = @"规格型号";
				
				labelvalue.text = [dicrebateinfo objectForKey:@"commodityspecificationandmodel"];
				[cell.contentView addSubview:labelvalue];
				break;
			case 4:
				labelname.text = @"状态";
				
				labelvalue.text = [dicrebateinfo objectForKey:@"confirmstatus"];
				labelvalue.textColor = COLORNOW(0, 170, 236);
				[cell.contentView addSubview:labelvalue];
				break;
			case 5:
				labelname.text = @"金额";
				
				labelvalue.text = [NSString stringWithFormat:@"%@",[dicrebateinfo objectForKey:@"money"]];
				labelvalue.font = FONTMEDIUM(16.0f);
				[cell.contentView addSubview:labelvalue];
				break;
		}
	}
	else
	{
		switch (indexPath.row)
		{
			case 0:
				imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelname)+5, 5, 30, 30)];
				
				[imageheader setImageWithURL:[NSURL URLWithString:[dicactivityinfo objectForKey:@"actuvityuserpicture"]] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
				imageheader.layer.cornerRadius = 15.0f;
				imageheader.clipsToBounds = YES;
				imageheader.contentMode = UIViewContentModeScaleAspectFill;
				[cell.contentView addSubview:imageheader];
				
				labelname.text = @"扫码用户";
				
				sizeuser = [AddInterface getlablesize:[dicactivityinfo objectForKey:@"actuvityusername"] Fwidth:100 Fheight:20 Sfont:FONTN(15.0f)];
				labelusername = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, 10, sizeuser.width, 20)];
				labelusername.backgroundColor = [UIColor clearColor];
				labelusername.textColor = [UIColor blackColor];
				labelusername.font = FONTN(15.0f);
				labelusername.text = [dicactivityinfo objectForKey:@"actuvityusername"];
				[cell.contentView addSubview:labelusername];
				
				
				imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelusername)+5, XYViewTop(labelusername)+5, 28, 10)];
				[imageicon setImageWithURL:[NSURL URLWithString:[dicactivityinfo objectForKey:@"personjobtitle"]] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
				[cell.contentView addSubview:imageicon];
				
				break;
			case 1:
				labelname.text = @"扫码时间";
				
				labelvalue.text =  [dicactivityinfo objectForKey:@"activitytime"];
				[cell.contentView addSubview:labelvalue];
				break;
			case 2:
				labelname.text = @"扫码地点";
				
				labelvalue.adjustsFontSizeToFitWidth = YES;
				labelvalue.text = [dicactivityinfo objectForKey:@"activityplace"];
				[cell.contentView addSubview:labelvalue];
				break;
		}
	}
	
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	
	
}


#pragma mark 接口
//获取激活详情
-(void)getjihuodetail
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"qrcode"] = @"08380152002049421053";//self.FCqrcodeactivityid;

	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQCreateQRCodeDetailCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			FCdicscancodedetail = [dic objectForKey:@"data"];
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
