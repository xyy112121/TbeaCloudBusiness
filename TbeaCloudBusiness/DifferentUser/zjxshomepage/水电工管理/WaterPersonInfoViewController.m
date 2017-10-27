//
//  WaterPersonInfoViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "WaterPersonInfoViewController.h"

@interface WaterPersonInfoViewController ()

@end

@implementation WaterPersonInfoViewController

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
	self.title = @"个人资料";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
	tableview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tableview];
	
	[self setExtraCellLineHidden:tableview];
    
    [self getpersoninfo];
}

-(void)viewWillAppear:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:NO animated:YES];
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
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.row == 5)
		return 60;
	return 40;
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
	
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, 20)];
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textColor = COLORNOW(117, 117, 117);
	labelname.font = FONTN(15.0f);
	
	
	UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-120, 20)];
	labelvalue.backgroundColor = [UIColor clearColor];
	labelvalue.textColor = [UIColor blackColor];
	labelvalue.font = FONTN(15.0f);
	
	
	CGSize size;
	NSString *strinfo;
	if(indexPath.section == 0)
	{
		switch (indexPath.row)
		{
			case 0:
				
				labelname.text = @"姓名";
				[cell.contentView addSubview:labelname];
				
				labelvalue.text = [FCdicdata objectForKey:@"personname"];
				[cell.contentView addSubview:labelvalue];
				break;
			case 1:
				labelname.text = @"性别";
				[cell.contentView addSubview:labelname];
				
				labelvalue.text = [FCdicdata objectForKey:@"sex"];
				[cell.contentView addSubview:labelvalue];
				
				break;
			case 2:
				labelname.text = @"年龄";
				[cell.contentView addSubview:labelname];
				
				labelvalue.text = @"48";
				[cell.contentView addSubview:labelvalue];
				break;
			case 3:
				labelname.text = @"认证状态";
				[cell.contentView addSubview:labelname];
				
				labelvalue.text = [FCdicdata objectForKey:@"whetheridentifyname"];
				[cell.contentView addSubview:labelvalue];
				break;
			case 4:
				labelname.text = @"隶属";
				[cell.contentView addSubview:labelname];
				
				labelvalue.text = [FCdicdata objectForKey:@"belongtocompany"];
				[cell.contentView addSubview:labelvalue];
				break;
			case 5:
				labelname.text = @"个人介绍";
				[cell.contentView addSubview:labelname];
				
				strinfo = [FCdicdata objectForKey:@"introduce"];
				size = [AddInterface getlablesize:strinfo Fwidth:SCREEN_WIDTH-120 Fheight:40 Sfont:FONTN(15.0f)];
				labelvalue.text = strinfo;
				labelvalue.numberOfLines = 0;
				labelvalue.frame = CGRectMake(XYViewL(labelvalue), XYViewTop(labelvalue), size.width, size.height);
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
-(void)getpersoninfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"electricianid"] = self.FCelectricianid;
    
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:REWaterPersoninfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCdicdata = [[dic objectForKey:@"data"] objectForKey:@"electricianpersonalinfo"];
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
