//
//  TbeaNewsListViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/14.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "TbeaNewsListViewController.h"

@interface TbeaNewsListViewController ()

@end

@implementation TbeaNewsListViewController
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
	self.title = @"新闻资讯";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	FCcategory = @"companynews";
    
    
	UIView *view = [self addtabviewheader:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
	[self.view addSubview:view];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40)];
	tableview.backgroundColor = [UIColor clearColor];
	
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        if([FCcategory isEqualToString:@"companynews"])
            [weakSelf getnewspage:@"1" PageSize:@"10"];
        else if([FCcategory isEqualToString:@"industrynews"])
            [weakSelf getnewspage:@"1" PageSize:@"10"];
        else if([FCcategory isEqualToString:@"decorationnews"])
            [weakSelf getnewspage:@"1" PageSize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if([FCcategory isEqualToString:@"companynews"])
            [weakSelf getnewspage:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
        else if([FCcategory isEqualToString:@"industrynews"])
            [weakSelf getnewspage:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
        else if([FCcategory isEqualToString:@"decorationnews"])
            [weakSelf getnewspage:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
    
    [self getnewspage:@"1" PageSize:@"10"];
}

//表头
-(UIView *)addtabviewheader:(CGRect)frame
{
	UIView *viewselectitem = [[UIView alloc] initWithFrame:frame];
	viewselectitem.backgroundColor = [UIColor whiteColor];
	
	UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 0.7)];
	line1.backgroundColor = COLORNOW(200, 200, 200);
	[viewselectitem addSubview:line1];
	
	UIButton *buttonleft = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonleft.frame = CGRectMake(0, 0, SCREEN_WIDTH/3,39);
	buttonleft.backgroundColor = [UIColor clearColor];
	buttonleft.tag = EnTbeaNewsListSelect1;
	[buttonleft setTitle:@"公司动态" forState:UIControlStateNormal];
	buttonleft.titleLabel.font = FONTN(15.0f);
	[buttonleft setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
	[buttonleft addTarget:self action:@selector(clickbuttonselectitem:) forControlEvents:UIControlEventTouchUpInside];
	[viewselectitem addSubview:buttonleft];
	
	UIButton *buttonmiddle = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonmiddle.frame = CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3,39);
	buttonmiddle.backgroundColor = [UIColor clearColor];
	buttonmiddle.tag = EnTbeaNewsListSelect2;
	[buttonmiddle setTitle:@"企业新闻" forState:UIControlStateNormal];
	buttonmiddle.titleLabel.font = FONTN(15.0f);
	[buttonmiddle setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
	[buttonmiddle addTarget:self action:@selector(clickbuttonselectitem:) forControlEvents:UIControlEventTouchUpInside];
	[viewselectitem addSubview:buttonmiddle];
	
	UIButton *buttonright = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonright.frame = CGRectMake(SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH/3,39);
	buttonright.backgroundColor = [UIColor clearColor];
	buttonright.tag = EnTbeaNewsListSelect3;
	[buttonright setTitle:@"家装资讯" forState:UIControlStateNormal];
	buttonright.titleLabel.font = FONTN(15.0f);
	[buttonright setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
	[buttonright addTarget:self action:@selector(clickbuttonselectitem:) forControlEvents:UIControlEventTouchUpInside];
	[viewselectitem addSubview:buttonright];
	
	return viewselectitem;
}

-(UIView *)getcellview:(NSDictionary *)sender Frame:(CGRect)frame
{
	UIView *viewcell = [[UIView alloc] initWithFrame:frame];
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 100, 60)];
    NSString *strpic = [sender objectForKey:@"thumb"];//[NSString stringWithFormat:@"%@%@",InterfaceResource,[[sender objectForKey:@"Thumb"] length]>0?[sender objectForKey:@"Thumb"]:@"123"];
    [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"tbeatestpic", @"png")];
	[viewcell addSubview:imageview];
	
	NSString *str = [sender objectForKey:@"title"];
	CGSize size = [AddInterface getlablesize:str Fwidth:SCREEN_WIDTH-140 Fheight:40 Sfont:FONTN(15.0f)];
	UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10, XYViewTop(imageview), size.width, size.height)];
	lablename.text =str;
	lablename.font = FONTN(15.0f);
	lablename.textColor = [UIColor blackColor];
	lablename.numberOfLines = 2;
	lablename.backgroundColor = [UIColor clearColor];
	[viewcell addSubview:lablename];
	
	UILabel *lablefenlei = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablename), XYViewBottom(imageview)-18, 60, 18)];
	lablefenlei.text =[sender objectForKey:@"author"];
	lablefenlei.font = FONTN(13.0f);
	lablefenlei.textColor = COLORNOW(117, 117, 117);
	lablefenlei.backgroundColor = [UIColor clearColor];
	[viewcell addSubview:lablefenlei];
	
	UILabel *labletime = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150, XYViewTop(lablefenlei), 130, 18)];
	labletime.text =[sender objectForKey:@"time"];
	labletime.font = FONTN(13.0f);
	labletime.textColor = COLORNOW(117, 117, 117);
	labletime.textAlignment = NSTextAlignmentRight;
	labletime.backgroundColor = [UIColor clearColor];
	[viewcell addSubview:labletime];
	
	return viewcell;
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

#pragma mark IBAction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)clickbuttonselectitem:(id)sender
{
	UIButton *button = (UIButton *)sender;
	UIButton *button1 = [self.view viewWithTag:EnTbeaNewsListSelect1];
	UIButton *button2 = [self.view viewWithTag:EnTbeaNewsListSelect2];
	UIButton *button3 = [self.view viewWithTag:EnTbeaNewsListSelect3];
	
	[button1 setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
	[button2 setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
	[button3 setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
	[button setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
	int tagnow = (int)[button tag];
	if(tagnow == EnTbeaNewsListSelect1)
	{
		FCcategory = @"companynews";
	}
	else if(tagnow == EnTbeaNewsListSelect2)
	{
		FCcategory = @"industrynews";
	}
	else if(tagnow == EnTbeaNewsListSelect3)
	{
		FCcategory = @"decorationnews";
	}
    [self getnewspage:@"1" PageSize:@"10"];
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
	return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [FCarraydata count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 0.001;

}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	return nil;
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
	UIView *viewcell = [self getcellview:dictemp Frame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
	[cell.contentView addSubview:viewcell];


	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
	TbeaNewsDetailViewController *tbeanews = [[TbeaNewsDetailViewController alloc] init];
    tbeanews.FCnewsid = [dictemp objectForKey:@"id"];
	[self.navigationController pushViewController:tbeanews animated:YES];
}


#pragma mark 接口
-(void)getnewspage:(NSString *)page PageSize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    params[@"category"] = FCcategory;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQTbeaNewsPageCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"newslist"];
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
