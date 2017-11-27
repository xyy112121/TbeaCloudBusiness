//
//  MallStoreHasBeenSoldDetailViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/31.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MallStoreHasBeenSoldDetailViewController.h"

@interface MallStoreHasBeenSoldDetailViewController ()

@end

@implementation MallStoreHasBeenSoldDetailViewController

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
    self.title = @"已出售";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
    tableview.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getgoodshasbeensolddetail];
    
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

-(void)initheaderview:(NSDictionary *)sender Frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    tableview.tableHeaderView = view;
    
    UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height-1, SCREEN_WIDTH, 1)];
    imageviewline.backgroundColor = COLORNOW(230, 230, 230);
    [view addSubview:imageviewline];
    
    UIImageView *imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 100, 100)];
    NSString *strpic = [sender objectForKey:@"thumbpicture"];
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
    
    UILabel *lablemoneyflag = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labeltitle), XYViewBottom(imageview)-20, 63,20)];
    lablemoneyflag.text = @"商品价格:";
    lablemoneyflag.font = FONTN(14.0f);
    lablemoneyflag.textColor = COLORNOW(117, 117, 117);
    lablemoneyflag.backgroundColor = [UIColor clearColor];
    [view addSubview:lablemoneyflag];
    
    
    UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(lablemoneyflag), XYViewTop(lablemoneyflag), 150, 20)];
    lablemoneyvalue.text = [NSString stringWithFormat:@"￥%@",[sender objectForKey:@"price"]];
    lablemoneyvalue.font = FONTMEDIUM(14.0f);
    lablemoneyvalue.textColor = [UIColor redColor];
    lablemoneyvalue.backgroundColor = [UIColor clearColor];
    [view addSubview:lablemoneyvalue];
    
    UILabel *labelpingjia = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labeltitle),XYViewTop(lablemoneyvalue)-20,200,20)];
    labelpingjia.backgroundColor = [UIColor clearColor];
    labelpingjia.textColor = COLORNOW(117, 117, 117);
    labelpingjia.font = FONTN(14.0f);
    labelpingjia.text = [NSString stringWithFormat:@"发布时间:%@",[sender objectForKey:@"publishtime"]];
    [view addSubview:labelpingjia];
    
}

-(UIView *)initcellview:(NSDictionary *)sender Frame:(CGRect)frame
{
    float widthnow = (SCREEN_WIDTH-30)/9;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    imageview.layer.cornerRadius = 20;
    NSString *strpic = [sender objectForKey:@"personthumbpicture"];
    [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"testpic", @"png")];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    [view addSubview:imageview];
    
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10,XYViewTop(imageview),80,20)];
    labeltitle.backgroundColor = [UIColor clearColor];
    labeltitle.textColor = [UIColor blackColor];
    labeltitle.font = FONTN(15.0f);
    labeltitle.text = [sender objectForKey:@"personname"];
    [view addSubview:labeltitle];

    UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewL(labeltitle), XYViewBottom(labeltitle)+3, 40, 14)];
    NSString *strpic1 = [sender objectForKey:@"persontypeicon"];
    [imageicon setImageWithURL:[NSURL URLWithString:strpic1] placeholderImage:LOADIMAGE(@"mewater", @"png")];
    [view addSubview:imageicon];
    
    
    UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(10+widthnow*3, 20, widthnow*2, 20)];
    lablemoneyvalue.text = [NSString stringWithFormat:@"x%@",[sender objectForKey:@"buyamount"]];
    lablemoneyvalue.font = FONTMEDIUM(15.0f);
    lablemoneyvalue.textColor = COLORNOW(72, 72, 72);
    lablemoneyvalue.textAlignment = NSTextAlignmentCenter;
    lablemoneyvalue.backgroundColor = [UIColor clearColor];
    [view addSubview:lablemoneyvalue];
    
    UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30-widthnow*4,20,widthnow*4,20)];
    labeltime.backgroundColor = [UIColor clearColor];
    labeltime.textColor = COLORNOW(117, 117, 117);
    labeltime.font = FONTN(14.0f);
    labeltime.textAlignment = NSTextAlignmentRight;
    labeltime.text = [sender objectForKey:@"paytime"];
    [view addSubview:labeltime];
    
    return view;
}

#pragma mark IBAction
-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)selectuser:(id)sender
{
    
}

-(void)selectnum:(id)sender
{
    
}

-(void)selectime:(id)sender
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
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [FCarraydata count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableview.frame.size.width,40)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imagegray = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    imagegray.backgroundColor = COLORNOW(235, 235, 235);
    [view addSubview:imagegray];
    
    float widthnow = (SCREEN_WIDTH-30)/9;
    
    ButtonItemLayoutView *buttonitemuser = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, 10, widthnow*3, 40)];
    [buttonitemuser.button addTarget:self action:@selector(selectuser:) forControlEvents:UIControlEventTouchUpInside];
    buttonitemuser.tag = EnMallStoreMangerLinkTypeSelectItem4;
    [buttonitemuser updatebuttonitem:EnButtonTextCenter TextStr:@"用户" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    [view addSubview:buttonitemuser];
    
    ButtonItemLayoutView *buttonitemnum = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow*3, 10, widthnow*2, 40)];
    [buttonitemnum.button addTarget:self action:@selector(selectnum:) forControlEvents:UIControlEventTouchUpInside];
    buttonitemnum.tag = EnMallStoreMangerLinkTypeSelectItem4;
    [buttonitemnum updatebuttonitem:EnButtonTextCenter TextStr:@"数量" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    [view addSubview:buttonitemnum];

    
    ButtonItemLayoutView *buttonitemmoney = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30-widthnow*4, 10, widthnow*4, 40)];
    [buttonitemmoney.button addTarget:self action:@selector(selectime:) forControlEvents:UIControlEventTouchUpInside];
    buttonitemmoney.tag = EnMallStoreMangerLinkTypeSelectItem4;
    [buttonitemmoney updatebuttonitem:EnButtonTextRight TextStr:@"支付时间" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    [view addSubview:buttonitemmoney];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
    imageline.backgroundColor = COLORNOW(220, 220, 220);
    [view addSubview:imageline];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *reuseIdetify = @"cell";
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    UIView *view = [self initcellview:dictemp Frame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    [cell.contentView addSubview:view];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    //    MallStoreGoodsDetailViewController *goodsdetail = [[MallStoreGoodsDetailViewController alloc] init];
    //    goodsdetail.FCCommodityId = [dictemp objectForKey:@"commodityid"];
    //    [self.navigationController pushViewController:goodsdetail animated:YES];
    
}

#pragma mark 接口
-(void)getgoodshasbeensolddetail
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"commodityid"] = _FCcommodityid;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQStoreGoodsHasBeenSoldDetailInfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCcommdityinfo = [[dic objectForKey:@"data"] objectForKey:@"commodityinfo"];
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"salelist"];
            [self initheaderview:FCcommdityinfo Frame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
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
