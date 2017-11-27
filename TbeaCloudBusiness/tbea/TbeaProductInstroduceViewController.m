//
//  TbeaProductInstroduceViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/14.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "TbeaProductInstroduceViewController.h"

#define TITLES @[@"消息",@"首页",@"分享"]


@interface TbeaProductInstroduceViewController ()

@end

@implementation TbeaProductInstroduceViewController

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
    [buttonright setImage:LOADIMAGE(@"morepointwhite", @"png") forState:UIControlStateNormal];
    [buttonright addTarget:self action: @selector(Clickmorefunction:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright addSubview:buttonright];
    buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    self.navigationItem.rightBarButtonItem = barButtonItemright;
    
    
    // Do any additional setup after loading the view.
}

#pragma mark 页面布局
-(void)initview
{
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    FCname = @"";
    FCspecificationid = @"";  //规格
    FCmodelid= @"";   //型号
    FCorderitem=@"";
    FCorderid=@"desc";
    
    [self getcategorylist];
    
    UIView *view = [self addtabviewheader:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [self.view addSubview:view];
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40)];
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getproductlist:@"1" PageSize:@"10"];
        
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf getproductlist:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
        
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
    
    [self getproductlist:@"1" PageSize:@"10"];
}

-(UIView *)searchbarview
{
    UIView *viewsearch = [[UIView alloc] initWithFrame:CGRectMake(50, 2, SCREEN_WIDTH-100, 40)];
    viewsearch.backgroundColor =[UIColor clearColor];
    viewsearch.tag = EnNctlSearchViewTag;
    SearchTextFieldView *searchtext = [[SearchTextFieldView alloc] initWithFrame:CGRectMake(10, 7, SCREEN_WIDTH-110, 26) Pastr:@"产品搜索"];
    searchtext.delegate1 = self;
    [viewsearch addSubview:searchtext];
    
    return viewsearch;
    
    
}

//表头
-(UIView *)addtabviewheader:(CGRect)frame
{
    UIView *viewselectitem = [[UIView alloc] initWithFrame:frame];
    viewselectitem.backgroundColor = [UIColor whiteColor];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 0.7)];
    line1.backgroundColor = COLORNOW(200, 200, 200);
    [viewselectitem addSubview:line1];
    
    float widthnow = SCREEN_WIDTH/3;
    //规格
    ButtonItemLayoutView *buttonleft = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(0, 0, widthnow, 39)];
    [buttonleft.button addTarget:self action:@selector(ClickSelectleft:) forControlEvents:UIControlEventTouchUpInside];
    buttonleft.tag = EnTbeaProductInstroduceSelect1;
    [buttonleft updatebuttonitem:EnButtonTextCenter TextStr:@"规格" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrowgrayunder", @"png")];
    [viewselectitem addSubview:buttonleft];
    
    //型号
    ButtonItemLayoutView *buttonmiddle = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(widthnow, 0, widthnow, 39)];
    [buttonmiddle.button addTarget:self action:@selector(ClickSelectmiddle:) forControlEvents:UIControlEventTouchUpInside];
    buttonmiddle.tag = EnTbeaProductInstroduceSelect2;
    [buttonmiddle updatebuttonitem:EnButtonTextCenter TextStr:@"型号" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrowgrayunder", @"png")];
    [viewselectitem addSubview:buttonmiddle];
    
    //最新产品
    ButtonItemLayoutView *buttonright = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(widthnow*2, 0, widthnow, 39)];
    [buttonright.button addTarget:self action:@selector(ClickSelectright:) forControlEvents:UIControlEventTouchUpInside];
    buttonright.tag = EnTbeaProductInstroduceSelect3;
    [buttonright updatebuttonitem:EnButtonTextCenter TextStr:@"最新产品" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrowgrayblue", @"png")];
    [viewselectitem addSubview:buttonright];
    
    
    return viewselectitem;
}

-(UIView *)getcellview:(NSDictionary *)sender Frame:(CGRect)frame
{
    UIView *viewcell = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 80, 80)];
    NSString *strpic = [sender objectForKey:@"thumbpicture"];//[NSString stringWithFormat:@"%@%@",InterfaceResource,[[sender objectForKey:@"thumbpicture"] length]>0?[sender objectForKey:@"thumbpicture"]:@"123"];
    [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"testpic", @"png")];
    [viewcell addSubview:imageview];
    
    NSString *str = [sender objectForKey:@"name"];
    CGSize size = [AddInterface getlablesize:str Fwidth:SCREEN_WIDTH-150 Fheight:60 Sfont:FONTN(15.0f)];
    UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10, XYViewTop(imageview), size.width, size.height)];
    lablename.text =str;
    lablename.font = FONTN(15.0f);
    lablename.textColor = [UIColor blackColor];
    lablename.numberOfLines = 2;
    lablename.backgroundColor = [UIColor clearColor];
    [viewcell addSubview:lablename];
    
    UILabel *lablefenlei = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablename), XYViewBottom(imageview)-18, SCREEN_WIDTH-120, 18)];
    lablefenlei.text =[NSString stringWithFormat:@"规格型号:%@",[sender objectForKey:@"modelandspecification"]];
    lablefenlei.font = FONTN(13.0f);
    lablefenlei.textColor = COLORNOW(117, 117, 117);
    lablefenlei.backgroundColor = [UIColor clearColor];
    [viewcell addSubview:lablefenlei];
    
    return viewcell;
}

-(void)viewWillAppear:(BOOL)animated
{
    [[self.navigationController.navigationBar viewWithTag:EnNctlSearchViewTag] removeFromSuperview];
    
    [self.navigationController.navigationBar addSubview:[self searchbarview]];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
}

#pragma mark pop弹出框
- (void)Clickmorefunction:(id)sender
{
    //	UIButton *button = (UIButton *)sender;
    
    NSMutableArray *arrayicons = [[NSMutableArray alloc] init];
    [arrayicons addObject:LOADIMAGE(@"tbeamessageicon", @"png")];
    [arrayicons addObject:LOADIMAGE(@"tbeahpicon", @"png")];
    ybpopmenu = [YBPopupMenu showRelyOnView:sender titles:TITLES icons:arrayicons menuWidth:100 otherSettings:^(YBPopupMenu *popupMenu)
                 {
                     popupMenu.dismissOnSelected = NO;
                     popupMenu.isShowShadow = YES;
                     popupMenu.delegate = self;
                     popupMenu.offset = 5;
                     popupMenu.type = YBPopupMenuTypeDefault;
                     popupMenu.rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight|UIRectCornerAllCorners;
                 }];
    
}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    if([TITLES[index] isEqualToString:@"全部"])
    {
        
    }
    else if([TITLES[index] isEqualToString:@"分销商"])
    {
        
    }
    else
    {
        
    }
    [tableview reloadData];
    [ybpopmenu dismiss];
    NSLog(@"点击了 %@ 选项",TITLES[index]);
}

#pragma mark ActionDelegate
-(void)DGClickselectItemDone:(id)sender
{
    if(selectitem == EnTbeaProductSelectItem1)
    {
        ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnTbeaProductInstroduceSelect1];
        //    [buttonitem updatelabstr:FCspecificationname];
    }
    else if(selectitem == EnTbeaProductSelectItem2)
    {
        ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnTbeaProductInstroduceSelect2];
        //    [buttonitem updatelabstr:FCmodelname];
    }
    [self getproductlist:@"1" PageSize:@"10"];
}
#pragma mark IBAction
-(void)clickmorefunction:(id)sender
{
    
}

-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ClickSelectleft:(id)sender
{
    ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnTbeaProductInstroduceSelect1];
    [buttonitem updatelablecolor:COLORNOW(0, 170, 236)];
    //	[buttonitem updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
    selectitem =EnTbeaProductSelectItem1;
    
    NSMutableArray *arrayspecial = [[NSMutableArray alloc] init];
    for(int i=0;i<[FCarrayspeci count];i++)
    {
        NSDictionary *dictemp = [FCarrayspeci objectAtIndex:i];
        [arrayspecial addObject:[dictemp objectForKey:@"name"]];
    }
    
    [ZJBLStoreShopTypeAlert showWithTitle:@"规格选择" titles:arrayspecial deleGate1:self selectIndex:^(NSInteger selectIndex) {
    } selectValue:^(NSString *selectValue) {
        DLog(@"selectvalue====%@",selectValue);
        FCspecificationname = selectValue;
        FCspecificationid = [AddInterface returnselectid:FCarrayspeci SelectValue:selectValue];
    } showCloseButton:YES];
    
}

-(void)ClickSelectmiddle:(id)sender
{
    ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnTbeaProductInstroduceSelect2];
    [buttonitem updatelablecolor:COLORNOW(0, 170, 236)];
    //	[buttonitem updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
    selectitem =EnTbeaProductSelectItem2;
    
    NSMutableArray *arraymodel = [[NSMutableArray alloc] init];
    for(int i=0;i<[FCarraymodel count];i++)
    {
        NSDictionary *dictemp = [FCarraymodel objectAtIndex:i];
        [arraymodel addObject:[dictemp objectForKey:@"name"]];
    }
    
    [ZJBLStoreShopTypeAlert showWithTitle:@"型号选择" titles:arraymodel deleGate1:self  selectIndex:^(NSInteger selectIndex) {
    } selectValue:^(NSString *selectValue) {
        DLog(@"selectvalue====%@",selectValue);
        FCmodelname = selectValue;
        FCmodelid = [AddInterface returnselectid:FCarraymodel SelectValue:selectValue];
    } showCloseButton:YES];
}

-(void)ClickSelectright:(id)sender
{
    ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnTbeaProductInstroduceSelect3];
    [buttonitem updatelablecolor:COLORNOW(0, 170, 236)];
    if([FCorderid isEqualToString:@"desc"])
    {
        FCorderid = @"asc";
        [buttonitem updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else
    {
        FCorderid = @"desc";
        [buttonitem updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    [self getproductlist:@"1" PageSize:@"10"];
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
    return 100;
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
    TbeaProductDetailViewController *productdetail = [[TbeaProductDetailViewController alloc] init];
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    productdetail.FCdicproduct = dictemp;
    [self.navigationController pushViewController:productdetail animated:YES];
}



#pragma mark 接口
//获取商品类别
-(void)getcategorylist
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"parentcategoryid"] = @"";
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQProductCategoryCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraycategory = [[dic objectForKey:@"data"] objectForKey:@"commoditycategorylist"];
            if([FCarraycategory count]>0)
            {
                NSDictionary *diccate = [FCarraycategory objectAtIndex:0];
                FCcategoryid = [diccate objectForKey:@"id"];
                [self getcspecificationlist];
                [self getmodellist];
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

//获取规格
-(void)getcspecificationlist
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"commoditycategoryid"] = FCcategoryid;
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQRebateModelSelectCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarrayspeci = [[dic objectForKey:@"data"] objectForKey:@"commodityspecificationlist"];

        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}


//获取类型
-(void)getmodellist
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"commoditycategoryid"] = @"";
    params[@"flag"] = @"1";  //扫码返利的时候表示1
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQRebateSpecificationSelect ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraymodel = [[dic objectForKey:@"data"] objectForKey:@"commoditymodellist"];

        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}


-(void)getproductlist:(NSString *)page PageSize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"name"] = FCname;
    params[@"commodityspecificationid"] = FCspecificationid;
    params[@"commoditymodelid"] = FCmodelid;
    params[@"orderitem"] = FCorderitem;
    params[@"order"] = FCorderid;
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQTbeaProductListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
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
