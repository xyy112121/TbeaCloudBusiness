//
//  MallStoreDynamicListViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/9/1.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MallStoreDynamicListViewController.h"

@interface MallStoreDynamicListViewController ()

@end

@implementation MallStoreDynamicListViewController

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
    
    
    UIView *contentViewright1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *buttonright1 = [[UIButton alloc] initWithFrame:contentViewright1.bounds];
    [buttonright1 setTitle:@"添加" forState:UIControlStateNormal];
    buttonright1.titleLabel.font = FONTN(15.0f);
    [buttonright1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonright1 addTarget:self action: @selector(addnewdynamic:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright1 addSubview:buttonright1];
    buttonright1.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
    UIBarButtonItem *barButtonItemright1 = [[UIBarButtonItem alloc] initWithCustomView:contentViewright1];
    
    UIView *contentViewright2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *buttonright2 = [[UIButton alloc] initWithFrame:contentViewright2.bounds];
    [buttonright2 setTitle:@"编辑" forState:UIControlStateNormal];
    buttonright2.titleLabel.font = FONTN(15.0f);
    [buttonright2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonright2 addTarget:self action: @selector(ClickEdit:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright2 addSubview:buttonright2];
    buttonright2.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
    UIBarButtonItem *barButtonItemright2 = [[UIBarButtonItem alloc] initWithCustomView:contentViewright2];
    
    self.navigationItem.rightBarButtonItems = @[barButtonItemright1, barButtonItemright2];;
    // Do any additional setup after loading the view.
}

#pragma mark 页面布局
-(void)initview
{
    self.title = @"店铺动态";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    isedit = EnNotSelect; //当前是未选择状态
    isallselect = EnNotSelect;//表示当前 未全选
    selectarray = [[NSMutableArray alloc] init];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf getnewspage:@"1" PageSize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf getnewspage:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
    
    
}

-(UIView *)getcellview:(NSDictionary *)sender Frame:(CGRect)frame IndexPath:(NSIndexPath *)indexpath
{
    UIView *viewcell = [[UIView alloc] initWithFrame:frame];
    
    float orginx = 20;
    
    if(isedit == EnSelectd)
    {
        UIButton *buttonselectitem = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonselectitem.frame = CGRectMake(0, 10, 60, 60);
        [buttonselectitem setImage:LOADIMAGE(@"menotselectgray", @"png") forState:UIControlStateNormal];
        [buttonselectitem addTarget:self action:@selector(selectdynamic:) forControlEvents:UIControlEventTouchUpInside];
        buttonselectitem.tag = EnAttentionSelectItemBtTag+indexpath.row;
        [viewcell addSubview:buttonselectitem];
        orginx = XYViewWidth(buttonselectitem);
    }

    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(orginx, 10, 100, 60)];
    NSString *strpic = [sender objectForKey:@"thumb"];
    [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"tbeatestpic", @"png")];
    [viewcell addSubview:imageview];
    
    NSString *str = [sender objectForKey:@"name"];
    CGSize size = [AddInterface getlablesize:str Fwidth:SCREEN_WIDTH-140 Fheight:40 Sfont:FONTN(15.0f)];
    UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10, XYViewTop(imageview), size.width, size.height)];
    lablename.text =str;
    lablename.font = FONTN(15.0f);
    lablename.textColor = [UIColor blackColor];
    lablename.numberOfLines = 2;
    lablename.backgroundColor = [UIColor clearColor];
    [viewcell addSubview:lablename];
    
    UILabel *labletime = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-130, XYViewBottom(imageview)-18, 130, 18)];
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
    [self getnewspage:@"1" PageSize:@"10"];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
}

-(void)adddeletebotmview
{
    viewbottom = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBarAndNavigationHeight-50, SCREEN_WIDTH, 50)];
    viewbottom.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    imageline.backgroundColor = COLORNOW(220, 220, 220);
    [viewbottom addSubview:imageline];
    
    isallselect = EnNotSelect;
    UIButton *buttonitem = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonitem.titleLabel.font = FONTN(14.0f);
    [buttonitem setTitle:@" 全选" forState:UIControlStateNormal];
    [buttonitem setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
    [buttonitem setImage:LOADIMAGE(@"menotselectgray", @"png") forState:UIControlStateNormal];
    [buttonitem addTarget:self action:@selector(clickselectall:) forControlEvents:UIControlEventTouchUpInside];
    buttonitem.frame = CGRectMake(20, 5, 70,40 );
    [buttonitem setBackgroundColor:[UIColor clearColor]];
    [viewbottom addSubview:buttonitem];
    
    UIButton *buttondelete = [UIButton buttonWithType:UIButtonTypeCustom];
    buttondelete.titleLabel.font = FONTN(14.0f);
    [buttondelete setTitle:@"删除" forState:UIControlStateNormal];
    buttondelete.backgroundColor = [UIColor redColor];
    buttondelete.layer.cornerRadius = 3.0f;
    buttondelete.clipsToBounds = YES;
    [buttondelete addTarget:self action:@selector(deletedynamic:) forControlEvents:UIControlEventTouchUpInside];
    buttondelete.frame = CGRectMake(SCREEN_WIDTH-20-70, 10, 80,30 );
    [viewbottom addSubview:buttondelete];
    
    
    [self.view addSubview:viewbottom];
}

#pragma mark IBAction
-(void)deletedynamic:(id)sender
{
    
}

-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addnewdynamic:(id)sender
{
    MallStoreSendDynamicViewController *senddynamic = [[MallStoreSendDynamicViewController alloc] init];
    senddynamic.delegate1 = self;
    [self.navigationController pushViewController:senddynamic animated:YES];
}

-(void)selectdynamic:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int tagnow = (int)[button tag]-EnAttentionSelectItemBtTag;
    NSDictionary *dicselect = [FCarraydata objectAtIndex:tagnow];
    int flag = 0;
    for(int i=0;i<[selectarray count];i++)
    {
        NSDictionary *dictemp = [selectarray objectAtIndex:i];
        if([[dictemp objectForKey:@"newsid"] isEqualToString:[dicselect objectForKey:@"newsid"]])
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
    [selectarray removeAllObjects];
    FCselectids = @"";
    UIButton *button = (UIButton *)sender;
    if(isedit == EnNotSelect ) //未编辑 状态
    {
        isedit = EnSelectd;
        [self adddeletebotmview];
        [selectarray removeAllObjects];
        [button setTitle:@"完成" forState:UIControlStateNormal];
    }
    else   //当前是完成状态切换成编辑
    {
        isedit = EnNotSelect;
        [viewbottom removeFromSuperview];
        [button setTitle:@"编辑" forState:UIControlStateNormal];
        for(int i=0;i<[selectarray count];i++)
        {
            NSDictionary *dictemp = [selectarray objectAtIndex:i];
            FCselectids = [FCselectids length]==0?[dictemp objectForKey:@"newsid"]:[NSString stringWithFormat:@"%@,%@",FCselectids,[dictemp objectForKey:@"newsid"]];
        }
        if([FCselectids length]>0)
            [self requestdeletedynamic];
    }
    
    [tableview reloadData];
}

-(void)clickselectall:(id)sender
{
    [selectarray removeAllObjects];
    FCselectids = @"";
    UIButton *button = (UIButton *)sender;
    if(isallselect == EnNotSelect)  //未点击全选
    {
        isallselect = EnSelectd;
        [button setImage:LOADIMAGE(@"me默认收货地址", @"png") forState:UIControlStateNormal];
        for(int i=0;i<[FCarraydata count];i++)
        {
            NSDictionary *dicselect = [FCarraydata objectAtIndex:i];
            UIButton *buttonleft = [tableview viewWithTag:EnAttentionSelectItemBtTag+i];
            [buttonleft setImage:LOADIMAGE(@"me默认收货地址", @"png") forState:UIControlStateNormal];
            [selectarray addObject:dicselect];
        }
    }
    else if(isallselect == EnSelectd)  //点击全不选
    {
        isallselect = EnNotSelect;
        for(int i=0;i<[FCarraydata count];i++)
        {
            UIButton *buttonleft = [tableview viewWithTag:EnAttentionSelectItemBtTag+i];
            [buttonleft setImage:LOADIMAGE(@"menotselectgray", @"png") forState:UIControlStateNormal];
        }
        [button setImage:LOADIMAGE(@"menotselectgray", @"png") forState:UIControlStateNormal];
    }
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
    UIView *viewcell = [self getcellview:dictemp Frame:CGRectMake(0, 0, SCREEN_WIDTH, 100) IndexPath:indexPath];
    [cell.contentView addSubview:viewcell];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
//    TbeaNewsDetailViewController *tbeanews = [[TbeaNewsDetailViewController alloc] init];
//    tbeanews.FCnewsid = [dictemp objectForKey:@"id"];
//    [self.navigationController pushViewController:tbeanews animated:YES];
}


#pragma mark 接口
-(void)getnewspage:(NSString *)page PageSize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQStoreLinkActivityListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
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

-(void)requestdeletedynamic
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"newsids"] = FCselectids;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQStoreDeleteDynamicLicCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:app.window];
            [self getnewspage:@"1" PageSize:@"10"];
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
