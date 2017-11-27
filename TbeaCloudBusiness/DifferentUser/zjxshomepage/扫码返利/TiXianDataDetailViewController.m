//
//  TiXianDataDetailViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/26.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "TiXianDataDetailViewController.h"

@interface TiXianDataDetailViewController ()

@end

@implementation TiXianDataDetailViewController

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
	self.title = @"提现详情";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
	tableview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tableview];
	
	[self setExtraCellLineHidden:tableview];
	[self gettixiandetailinfo];
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

-(void)viewcell1:(NSDictionary *)dic FromCell:(UITableViewCell *)fromcell LeftName:(NSString *)leftname
{
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 80, 20)];
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textColor = COLORNOW(117, 117, 117);
	labelname.font = FONTN(15.0f);
	labelname.text = leftname;
	[fromcell.contentView addSubview:labelname];

	UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelname)+10, 10, 30, 30)];
    NSString *strpic = [dic objectForKey:@"thumbpicture"];//[InterfaceResource stringByAppendingString:[[dic objectForKey:@"thumbpicture"] length]>0?[dic objectForKey:@"thumbpicture"]:@"noimage.png"];
	[imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
	imageheader.contentMode = UIViewContentModeScaleAspectFill;
	
	imageheader.layer.cornerRadius = 15.0f;
	imageheader.clipsToBounds = YES;
	[fromcell.contentView addSubview:imageheader];
	
	CGSize sizeuser = [AddInterface getlablesize:[dic objectForKey:@"personname"] Fwidth:100 Fheight:20 Sfont:FONTN(14.0f)];
	UILabel *labelusername = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, 7, sizeuser.width, 20)];
	labelusername.backgroundColor = [UIColor clearColor];
	labelusername.textColor = [UIColor blackColor];
	labelusername.font = FONTN(14.0f);
	labelusername.text = [dic objectForKey:@"personname"];
	[fromcell.contentView addSubview:labelusername];
	
	UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelusername)+5, XYViewTop(labelusername)+5, 25, 10)];
    strpic = [dic objectForKey:@"persontypeicon"];//[InterfaceResource stringByAppendingString:[[dic objectForKey:@"persontypeicon"] length]>0?[dic objectForKey:@"persontypeicon"]:@"noimage.png"];
	[imageicon setImageWithURL:[NSURL URLWithString:strpic]];
	[fromcell.contentView addSubview:imageicon];
	
	UILabel *straddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewBottom(labelusername)-2, SCREEN_WIDTH-100, 17)];
	straddr.backgroundColor = [UIColor clearColor];
	straddr.textColor = COLORNOW(117, 117, 117);
	straddr.font = FONTN(12.0f);
	straddr.text = [dic objectForKey:@"companyname"];
	[fromcell.contentView addSubview:straddr];
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
	if(indexPath.section == 0)
	{
		if((indexPath.row ==0)||(indexPath.row ==1))
		{
			return 50;
		}
	}
	else if(indexPath.section == 1)
	{
		if(indexPath.row ==0)
		{
			return 50;
		}
	}
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
	
	
	UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(labelname)+10, 10, SCREEN_WIDTH-100, 20)];
	labelvalue.backgroundColor = [UIColor clearColor];
	labelvalue.textColor = [UIColor blackColor];
	labelvalue.font = FONTN(15.0f);
	
	
	UIImageView *imageheader;
	UIImageView *imageicon;
	UILabel *labelusername;
	CGSize sizeuser;
	NSDictionary *dic;
	NSString *strpic;
    UILabel *lablemoneyflag1;
	if(indexPath.section == 0)
	{
		switch (indexPath.row)
		{
			case 0:
				dic = [FCdicdata objectForKey:@"payeeinfo"];
				labelname.text = @"提现用户";
				labelname.frame = CGRectMake(20, 15, 80, 20);
				[cell.contentView addSubview:labelname];
				
				imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelname)+10, 10, 30, 30)];
                strpic = [dic objectForKey:@"thumbpicture"];//[InterfaceResource stringByAppendingString:[[dic objectForKey:@"thumbpicture"] length]>0?[dic objectForKey:@"thumbpicture"]:@"noimage.png"];
				[imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
				imageheader.contentMode = UIViewContentModeScaleAspectFill;
				imageheader.layer.cornerRadius = 15.0f;
				imageheader.clipsToBounds = YES;
				[cell.contentView addSubview:imageheader];
				
				sizeuser = [AddInterface getlablesize:[dic objectForKey:@"personname"] Fwidth:100 Fheight:20 Sfont:FONTN(15.0f)];
				labelusername = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, 15, sizeuser.width, 20)];
				labelusername.backgroundColor = [UIColor clearColor];
				labelusername.textColor = [UIColor blackColor];
				labelusername.font = FONTN(15.0f);
				labelusername.text = [dic objectForKey:@"personname"];
				[cell.contentView addSubview:labelusername];
				
				imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelusername)+5, XYViewTop(labelusername)+5, 10, 10)];
                strpic = [dic objectForKey:@"persontypeicon"];//[InterfaceResource stringByAppendingString:[[dic objectForKey:@"persontypeicon"] length]>0?[dic objectForKey:@"persontypeicon"]:@"noimage.png"];
				[imageheader setImageWithURL:[NSURL URLWithString:strpic]];
				[cell.contentView addSubview:imageicon];
				break;
			case 1:
				dic = [FCdicdata objectForKey:@"ownerinfo"];
			//	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				[self viewcell1:dic FromCell:cell LeftName:@"隶属关系"];
				break;
			case 2:
				labelname.text = @"提现编码";
				[cell.contentView addSubview:labelname];
				
				labelvalue.text = [[FCdicdata objectForKey:@"takemoneycodeinfo"] objectForKey:@"takemoneycode"];
				[cell.contentView addSubview:labelvalue];
				break;
			case 3:
				labelname.text = @"生成时间";
				[cell.contentView addSubview:labelname];
				
				labelvalue.text = [[FCdicdata objectForKey:@"takemoneycodeinfo"] objectForKey:@"generatecodetime"];
				[cell.contentView addSubview:labelvalue];
				break;
			case 4:
				labelname.text = @"金额";
				[cell.contentView addSubview:labelname];
				
                
                
				labelvalue.text = [[FCdicdata objectForKey:@"takemoneycodeinfo"] objectForKey:@"money"];
				labelvalue.font = FONTMEDIUM(16.0f);
                labelvalue.frame =  CGRectMake(XYViewR(labelname)+20, 10, SCREEN_WIDTH-100, 20);
				[cell.contentView addSubview:labelvalue];
                
                lablemoneyflag1 = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelvalue)-10, XYViewTop(labelvalue)+4, 10,10)];
                lablemoneyflag1.text = @"￥";
                lablemoneyflag1.font = FONTMEDIUM(11.0f);
                lablemoneyflag1.textColor = [UIColor blackColor];
                lablemoneyflag1.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:lablemoneyflag1];
				break;
		}
	}
	else
	{
		switch (indexPath.row)
		{
			case 0:
				dic = [FCdicdata objectForKey:@"paymoneyinfo"];
			//	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				[self viewcell1:dic FromCell:cell LeftName:@"支付单位"];
				
				break;
			case 1:
				labelname.text = @"扫码时间";
				[cell.contentView addSubview:labelname];
				
				labelvalue.text = [[FCdicdata objectForKey:@"paymoneyinfo"] objectForKey:@"paytime"];
				[cell.contentView addSubview:labelvalue];
				break;
			case 2:
				labelname.text = @"扫码地点";
				[cell.contentView addSubview:labelname];
				
				labelvalue.text =  [[FCdicdata objectForKey:@"paymoneyinfo"] objectForKey:@"payplace"];
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
//获取详情
-(void)gettixiandetailinfo
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"takemoneyid"] = self.FCtakemoneyid;

	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQTiXianDetailInfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			FCdicdata = [dic objectForKey:@"data"];
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
