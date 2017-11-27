//
//  MyFansViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/21.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyFansViewController.h"

@interface MyFansViewController ()

@end

@implementation MyFansViewController

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
	
	UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
	UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
	buttonright.titleLabel.font = FONTN(14.0f);
	buttonright.tag = 900;
	[buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[buttonright setTitle:@"编辑" forState:UIControlStateNormal];
	buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
	[buttonright addTarget:self action: @selector(ClickEdit:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewright addSubview:buttonright];
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
	
	// Do any additional setup after loading the view.
}

#pragma mark 页面布局
-(void)initview
{
	self.title = @"我的粉丝";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	isedit = EnNotSelect;
	selectarray = [[NSMutableArray alloc] init];
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf getmyfansperson:@"1" PageSize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf getmyfansperson:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
    
    [self getmyfansperson:@"1" PageSize:@"10"];
}

//个人布局
-(UIView *)getcellviewperson:(NSDictionary *)sender Frame:(CGRect)frame IndexPath:(NSIndexPath *)indexpath
{
	UIView *viewcell = [[UIView alloc] initWithFrame:frame];
	viewcell.backgroundColor = [UIColor clearColor];
	float orginx = 20;
	
	if(isedit == EnSelectd)
	{
		UIButton *buttonselectitem = [UIButton buttonWithType:UIButtonTypeCustom];
		buttonselectitem.frame = CGRectMake(0, 10, 60, 60);
		[buttonselectitem setImage:LOADIMAGE(@"menotselectgray", @"png") forState:UIControlStateNormal];
		[buttonselectitem addTarget:self action:@selector(selectproduct:) forControlEvents:UIControlEventTouchUpInside];
        buttonselectitem.tag = EnAttentionSelectItemBtTag;
        [viewcell addSubview:buttonselectitem];
		orginx = XYViewWidth(buttonselectitem);
	}
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(orginx, 10, 40, 40)];
    NSString *strpic = [sender objectForKey:@"thumbpicture"];//[InterfaceResource stringByAppendingString:[[sender objectForKey:@"thumbpicture"] length]>0?[sender objectForKey:@"thumbpicture"]:@"noimage.png"];
    [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"tbeatestpic", @"png")];
	imageview.layer.cornerRadius = 20.0f;
	imageview.clipsToBounds = YES;
	[viewcell addSubview:imageview];
	
	NSString *str = [sender objectForKey:@"name"];
	CGSize size = [AddInterface getlablesize:str Fwidth:SCREEN_WIDTH-(XYViewR(imageview)+10)-60 Fheight:20 Sfont:FONTN(15.0f)];
	UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10, XYViewTop(imageview), size.width, size.height)];
	lablename.text =str;
	lablename.font = FONTN(15.0f);
	lablename.textColor = [UIColor blackColor];
	lablename.backgroundColor = [UIColor clearColor];
	[viewcell addSubview:lablename];
	
	UIImageView *imageviewlabel = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(lablename)+5, XYViewTop(lablename)+4, 30, 11)];
    NSString *strpic1 = [sender objectForKey:@"persontypeicon"];//[InterfaceResource stringByAppendingString:[[sender objectForKey:@"persontypeicon"] length]>0?[sender objectForKey:@"persontypeicon"]:@"noimage.png"];
    [imageviewlabel setImageWithURL:[NSURL URLWithString:strpic1] placeholderImage:LOADIMAGE(@"meusericon", @"png")];
	[viewcell addSubview:imageviewlabel];
	
	UILabel *lablefenlei = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablename), XYViewBottom(imageview)-18, 160, 18)];
	lablefenlei.text =[sender objectForKey:@"info"];
	lablefenlei.font = FONTN(13.0f);
	lablefenlei.textColor = COLORNOW(117, 117, 117);
	lablefenlei.backgroundColor = [UIColor clearColor];
	[viewcell addSubview:lablefenlei];
	
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

-(void)selectproduct:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int tagnow = (int)[button tag]-EnAttentionSelectItemBtTag;
    NSDictionary *dicselect = [FCarraydata objectAtIndex:tagnow];
    int flag = 0;
    for(int i=0;i<[selectarray count];i++)
    {
        NSDictionary *dictemp = [selectarray objectAtIndex:i];
        if([[dictemp objectForKey:@"fansid"] isEqualToString:[dicselect objectForKey:@"fansid"]])
        {
            flag = 1;
            [button setImage:LOADIMAGE(@"menotselectgray", @"png") forState:UIControlStateNormal];
            [selectarray removeObject:dicselect];
            break;
        }
    }
    if(flag == 0)
    {
        [selectarray addObject:dicselect];
        [button setImage:LOADIMAGE(@"me默认收货地址", @"png") forState:UIControlStateNormal];
    }
}

-(void)ClickEdit:(id)sender
{
    
    UIButton *button = (UIButton *)sender;
    if(isedit == EnNotSelect ) //未编辑 状态
    {
        isedit = EnSelectd;
        [selectarray removeAllObjects];
        [button setTitle:@"取消关注" forState:UIControlStateNormal];
    }
    else   //当前是完成状态切换成编辑
    {
        isedit = EnNotSelect;
        [button setTitle:@"编辑" forState:UIControlStateNormal];
        for(int i=0;i<[selectarray count];i++)
        {
            NSDictionary *dictemp = [selectarray objectAtIndex:i];
            FCselectids = [FCselectids length]==0?[dictemp objectForKey:@"fansid"]:[NSString stringWithFormat:@"%@,%@",FCselectids,[dictemp objectForKey:@"fansid"]];
        }
        if([FCselectids length]>0)
            [self requestcannelattention];
    }
    
    [tableview reloadData];
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
	return 60;
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
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
	UIView *viewcell = [self getcellviewperson:dictemp Frame:CGRectMake(0, 0, SCREEN_WIDTH, cell.frame.size.height) IndexPath:indexPath];
	[cell.contentView addSubview:viewcell];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

#pragma mark 接口
-(void)getmyfansperson:(NSString *)page PageSize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    params[@"userid"] = _FCuserid;
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQUserGetMyFanListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"myfanslist"];
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

-(void)requestcannelattention
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fansids"] = FCselectids;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQUserFansRemoveIdsCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            [self getmyfansperson:@"1" PageSize:@"10"];
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
