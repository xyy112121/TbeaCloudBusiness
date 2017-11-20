//
//  CustomQustionViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/7.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "CustomQustionViewController.h"

@interface CustomQustionViewController ()

@end

@implementation CustomQustionViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
	[self initview];
	
    UIButton *buttonloging = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonloging.frame = CGRectMake(20, StatusBarHeight+2, 40, 40);
    buttonloging.backgroundColor = [UIColor clearColor];
    [buttonloging setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
    [buttonloging addTarget:self action:@selector(returnback) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonloging];
	
}

-(void)initview
{
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"客服中心";
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor whiteColor];
	
    if (@available(iOS 11.0, *)) {
        tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
    }
    
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
	[self initheader];
	[self getcustomquest:@"1" Pagesize:@"10"];
	
	
}

-(void)initheader
{
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
	viewheader.backgroundColor = ColorBlue;
	
	
	
	buttontel = [UIButton buttonWithType:UIButtonTypeCustom];
	buttontel.titleLabel.font = FONTN(15.0f);
	[buttontel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[buttontel setTitle:@"0838-2802916" forState:UIControlStateNormal];
	buttontel.layer.cornerRadius = 15.0f;
	buttontel.clipsToBounds = YES;
	buttontel.layer.borderWidth = 1.0f;
	buttontel.layer.borderColor = [UIColor whiteColor].CGColor;
	[buttontel addTarget:self action:@selector(customtel:) forControlEvents:UIControlEventTouchUpInside];
	buttontel.frame = CGRectMake((SCREEN_WIDTH-150)/2,XYViewHeight(viewheader)-30-50, 150, 30);
	[buttontel setBackgroundColor:COLORNOW(105, 173, 225)];
	[viewheader addSubview:buttontel];
	
	UILabel *labelins = [[UILabel alloc] initWithFrame:CGRectMake(0, XYViewHeight(viewheader)-30, SCREEN_WIDTH, 30)];
	labelins.textColor = ColorBlackdeep;
	labelins.backgroundColor = Colorgray;
	labelins.font = FONTN(15.0f);
	labelins.text = @"   常见问题";
	[viewheader addSubview:labelins];
	
	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, viewheader.frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
	imageviewline.backgroundColor = ColorBlackVeryGray;
	[viewheader addSubview:imageviewline];
	
	tableview.tableHeaderView = viewheader;
}

#pragma mark IBaction
-(void)customtel:(id)sender
{
	UIButton *button =(UIButton *)sender;
	NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[button currentTitle]];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark tabbleview代理
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
	// Return the number of rows in the section.
	return [arraydata count];
	
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
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
	labelname.textColor = ColorBlackdeep;
	labelname.font = FONTN(15.0f);
	labelname.text = [dictemp objectForKey:@"question"];
	[cell.contentView addSubview:labelname];
	
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
    SwiftWebview * s1 = [[SwiftWebview alloc] init];
    s1.hidesBottomBarWhenPushed = YES;
    NSString *strurlnow = [NSString stringWithFormat:@"%@%@%@",[app.GBURLPreFix length]>0?app.GBURLPreFix:Interfacehtmlurlheader,HtmlURLHelpDetail,[dictemp objectForKey:@"id"]];
    s1.FCStrURL = strurlnow;
    s1.FCtitle = @"";
    [self.navigationController pushViewController:s1 animated:self];
}

#pragma mark 接口
-(void)getcustomquest:(NSString *)page Pagesize:(NSString *)pagesize
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAYUN015003001000" ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            arraydata = [[dic objectForKey:@"data"] objectForKey:@"questionlist"];
            [buttontel setTitle:[[[dic objectForKey:@"data"] objectForKey:@"hotlineinfo"] objectForKey:@"mobilenumber"] forState:UIControlStateNormal];
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
