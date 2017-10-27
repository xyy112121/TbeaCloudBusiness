//
//  SearchResultViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/6.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

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

-(void)viewWillAppear:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
}

-(void)initview
{
	[self.navigationController setNavigationBarHidden:YES];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = [UIColor whiteColor];
	self.title = @"搜索结果";
    
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:tableview];
	[self getsearchresult:@"1" PageSize:@"10"];
}

-(UIView *)viewcellelectrician:(NSDictionary *)dic Frame:(CGRect)frame NameType:(NSString *)nametype
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 120, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = COLORNOW(117, 117, 117);
    labelname.font = FONTN(15.0f);
    labelname.text = nametype;
    [view addSubview:labelname];
    
    UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(20, XYViewBottom(labelname)+10, 40, 40)];
    NSString *strpic;
    strpic = [dic objectForKey:@"thumbpicture"];//[InterfaceResource stringByAppendingString:[[dic objectForKey:@"thumbpicture"] length]>0?[dic objectForKey:@"thumbpicture"]:@"noimage.png"];
    [imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
    imageheader.contentMode = UIViewContentModeScaleAspectFill;
    imageheader.layer.cornerRadius = 15.0f;
    imageheader.clipsToBounds = YES;
    [view addSubview:imageheader];
    
    NSString *strsizename;
    strsizename = [dic objectForKey:@"name"];
    CGSize sizeuser = [AddInterface getlablesize:strsizename Fwidth:200 Fheight:20 Sfont:FONTB(16.0f)];
    UILabel *labelusername = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewTop(imageheader), sizeuser.width, 20)];
    labelusername.backgroundColor = [UIColor clearColor];
    labelusername.textColor = [UIColor blackColor];
    labelusername.font = FONTB(16.0f);
    labelusername.text = strsizename;
    [view addSubview:labelusername];
    
    UILabel *straddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelusername), XYViewBottom(labelusername), SCREEN_WIDTH-100, 20)];
    straddr.backgroundColor = [UIColor clearColor];
    straddr.textColor = COLORNOW(117, 117, 117);
    straddr.font = FONTN(14.0f);
    straddr.text = [dic objectForKey:@"description"];
    [view addSubview:straddr];
    
    return view;
}


#pragma mark IBAction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark tableview delegate
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
	return 90;
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
    if([[dictemp objectForKey:@"objecttype"] isEqualToString:@"electrician"]) //水电工
    {
        UIView *view = [self viewcellelectrician:dictemp Frame:CGRectMake(0, 0, SCREEN_WIDTH, 90) NameType:@"水电工"];
        [cell.contentView addSubview:view];
    }
    else if([[dictemp objectForKey:@"objecttype"] isEqualToString:@"servicemeeting"]) //水电工会议
    {
        UIView *view = [self viewcellelectrician:dictemp Frame:CGRectMake(0, 0, SCREEN_WIDTH, 90) NameType:@"水电工会议"];
        [cell.contentView addSubview:view];
    }
    
//	NearByProductPageCellView *productcell = [[NearByProductPageCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 109) Dic:dictemp];
//	[cell.contentView addSubview:productcell];
	
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    if([[dictemp objectForKey:@"objecttype"] isEqualToString:@"electrician"]) //水电工
    {
        WaterPersonHpInfoViewController *waterperson = [[WaterPersonHpInfoViewController alloc] init];
        waterperson.FCelectricianid = [dictemp objectForKey:@"objectprimarykey"];
        [self.navigationController pushViewController:waterperson animated:YES];
    }
    else if([[dictemp objectForKey:@"objecttype"] isEqualToString:@"servicemeeting"]) //水电工会议
    {
        WaterMettingDetailViewController *mettingdetail = [[WaterMettingDetailViewController alloc] init];
        mettingdetail.FCmettingid = [dictemp objectForKey:@"objectprimarykey"];
        [self.navigationController pushViewController:mettingdetail animated:YES];
    }
}

#pragma mark 接口
-(void)getsearchresult:(NSString *)page PageSize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"keyword"] = _FCsearchkeyword;
    params[@"searchitem"] = _FCSearchFromType;
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQSearchResultListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"searchresultlist"];
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
