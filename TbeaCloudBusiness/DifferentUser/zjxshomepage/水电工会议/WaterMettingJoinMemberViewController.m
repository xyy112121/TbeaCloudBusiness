//
//  WaterMettingJoinMemberViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/5.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "WaterMettingJoinMemberViewController.h"

@interface WaterMettingJoinMemberViewController ()

@end

@implementation WaterMettingJoinMemberViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
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
	self.title = @"参与人员";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    [self getjoinmemberlist:@"1" PageSize:@"10"];
}


-(void)viewcell1:(NSDictionary *)dicfrom FromCell:(UITableViewCell *)fromcell
{
	
	UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
    NSString *strpic = [dicfrom objectForKey:@"thumbpicture"];//[InterfaceResource stringByAppendingString:[[dicfrom objectForKey:@"thumbpicture"] length]>0?[dicfrom objectForKey:@"thumbpicture"]:@"noimage.png"];
    [imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
	imageheader.layer.cornerRadius = 15.0f;
	imageheader.clipsToBounds = YES;
	[fromcell.contentView addSubview:imageheader];
	
	CGSize sizeuser = [AddInterface getlablesize:[dicfrom objectForKey:@"name"] Fwidth:100 Fheight:20 Sfont:FONTN(14.0f)];
	UILabel *labelusername = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, 7, sizeuser.width, 20)];
	labelusername.backgroundColor = [UIColor clearColor];
	labelusername.textColor = [UIColor blackColor];
	labelusername.font = FONTB(14.0f);
	labelusername.text = [dicfrom objectForKey:@"name"];
	[fromcell.contentView addSubview:labelusername];
	
	UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelusername)+5, XYViewTop(labelusername)+5, 10, 10)];
    NSString *strpic1 = [dicfrom objectForKey:@"persontypeicon"];//[InterfaceResource stringByAppendingString:[[dicfrom objectForKey:@"persontypeicon"] length]>0?[dicfrom objectForKey:@"persontypeicon"]:@"noimage.png"];
    [imageheader setImageWithURL:[NSURL URLWithString:strpic1] placeholderImage:LOADIMAGE(@"scanrebateheader1", @"png")];
	[fromcell.contentView addSubview:imageicon];
	
	UILabel *straddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewBottom(labelusername)-2, SCREEN_WIDTH-100, 17)];
	straddr.backgroundColor = [UIColor clearColor];
	straddr.textColor = COLORNOW(117, 117, 117);
	straddr.font = FONTN(12.0f);
	straddr.text = [dicfrom objectForKey:@"companyandjobposition"];
	[fromcell.contentView addSubview:straddr];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 40;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
	viewheader.backgroundColor = [UIColor whiteColor];
	viewheader.layer.borderColor = COLORNOW(210, 210, 210).CGColor;
	viewheader.layer.borderWidth = 0.7;
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(18, 5, 40, 30)];
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textColor = [UIColor blackColor];
	labelname.text = @"人员";
	labelname.clipsToBounds = YES;
	labelname.font = FONTMEDIUM(15.0f);
	[viewheader addSubview:labelname];
	
	UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.7)];
	imageline.backgroundColor = COLORNOW(220, 220, 220);
	[viewheader addSubview:imageline];
	
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
	
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
	[self viewcell1:dictemp FromCell:cell];
	
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark 接口

-(void)getjoinmemberlist:(NSString *)page PageSize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"meetingid"] = self.FCmettingid;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQWaterMettingJoinMemberCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraydata  = [[dic objectForKey:@"data"] objectForKey:@"meetingparticipantlist"];
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
