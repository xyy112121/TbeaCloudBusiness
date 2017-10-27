//
//  MyRebateAccountViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/16.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyRebateAccountViewController.h"

@interface MyRebateAccountViewController ()

@end

@implementation MyRebateAccountViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self getmywalletinfo:@"1" PageSize:@"10"];
    [super viewWillAppear:animated];
    //去除导航栏下方的横线
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
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self initview];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIImage* img=LOADIMAGE(@"returnback", @"png");
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    [button setImage:img forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 44)];
    UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
    [buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonright setTitle:@"收支明细" forState:UIControlStateNormal];
    buttonright.titleLabel.font = FONTN(15.0f);
    [buttonright addTarget:self action: @selector(gotoincomedetail:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright addSubview:buttonright];
    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    self.navigationItem.rightBarButtonItem = barButtonItemright;
    
}

-(void)initview
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.title = @"返利账户";
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    tableview.backgroundColor = [UIColor whiteColor];
    [self setExtraCellLineHidden:tableview];
    [self.view addSubview:tableview];
    
    [self initheader];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData:)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    tableview.mj_header = header;
    
    
}

-(void)initheader
{
    UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260)];
    viewheader.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageviewwallet = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2,20 , 60, 56)];
    imageviewwallet.image = LOADIMAGE(@"me可提现金额", @"png");
    [viewheader addSubview:imageviewwallet];
    
    
    UILabel *labelaccount = [[UILabel alloc] initWithFrame:CGRectMake(30, imageviewwallet.frame.origin.y+imageviewwallet.frame.size.height+10, SCREEN_WIDTH-60, 20)];
    labelaccount.textColor = COLORNOW(21, 21, 21);
    labelaccount.font = FONTN(15.0f);
    labelaccount.text = @"可提现金额";
    labelaccount.textAlignment = NSTextAlignmentCenter;
    [viewheader addSubview:labelaccount];
    
    NSString *strmoney = @"1000";//[NSString stringWithFormat:@"%@",[dic objectForKey:@"totlemoney"]];
    CGSize size = [AddInterface getlablesize:strmoney Fwidth:150 Fheight:20 Sfont:FONTMEDIUM(18.0f)];
    UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-size.width/2, labelaccount.frame.origin.y+labelaccount.frame.size.height+5, size.width, 20)];
    lablemoneyvalue.text = strmoney;
    lablemoneyvalue.font = FONTMEDIUM(18.0f);
    lablemoneyvalue.tag = EnMyKyNowTiXianMoneyLabelTag;
    lablemoneyvalue.textColor = [UIColor blackColor];
    lablemoneyvalue.backgroundColor = [UIColor clearColor];
    [viewheader addSubview:lablemoneyvalue];
    
    UILabel *lablemoneyflag = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablemoneyvalue)-13, XYViewTop(lablemoneyvalue)+4, 10,10)];
    lablemoneyflag.text = @"￥";
    lablemoneyflag.font = FONTMEDIUM(12.0f);
    lablemoneyflag.textColor = [UIColor blackColor];
    lablemoneyflag.backgroundColor = [UIColor clearColor];
    [viewheader addSubview:lablemoneyflag];
    
    
    UIButton *buttontixian = [UIButton buttonWithType:UIButtonTypeCustom];
    buttontixian.titleLabel.font = FONTN(15.0f);
    [buttontixian setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttontixian setTitle:@"提现" forState:UIControlStateNormal];
    buttontixian.layer.cornerRadius = 4.0f;
    buttontixian.clipsToBounds = YES;
    buttontixian.backgroundColor = COLORNOW(0, 170, 238);
    [buttontixian addTarget:self action:@selector(mytixian:) forControlEvents:UIControlEventTouchUpInside];
    buttontixian.frame = CGRectMake(15, lablemoneyvalue.origin.y+lablemoneyvalue.frame.size.height+30, SCREEN_WIDTH-33, 35);
    [viewheader addSubview:buttontixian];
    
    //类型选择
    UIImageView *imageviewbluebg = [[UIImageView alloc] initWithFrame:CGRectMake(0, viewheader.frame.size.height-40, SCREEN_WIDTH, 40)];
    imageviewbluebg.backgroundColor = [UIColor whiteColor];
    [viewheader addSubview:imageviewbluebg];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, XYViewTop(imageviewbluebg), SCREEN_WIDTH, 0.7)];
    imageline.backgroundColor = COLORNOW(220, 220, 220);
    [viewheader addSubview:imageline];
    
    UIImageView *imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, XYViewBottom(imageviewbluebg), SCREEN_WIDTH, 0.7)];
    imageline1.backgroundColor = COLORNOW(220, 220, 220);
    [viewheader addSubview:imageline1];
    
    UILabel *labelcode = [[UILabel alloc] initWithFrame:CGRectMake(15, imageviewbluebg.frame.origin.y+10, SCREEN_WIDTH/2-15, 20)];
    labelcode.textColor = ColorBlackshallow;
    labelcode.font = FONTN(16.0f);
    labelcode.text = @"提现码";
    [viewheader addSubview:labelcode];
    
    UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(labelcode.frame.origin.x+labelcode.frame.size.width, labelcode.frame.origin.y, SCREEN_WIDTH/4, 20)];
    labelprice.textColor = ColorBlackshallow;
    labelprice.font = FONTN(16.0f);
    labelprice.text = @"金额";
    [viewheader addSubview:labelprice];
    
    UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*3-10, labelcode.frame.origin.y, SCREEN_WIDTH/4, 20)];
    labeltime.textColor = ColorBlackshallow;
    labeltime.font = FONTN(16.0f);
    labeltime.text = @"有效期";
    labeltime.textAlignment = NSTextAlignmentRight;
    [viewheader addSubview:labeltime];
    
    
    tableview.tableHeaderView = viewheader;
}



#pragma mark IBaction
-(void)gotoincomedetail:(id)sender
{
    MyInputOutputDetailViewController *myinput = [[MyInputOutputDetailViewController alloc] init];
    [self.navigationController pushViewController:myinput animated:YES];
}

-(void)loadNewData:(id)sender
{
    [self getmywalletinfo:@"1" PageSize:@"10"];
}

-(void)loadMoreData:(id)sender
{
    [self getmywalletinfo:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10]];
}

-(void)myincome:(id)sender
{
//    meincomepay = EnMeIncome;
//    [self getmyincome:@"1" Pagesize:@"10"];
//    
//    UIImageView *imageview = [tableview.tableHeaderView viewWithTag:EnMeWalletImageTag];
//    imageview.frame = CGRectMake(0, imageview.frame.origin.y, imageview.frame.size.width, 10);
}

-(void)mypay:(id)sender
{
//    meincomepay = EnMePay;
//    [self getmypay:@"1" Pagesize:@"10"];
//    UIImageView *imageview = [tableview.tableHeaderView viewWithTag:EnMeWalletImageTag];
//    imageview.frame = CGRectMake(SCREEN_WIDTH/2, imageview.frame.origin.y, imageview.frame.size.width, 10);
}

-(void)mytixian:(id)sender
{
    UILabel *labjifen = [tableview.tableHeaderView viewWithTag:EnMyKyNowTiXianMoneyLabelTag];
    DLog(@"jifen====%@",[labjifen.text substringFromIndex:1]);
    if([[labjifen.text substringFromIndex:1] floatValue] >0)
    {
        MyRebateTianXianViewController *jifen = [[MyRebateTianXianViewController alloc] init];
        [self.navigationController pushViewController:jifen animated:YES];
    }
    else
    {
        [MBProgressHUD showError:@"你没有可以提现的金额" toView:app.window];
    }
}

-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark tabbleview代理
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
    
    UILabel *labelcode = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
    labelcode.textColor = ColorBlackshallow;
    labelcode.font = FONTN(13.0f);
    labelcode.text = [dictemp objectForKey:@"takemoneycode"];
    [cell.contentView addSubview:labelcode];
    
    UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 10, SCREEN_WIDTH/4, 20)];
    labelprice.textColor = ColorBlackshallow;
    labelprice.font = FONTN(13.0f);
    labelprice.text = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"money"]];
    [cell.contentView addSubview:labelprice];
    
    
    UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*3-20, 10, SCREEN_WIDTH/4-5+20, 20)];
    labeltime.textColor = ColorBlackshallow;
    labeltime.font = FONTN(13.0f);
    labeltime.text = [dictemp objectForKey:@"validexpiredtime"];
    [cell.contentView addSubview:labeltime];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
//    MyTixianQRCodeInfoViewController *tixiancode = [[MyTixianQRCodeInfoViewController alloc] init];
//    tixiancode.tixianid = [dictemp objectForKey:@"id"];
//    [self.navigationController pushViewController:tixiancode animated:YES];
    
}

//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
//进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你确定要退出吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
            [self deletewalletcode:[dictemp objectForKey:@"id"] IndexPaht:indexPath];
        }];
        
        // Add the actions.
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        
    }
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark 接口
-(void)deletewalletcode:(NSString *)code IndexPaht:(NSIndexPath *)indexpath
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:code forKey:@"takemoneyqrcodeid"];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQMyTiXianQRRemoveCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            if([[dic objectForKey:@"success"] isEqualToString:@"true"])
            {
                [arraydata removeObjectAtIndex:indexpath.row];
                [tableview reloadData];
            }
            else
            {
                [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
            }
            
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
    }];
    
}


-(void)getmywalletinfo:(NSString *)page PageSize:(NSString *)pagesize
{
    NSDictionary *params = nil;//@{@"takemoneycode":@"08381145920000775299"};
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQMyRebateTianXianMoneyCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            if([[dic objectForKey:@"success"] isEqualToString:@"true"])
            {
                tableview.delegate = self;
                tableview.dataSource = self;
                arraydata = [[NSMutableArray alloc ] initWithArray:[[dic objectForKey:@"data"] objectForKey:@"nottakemoneylist"]];
                [tableview reloadData];
                if([arraydata count]>9)
                {
                    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];
                    tableview.mj_footer = footer;
                }
                UILabel *labjifen = [tableview.tableHeaderView viewWithTag:EnMyKyNowTiXianMoneyLabelTag];
                labjifen.text = [NSString stringWithFormat:@"%@",[[[dic objectForKey:@"data"] objectForKey:@"mymoneyinfo"] objectForKey:@"currentmoney"]];
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


//-(void)getmyincome:(NSString *)page Pagesize:(NSString *)pagesize
//{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:page forKey:@"page"];
//    [params setObject:pagesize forKey:@"pagesize"];
//    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001007000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
//     {
//         
//     }
//                                          Success:^(NSDictionary *dic)
//     {
//         DLog(@"dic====%@",dic);
//         if([[dic objectForKey:@"success"] isEqualToString:@"true"])
//         {
//             dicdata = [dic objectForKey:@"data"];
//             arraydata = [dicdata objectForKey:@"receivelist"];
//             tableview.delegate = self;
//             tableview.dataSource = self;
//             UILabel *labjifen = [tableview.tableHeaderView viewWithTag:EnMeWalletJiFenTag];
//             labjifen.text = [NSString stringWithFormat:@"%@",[[dicdata objectForKey:@"mymoneyinfo"] objectForKey:@"currentmoney"]];
//             //			 [self initheader:[dicdata objectForKey:@"mymoneyinfo"]];
//             [tableview reloadData];
//         }
//         else
//         {
//             [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
//         }
//         [tableview.mj_header endRefreshing];
//         [tableview.mj_footer endRefreshing];
//     }];
//    
//}


//-(void)getmypay:(NSString *)page Pagesize:(NSString *)pagesize
//{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:page forKey:@"page"];
//    [params setObject:pagesize forKey:@"pagesize"];
//    
//    
//    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001008000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
//     {
//         
//     }
//                                          Success:^(NSDictionary *dic)
//     {
//         DLog(@"dic====%@",dic);
//         if([[dic objectForKey:@"success"] isEqualToString:@"true"])
//         {
//             dicdata = [dic objectForKey:@"data"];
//             arraydata = [dicdata objectForKey:@"spentlist"];
//             tableview.delegate = self;
//             tableview.dataSource = self;
//             UILabel *labjifen = [tableview.tableHeaderView viewWithTag:EnMeWalletJiFenTag];
//             labjifen.text = [NSString stringWithFormat:@"%@",[[dicdata objectForKey:@"mymoneyinfo"] objectForKey:@"currentmoney"]];
//             //			 [self initheader:[dicdata objectForKey:@"mymoneyinfo"]];
//             [tableview reloadData];
//         }
//         else
//         {
//             [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
//         }
//         [tableview.mj_header endRefreshing];
//         [tableview.mj_footer endRefreshing];
//     }];
//    
//}

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
