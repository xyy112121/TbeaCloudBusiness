//
//  MallStoreGoodsMangerViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/28.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MallStoreGoodsMangerViewController.h"

@interface MallStoreGoodsMangerViewController ()

@end

@implementation MallStoreGoodsMangerViewController

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
    
    UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
    [buttonright setTitle:@"添加" forState:UIControlStateNormal];
    buttonright.titleLabel.font = FONTN(15.0f);
    [buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonright addTarget:self action: @selector(ClickAdd:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright addSubview:buttonright];
    buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    self.navigationItem.rightBarButtonItem = barButtonItemright;
    
    // Do any additional setup after loading the view.
}

#pragma mark 页面布局
-(void)initview
{
    self.title = @"商品管理";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    FCorderid = @"";
    FCorder = @"desc";
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getgoodsmanger:@"1" PageSize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getgoodsmanger:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
    
    
    
    [self setviewfoot];
    
}

-(void)setviewfoot
{
    UIView *viewfoot = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-50, SCREEN_WIDTH, 50)];
    viewfoot.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewfoot];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    imageline.backgroundColor = COLORNOW(235, 235, 235);
    [viewfoot addSubview:imageline];
    
    FCButtonnumber = [UIButton buttonWithType:UIButtonTypeCustom];
    FCButtonnumber.frame =CGRectMake(SCREEN_WIDTH-130, 8, 120, 34);
    FCButtonnumber.layer.cornerRadius = 3.0f;
    FCButtonnumber.clipsToBounds = YES;
    FCButtonnumber.layer.borderColor = COLORNOW(236, 108, 101).CGColor;
    FCButtonnumber.layer.borderWidth = 1.0f;
    [FCButtonnumber setTitleColor:COLORNOW(236, 108, 101) forState:UIControlStateNormal];
    FCButtonnumber.titleLabel.font = FONTN(15.0f);
    [viewfoot addSubview:FCButtonnumber];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getgoodsmanger:@"1" PageSize:@"10"];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
}

-(UIButton *)initbutton:(NSString *)title Frame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];


    button.titleLabel.font = FONTN(15.0f);
    
    return button;
}

-(UIView *)viewcellcommdity:(NSDictionary *)sender Frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 100, 100)];
    NSString *strpic = [sender objectForKey:@"thumbpicture"];
//    strpic = [InterfaceResource stringByAppendingString:[strpic length]>0?strpic:@"noimage.png"];
    [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"testpic", @"png")];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    [view addSubview:imageview];
    
    CGSize size = [AddInterface getlablesize:[sender objectForKey:@"commodityname"] Fwidth:SCREEN_WIDTH-140 Fheight:40 Sfont:FONTN(15.0f)];
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10,XYViewTop(imageview),size.width,size.height)];
    labeltitle.backgroundColor = [UIColor clearColor];
    labeltitle.textColor = [UIColor blackColor];
    labeltitle.font = FONTN(15.0f);
    labeltitle.text = [sender objectForKey:@"commodityname"];
    labeltitle.numberOfLines = 2;
    [view addSubview:labeltitle];
    
    UILabel *lablemoneyflag = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labeltitle), XYViewBottom(imageview)-16, 10,10)];
    lablemoneyflag.text = @"￥";
    lablemoneyflag.font = FONTMEDIUM(12.0f);
    lablemoneyflag.textColor = [UIColor redColor];
    lablemoneyflag.backgroundColor = [UIColor clearColor];
    [view addSubview:lablemoneyflag];
    
    size = [AddInterface getlablesize:[NSString stringWithFormat:@"%@",[sender objectForKey:@"price"]] Fwidth:150 Fheight:20 Sfont:FONTMEDIUM(17.0f)];
    UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(lablemoneyflag)+1, XYViewBottom(imageview)-20, size.width, 20)];
    lablemoneyvalue.text = [NSString stringWithFormat:@"%@",[sender objectForKey:@"price"]];
    lablemoneyvalue.font = FONTMEDIUM(17.0f);
    lablemoneyvalue.textColor = [UIColor redColor];
    lablemoneyvalue.backgroundColor = [UIColor clearColor];
    [view addSubview:lablemoneyvalue];
    
    UILabel *labelpingjia = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10,XYViewTop(lablemoneyvalue)-23,120,20)];
    labelpingjia.backgroundColor = [UIColor clearColor];
    labelpingjia.textColor = COLORNOW(117, 117, 117);
    labelpingjia.font = FONTN(13.0f);
    labelpingjia.text = [NSString stringWithFormat:@"%@评价",[sender objectForKey:@"evaluatenumber"]];
    [view addSubview:labelpingjia];
    
    return view;
}

#pragma mark IBAction
-(void)ClickAdd:(id)sender
{
    MallStoreAddNewGoodsViewController *addnew = [[MallStoreAddNewGoodsViewController alloc] init];
    [self.navigationController pushViewController:addnew animated:YES];
}

-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickselectitem:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int tagnow = (int)[button tag];
    switch (tagnow)
    {
        case EnMallStoreMangerLinkTypeSelectItem1:
            FCorderid = @"";
            [button setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
            break;
        case EnMallStoreMangerLinkTypeSelectItem2:
            FCorderid = @"salenumber";
            [button setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
            break;
        case EnMallStoreMangerLinkTypeSelectItem3:
            FCorderid = @"time";
            
            [button setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
            break;
            
    }
    [self getgoodsmanger:@"1" PageSize:@"10"];
}

-(void)selectprice:(id)sender
{
    ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnMallStoreMangerLinkTypeSelectItem4];
    [buttonitem updatelablecolor:COLORNOW(0, 170, 236)];
    if([FCorderid isEqualToString:@"desc"])
    {
        FCorder = @"asc";
        FCorderid = @"price";
        [buttonitem updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else
    {
        FCorder = @"desc";
        FCorderid = @"price";
        [buttonitem updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
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
    return 120;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [FCarraydata count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableview.frame.size.width,40)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button1 = [self initbutton:@"推荐" Frame:CGRectMake(0,0,SCREEN_WIDTH/4,40)];
    [button1 addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag = EnMallStoreMangerLinkTypeSelectItem1;
    [view addSubview:button1];
    if([FCorderid isEqualToString:@""])
        [button1 setTitleColor:COLORNOW(0, 170, 236) forState:UIControlStateNormal];
    
    UIButton *button2 = [self initbutton:@"销量" Frame:CGRectMake(SCREEN_WIDTH/4,0,SCREEN_WIDTH/4,40)];
    [button2 addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag = EnMallStoreMangerLinkTypeSelectItem2;
    [view addSubview:button2];
    if([FCorderid isEqualToString:@"salenumber"])
        [button2 setTitleColor:COLORNOW(0, 170, 236) forState:UIControlStateNormal];
    
    UIButton *button3 = [self initbutton:@"新品" Frame:CGRectMake(SCREEN_WIDTH/4*2,0,SCREEN_WIDTH/4,40)];
    [button3 addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
    button3.tag = EnMallStoreMangerLinkTypeSelectItem3;
    [view addSubview:button3];
    if([FCorderid isEqualToString:@"time"])
        [button3 setTitleColor:COLORNOW(0, 170, 236) forState:UIControlStateNormal];
    
    ButtonItemLayoutView *buttonitemmoney = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*3, 0, SCREEN_WIDTH/4, 40)];
    [buttonitemmoney.button addTarget:self action:@selector(selectprice:) forControlEvents:UIControlEventTouchUpInside];
    buttonitemmoney.tag = EnMallStoreMangerLinkTypeSelectItem4;
    [buttonitemmoney updatebuttonitem:EnButtonTextCenter TextStr:@"价格" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    [view addSubview:buttonitemmoney];
    if([FCorderid isEqualToString:@"price"])
        [buttonitemmoney updatelablecolor:COLORNOW(0, 170, 236)];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    imageline.backgroundColor = COLORNOW(220, 220, 220);
    [view addSubview:imageline];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *reuseIdetify = @"cell";
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell.contentView addSubview:[self viewcellcommdity:dictemp Frame:CGRectMake(0, 0, 0, 40)]];

    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    MallStoreSaleDetailViewController *goodsdetail = [[MallStoreSaleDetailViewController alloc] init];
    goodsdetail.FCcommodityid = [dictemp objectForKey:@"commodityid"];
    [self.navigationController pushViewController:goodsdetail animated:YES];
}

#pragma mark 接口
-(void)getgoodsmanger:(NSString *)page PageSize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"orderitem"] = FCorderid;
    params[@"order"] = FCorder;
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQStoreGoodsMangerListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"commoditylist"];
            FCtotlecommoditynumber = [[[dic objectForKey:@"data"] objectForKey:@"totleinfo"] objectForKey:@"totlecommoditynumber"];
            [FCButtonnumber setTitle:[NSString stringWithFormat:@"商品数量:%@",FCtotlecommoditynumber] forState:UIControlStateNormal];
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
