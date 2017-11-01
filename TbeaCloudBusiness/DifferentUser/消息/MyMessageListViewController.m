//
//  MyMessageListViewController.m
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/11/1.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyMessageListViewController.h"

@interface MyMessageListViewController ()

@end

@implementation MyMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initview];
    
    self.title = @"消息列表";
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
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    [self getmymessagelist:@"1" Pagesize:@"10"];
    
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
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
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
    
    UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH-30, 20)];
    labeltime.textColor = ColorBlackGray;
    labeltime.font = FONTN(15.0f);
    labeltime.text = [dictemp objectForKey:@"messagetime"];
    [cell.contentView addSubview:labeltime];
    
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labeltime), XYViewBottom(labeltime), SCREEN_WIDTH-30, 20)];
    labeltitle.textColor = ColorBlackdeep;
    labeltitle.font = FONTN(14.0f);
    labeltitle.text = [dictemp objectForKey:@"title"];
    [cell.contentView addSubview:labeltitle];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
    //    WebViewContentViewController *webviewcontent = [[WebViewContentViewController alloc] init];
    //    webviewcontent.strtitle = [dictemp objectForKey:@"name"];
    //    NSString *str = @"http://www.u-shang.net/enginterface/index.php/Apph5/messagelist?messagecategoryid=";
    //    str = [NSString stringWithFormat:@"%@%@",str,[dictemp objectForKey:@"id"]];
    //    webviewcontent.strnewsurl = str;
    //    [self.navigationController pushViewController:webviewcontent animated:YES];
    
}

#pragma mark IBaction
-(void)loadNewData:(id)sender
{
    [self getmymessagelist:@"1" Pagesize:@"10"];
}

-(void)loadMoreData:(id)sender
{
    [self getmymessagelist:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
}

-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark 接口
-(void)getmymessagelist:(NSString *)page Pagesize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_FCcategoryid forKey:@"categoryid"];
    [params setObject:page forKey:@"page"];
    [params setObject:pagesize forKey:@"pagesize"];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQMessageContentListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            if([[dic objectForKey:@"success"] isEqualToString:@"true"])
            {
                FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"messagelist"];
                tableview.delegate = self;
                tableview.dataSource = self;
                [tableview reloadData];
                if([FCarraydata count]>9)
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
