//
//  MallStoreSalesAccountListViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/9/3.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MallStoreSalesAccountListViewController.h"

@interface MallStoreSalesAccountListViewController ()

@end

@implementation MallStoreSalesAccountListViewController

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
    self.title = @"销售流水";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    FCstartime = @"";
    FCendtime = @"";
    FCorderid = @"desc";
    FCorderitem = @"";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
    tableview.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:tableview];
    [self initviewheader];
    [self setExtraCellLineHidden:tableview];
    
    [self getsalsesaccountlist:@"1" Pagesize:@"10"];
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

-(UIButton *)initbutton:(NSString *)title Frame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    button.titleLabel.font = FONTN(15.0f);
    
    return button;
}

-(void)initviewheader
{
    UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    tableview.tableHeaderView = viewheader;
    
    UILabel *lablemoney = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 70,20)];
    lablemoney.text = @"合计金额";
    lablemoney.font = FONTN(15.0f);
    lablemoney.textColor = COLORNOW(117, 117, 117);
    lablemoney.backgroundColor = [UIColor clearColor];
    [viewheader addSubview:lablemoney];
    
    FClablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 10, 70,20)];
    FClablemoneyvalue.text = @"";
    FClablemoneyvalue.font = FONTN(15.0f);
    FClablemoneyvalue.textColor = COLORNOW(117, 117, 117);
    FClablemoneyvalue.backgroundColor = [UIColor clearColor];
    [viewheader addSubview:FClablemoneyvalue];
    
    FClableallmoneyflag = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(FClablemoneyvalue)-11, XYViewTop(FClablemoneyvalue)+3, 10,10)];
    FClableallmoneyflag.text = @"￥";
    FClableallmoneyflag.font = FONTMEDIUM(10.0f);
    FClableallmoneyflag.textColor = [UIColor redColor];
    FClableallmoneyflag.backgroundColor = [UIColor clearColor];
    [viewheader addSubview:FClableallmoneyflag];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    imageline.backgroundColor = COLORNOW(220, 220, 220);
    [viewheader addSubview:imageline];
    
    UILabel *labletime = [[UILabel alloc] initWithFrame:CGRectMake(20, XYViewBottom(imageline)+10, 70,20)];
    labletime.text = @"时间范围";
    labletime.font = FONTN(15.0f);
    labletime.textColor = COLORNOW(117, 117, 117);
    labletime.backgroundColor = [UIColor clearColor];
    [viewheader addSubview:labletime];
    
    FCtextfield = [[UITextField alloc] initWithFrame:CGRectMake(XYViewR(labletime)+5, XYViewBottom(imageline)+5, SCREEN_WIDTH-40-90, 30)];
    FCtextfield.text = FCselecttime;
    FCtextfield.font = FONTN(15.0f);
    FCtextfield.delegate = self;
    
    FCtextfield.placeholder = @"点击选择时间范围";
    [viewheader addSubview:FCtextfield];
    
    UIImageView *imagearraw = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, XYViewBottom(imageline)+14, 7, 12)];
    imagearraw.image = LOADIMAGE(@"tbeaarrowright", @"png");
    [viewheader addSubview:imagearraw];
    
    UIImageView *imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 79, SCREEN_WIDTH, 1)];
    imageline1.backgroundColor = COLORNOW(220, 220, 220);
    [viewheader addSubview:imageline1];
}


-(UIView *)initcellview:(NSDictionary *)sender Frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    float widthnow = (SCREEN_WIDTH-20-30)/4;
    UIImageView *imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
    NSString *strpic = [sender objectForKey:@"thumbpicture"];
    [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"testpic", @"png")];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    [view addSubview:imageview];
    
    CGSize size = [AddInterface getlablesize:[sender objectForKey:@"commodityname"] Fwidth:widthnow*3-60 Fheight:35 Sfont:FONTN(14.0f)];
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10,XYViewTop(imageview)-2,size.width,size.height)];
    labeltitle.backgroundColor = [UIColor clearColor];
    labeltitle.textColor = [UIColor blackColor];
    labeltitle.font = FONTN(14.0f);
    labeltitle.text = [sender objectForKey:@"commodityname"];
    labeltitle.numberOfLines = 2;
    [view addSubview:labeltitle];
    
    UILabel *labelins = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labeltitle),XYViewBottom(imageview)-25,widthnow*3-90,30)];
    labelins.backgroundColor = [UIColor clearColor];
    labelins.textColor = COLORNOW(117, 117, 117);
    labelins.font = FONTN(12.0f);
    labelins.numberOfLines = 2;
    labelins.text = [NSString stringWithFormat:@"%@",[sender objectForKey:@"promotion"]];
    [view addSubview:labelins];
    
    size = [AddInterface getlablesize:[NSString stringWithFormat:@"%@",[sender objectForKey:@"price"]] Fwidth:widthnow Fheight:20 Sfont:FONTMEDIUM(16.0f)];
    UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30-size.width, 30, size.width, 20)];
    lablemoneyvalue.text = [NSString stringWithFormat:@"%@",[sender objectForKey:@"price"]];
    lablemoneyvalue.font = FONTMEDIUM(16.0f);
    lablemoneyvalue.textColor = [UIColor redColor];
    lablemoneyvalue.backgroundColor = [UIColor clearColor];
    [view addSubview:lablemoneyvalue];
    
    UILabel *lablemoneyflag = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablemoneyvalue)-11, XYViewTop(lablemoneyvalue)+3, 10,10)];
    lablemoneyflag.text = @"￥";
    lablemoneyflag.font = FONTMEDIUM(10.0f);
    lablemoneyflag.textColor = [UIColor redColor];
    lablemoneyflag.backgroundColor = [UIColor clearColor];
    [view addSubview:lablemoneyflag];
    
    UIImageView *imagearraw = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, XYViewTop(lablemoneyvalue)+4, 7, 12)];
    imagearraw.image = LOADIMAGE(@"tbeaarrowright", @"png");
    [view addSubview:imagearraw];
    
    UILabel *labelsalesnum = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30-100,XYViewTop(labelins),100,30)];
    labelsalesnum.backgroundColor = [UIColor clearColor];
    labelsalesnum.textColor = COLORNOW(117, 117, 117);
    labelsalesnum.font = FONTN(12.0f);
    labelsalesnum.textAlignment = NSTextAlignmentRight;
    labelsalesnum.text = [NSString stringWithFormat:@"￥%@x%@",[sender objectForKey:@"price"],[sender objectForKey:@"salenumber"]];
    [view addSubview:labelsalesnum];
    
    UILabel *labeldonetime = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(imageview),XYViewBottom(imageview)+7,100,20)];
    labeldonetime.backgroundColor = [UIColor clearColor];
    labeldonetime.textColor = COLORNOW(117, 117, 117);
    labeldonetime.font = FONTN(12.0f);
    labeldonetime.text = @"完成时间";
    [view addSubview:labeldonetime];
    
    UILabel *labeldonetimevalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-160-15,XYViewTop(labeldonetime),160,20)];
    labeldonetimevalue.backgroundColor = [UIColor clearColor];
    labeldonetimevalue.textColor = COLORNOW(117, 117, 117);
    labeldonetimevalue.font = FONTN(12.0f);
    labeldonetimevalue.textAlignment = NSTextAlignmentRight;
    labeldonetimevalue.text = [sender objectForKey:@"finishtime"];
    [view addSubview:labeldonetimevalue];
    
    return view;
}

#pragma mark Uitextfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField==FCtextfield)
    {
        CustomTimeSelectViewController *timeselect = [[CustomTimeSelectViewController alloc] init];
        timeselect.delegate1 = self;
        timeselect.FCstarttime = FCstartime;
        timeselect.FCendtime = FCendtime;
        timeselect.datemode = DatePickerViewDateMode;
        [self.navigationController pushViewController:timeselect animated:YES];
        return NO;
    }
    return YES;
}

#pragma mark ActionDelege
-(void)DGSelectDateHourSecondDone:(NSString *)starttime EndTime:(NSString *)endtime
{
    DLog(@"starttime====%@,%@",starttime,endtime);
    FCstartime = starttime;
    FCendtime = endtime;
    FCselecttime = [NSString stringWithFormat:@"%@至%@",starttime,endtime];
    FCtextfield.text = FCselecttime;
}

#pragma mark IBAction
-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)selectuser:(id)sender
{
    
}

-(void)selecmoney:(id)sender
{
    
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
    return 105;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [FCarraydata count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableview.frame.size.width,40)];
    view.backgroundColor = [UIColor whiteColor];
    
    
    float widthnow = (SCREEN_WIDTH-20-30)/4;
    
    ButtonItemLayoutView *buttonitemuser = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, 0, widthnow*3, 40)];
    [buttonitemuser.button addTarget:self action:@selector(selectuser:) forControlEvents:UIControlEventTouchUpInside];
    buttonitemuser.tag = EnMallStoreMangerLinkTypeSelectItem4;
    [buttonitemuser updatebuttonitem:EnButtonTextLeft TextStr:@"商品名称" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    [view addSubview:buttonitemuser];
    
    ButtonItemLayoutView *buttonitemmoney = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30-widthnow, 0, widthnow, 40)];
    [buttonitemmoney.button addTarget:self action:@selector(selecmoney:) forControlEvents:UIControlEventTouchUpInside];
    buttonitemmoney.tag = EnMallStoreMangerLinkTypeSelectItem4;
    [buttonitemmoney updatebuttonitem:EnButtonTextRight TextStr:@"销售金额" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    [view addSubview:buttonitemmoney];
    
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
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor whiteColor];

    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    UIView *view = [self initcellview:dictemp Frame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    [cell.contentView addSubview:view];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    MallStoreGoodsSalesDetailViewController *goodsdetail = [[MallStoreGoodsSalesDetailViewController alloc] init];
    goodsdetail.FCcommodityid = [dictemp objectForKey:@"commodityid"];
    [self.navigationController pushViewController:goodsdetail animated:YES];
}

#pragma mark 接口
-(void)getsalsesaccountlist:(NSString *)page Pagesize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"starttime"] = FCstartime;
    params[@"endtime"] = FCendtime;
    params[@"orderitem"] = FCorderitem;
    params[@"order"] = FCorderid;
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQStoreSalesAccountListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"commoditylist"];
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
