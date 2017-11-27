//
//  MyMessageViewController.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/1/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyMessageViewController.h"

@interface MyMessageViewController ()

@end

@implementation MyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initview];
	
	self.title = @"消息分类";
	UIImage* img=LOADIMAGE(@"returnback", @"png");
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	[button setImage:img forState:UIControlStateNormal];
	[button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
    // Do any additional setup after loading the view.
}

-(void)initview
{
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor whiteColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
	[self getmymessage:@"1" Pagesize:@"10"];
	
	MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData:)];
	header.automaticallyChangeAlpha = YES;
	header.lastUpdatedTimeLabel.hidden = YES;
	tableview.mj_header = header;
	
	
	
}

-(void)viewWillAppear:(BOOL)animated
{
	[[self.navigationController.navigationBar viewWithTag:EnNearSearchViewBt] removeFromSuperview];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
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
	return 90;
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
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 60, 60)];
	NSURL *urlstr = [NSURL URLWithString:[URLPicHeader stringByAppendingString:[dictemp objectForKey:@"picture"]]];
	[imageview setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"testpic3", @"png")];
	[cell.contentView addSubview:imageview];
	
	NSString *nowcount = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"newcount"]];
	if([nowcount intValue]>0)
	{
		UIImageView *imageviewpoint = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-15, imageview.frame.origin.y-8, 25, 16)];
		imageviewpoint.layer.cornerRadius = 5.0f;
		imageviewpoint.clipsToBounds = YES;
		imageviewpoint.layer.borderColor = [UIColor whiteColor].CGColor;
		imageviewpoint.layer.borderWidth = 1.0f;
		imageviewpoint.backgroundColor = [UIColor redColor];
		[cell.contentView addSubview:imageviewpoint];
		
		UILabel *labelnum = [[UILabel alloc] initWithFrame:CGRectMake(imageviewpoint.frame.origin.x, imageviewpoint.frame.origin.y, 25, 16)];
		labelnum.textColor = [UIColor whiteColor];
		labelnum.textAlignment = NSTextAlignmentCenter;
		labelnum.font = FONTN(11.0f);
		labelnum.text = nowcount;
		[cell.contentView addSubview:labelnum];
	}
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width+15, imageview.frame.origin.y, 150, 20)];
	labeltitle.textColor = ColorBlackdeep;
	labeltitle.font = FONTN(14.0f);
	labeltitle.text = [dictemp objectForKey:@"name"];
	[cell.contentView addSubview:labeltitle];
	
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-120, labeltitle.frame.origin.y, 110, 20)];
	labeltime.textColor = ColorBlackGray;
	labeltime.font = FONTN(14.0f);
	labeltime.text = [dictemp objectForKey:@"lasttime"];
	labeltime.textAlignment = NSTextAlignmentRight;
	[cell.contentView addSubview:labeltime];
	
	
	UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x, labeltitle.frame.origin.y+labeltitle.frame.size.height+3, SCREEN_WIDTH-100, 40)];
	labelvalue.textColor = ColorBlackGray;
	labelvalue.font = FONTN(14.0f);
	labelvalue.numberOfLines = 2;
	labelvalue.text =  [dictemp objectForKey:@"lastmessagetitle"];
	[cell.contentView addSubview:labelvalue];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
    MyMessageListViewController *messagelist = [[MyMessageListViewController alloc] init];
    messagelist.FCcategoryid = [dictemp objectForKey:@"id"];
    [self.navigationController pushViewController:messagelist animated:YES];
    
//	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
//	WebViewContentViewController *webviewcontent = [[WebViewContentViewController alloc] init];
//	webviewcontent.strtitle = [dictemp objectForKey:@"name"];
//	NSString *str = @"http://www.u-shang.net/enginterface/index.php/Apph5/messagelist?messagecategoryid=";
//	str = [NSString stringWithFormat:@"%@%@",str,[dictemp objectForKey:@"id"]];
//	webviewcontent.strnewsurl = str;
//	[self.navigationController pushViewController:webviewcontent animated:YES];
	
}

#pragma mark IBaction
-(void)loadNewData:(id)sender
{
	[self getmymessage:@"1" Pagesize:@"10"];
}

-(void)loadMoreData:(id)sender
{
	[self getmymessage:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10]];
}

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
	self.hidesBottomBarWhenPushed = NO;
}

#pragma mark 接口
-(void)getmymessage:(NSString *)page Pagesize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:page forKey:@"page"];
    [params setObject:pagesize forKey:@"pagesize"];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQMessageCategoryListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            if([[dic objectForKey:@"success"] isEqualToString:@"true"])
            {
                arraydata = [[dic objectForKey:@"data"] objectForKey:@"messagecategorylist"];
                tableview.delegate = self;
                tableview.dataSource = self;
                [tableview reloadData];
                if([arraydata count]>9)
                {
                    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];
                    tableview.mj_footer = footer;
                }
            }
            else
            {
                [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
            }
            [tableview.mj_header endRefreshing];
            [tableview.mj_footer endRefreshing];
            
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
