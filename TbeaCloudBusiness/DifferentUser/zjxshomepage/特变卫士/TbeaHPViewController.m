//
//  TbeaHPViewController.m
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/10/23.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "TbeaHPViewController.h"

@interface TbeaHPViewController ()

@end

@implementation TbeaHPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self initview];
    
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
    self.title = @"特变卫士管理";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    enselectitem = EnTbeaHpSelectItemall; //默认选择的用户类型
    FCinterfacecode = @"TBEAYUN004006002000";
    FCorderitemvalue = @"";
    FCorderid = @"desc";
    FCordercode = @"";
    FCorderdate = @"";
    FCorderstatus = @"";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight-80)];
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    [self gettbeatype]; //先获取水电工类型
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self gettbealist:@"1" Pagesize:@"10" InterfaceCode:FCinterfacecode];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf gettbealist:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10] InterfaceCode:FCinterfacecode];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
    
//    [self getwaterlist:@"1" Pagesize:@"10"];
}

-(void)addtabviewheader
{
    tabviewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    tabviewheader.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tabviewheader];
    [tabviewheader addSubview:[self topselectitemview]];
    sortitem = [self viewselectitem:CGRectMake(0, 40, SCREEN_WIDTH, 40)];
    [tabviewheader addSubview:sortitem];
}

-(UIView *)topselectitemview
{
    UIView *viewtop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    for(int i=0;i<[FCarraytbeatype count];i++)
    {
        NSDictionary *dictemp = [FCarraytbeatype objectAtIndex:i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(SCREEN_WIDTH/[FCarraytbeatype count]*i, 0, SCREEN_WIDTH/[FCarraytbeatype count], 40);
        button.titleLabel.font = FONTN(15.0f);
        if(i==0)
            [button setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
        else
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:[dictemp objectForKey:@"name"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clicktbeatype:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = EnTbeaHpViewTypeBtTag+i;
        [viewtop addSubview:button];
    }
    
    
    return viewtop;
}

//表头
-(UIView *)viewselectitem:(CGRect)frame
{
    UIView *viewselectitem = [[UIView alloc] initWithFrame:frame];
    viewselectitem.backgroundColor = [UIColor whiteColor];
    //两根灰线
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.7)];
    line1.backgroundColor = COLORNOW(220, 220, 220);
    [viewselectitem addSubview:line1];
    
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39.3, SCREEN_WIDTH, 0.7)];
    line2.backgroundColor = COLORNOW(220, 220, 220);
    [viewselectitem addSubview:line2];
    
    float widthnow = (SCREEN_WIDTH-20)/11;
    
    //预约编号
    ButtonItemLayoutView *buttonitemcode = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, XYViewBottom(line1), widthnow*6, 40)];
    [buttonitemcode.button addTarget:self action:@selector(ClickSelectcode:) forControlEvents:UIControlEventTouchUpInside];
    buttonitemcode.tag = EnWaterListSelectItembt1;
    [buttonitemcode updatebuttonitem:EnButtonTextLeft TextStr:@"预约编号" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    [viewselectitem addSubview:buttonitemcode];
    
    //状态
    ButtonItemLayoutView *buttonitemstatus = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow*6, XYViewBottom(line1), widthnow*2, 40)];
    [buttonitemstatus.button addTarget:self action:@selector(ClickSelectstatus:) forControlEvents:UIControlEventTouchUpInside];
    buttonitemstatus.tag = EnWaterListSelectItembt2;
    [buttonitemstatus updatebuttonitem:EnButtonTextCenter TextStr:@"状态" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    [viewselectitem addSubview:buttonitemstatus];
    
    //日期
    ButtonItemLayoutView *buttonitemdate = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow*8, XYViewBottom(line1), widthnow*3, 40)];
    [buttonitemdate.button addTarget:self action:@selector(ClickSelectdate:) forControlEvents:UIControlEventTouchUpInside];
    buttonitemdate.tag = EnWaterListSelectItembt3;
    [buttonitemdate updatebuttonitem:EnButtonTextRight TextStr:@"日期" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    [viewselectitem addSubview:buttonitemdate];
    
    if([FCselectitemid isEqualToString:@"assigned"])
    {
        
        [buttonitemcode updatebuttonitem:EnButtonTextLeft TextStr:@"预约编号" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        buttonitemstatus.frame = CGRectMake(10+widthnow*5, XYViewBottom(line1), widthnow*4, 40);
         [buttonitemstatus updatebuttonitem:EnButtonTextCenter TextStr:@"检测人员" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        [buttonitemdate updatebuttonitem:EnButtonTextRight TextStr:@"派单日期" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    }
    else if([FCselectitemid isEqualToString:@"finishedbutneedappraise"])
    {
        [buttonitemcode updatebuttonitem:EnButtonTextLeft TextStr:@"预约编号" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        buttonitemstatus.frame = CGRectMake(10+widthnow*5, XYViewBottom(line1), widthnow*4, 40);
        [buttonitemstatus updatebuttonitem:EnButtonTextCenter TextStr:@"检测人员" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        [buttonitemdate updatebuttonitem:EnButtonTextRight TextStr:@"完工日期" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    }
    else if([FCselectitemid isEqualToString:@"finished"])
    {
        [buttonitemcode updatebuttonitem:EnButtonTextLeft TextStr:@"预约编号" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        buttonitemstatus.frame = CGRectMake(10+widthnow*5, XYViewBottom(line1), widthnow*4, 40);
        [buttonitemstatus updatebuttonitem:EnButtonTextCenter TextStr:@"操作人员" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        [buttonitemdate updatebuttonitem:EnButtonTextRight TextStr:@"上传日期" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    }
    
    return viewselectitem;
}



-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
}

#pragma mark ActionDelegate



#pragma mark IBaction
-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clicktbeatype:(id)sender
{
    UIButton *button =(UIButton *)sender;
    for(int i=0;i<10;i++)
    {
        UIButton *buttontemp = [self.view viewWithTag:EnTbeaHpViewTypeBtTag+i];
        [buttontemp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [button setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
    
    NSDictionary *dictemp = [FCarraytbeatype objectAtIndex:[button tag]-EnTbeaHpViewTypeBtTag];
    FCselectitemid = [dictemp objectForKey:@"id"];
    //all  new  assigned  finishedbutneedappraise  finished
    if([FCselectitemid isEqualToString:@"all"])
    {
        FCinterfacecode = @"TBEAYUN004006002000";
        [self gettbealist:@"1" Pagesize:@"10" InterfaceCode:FCinterfacecode];//全部
    }
    else if([FCselectitemid isEqualToString:@"new"])
    {
        FCinterfacecode = @"TBEAYUN004006003000";
        [self gettbealist:@"1" Pagesize:@"10" InterfaceCode:FCinterfacecode];//待处理
    }
    else if([FCselectitemid isEqualToString:@"assigned"])
    {
        FCinterfacecode = @"TBEAYUN004006004000";
        [self gettbealist:@"1" Pagesize:@"10" InterfaceCode:FCinterfacecode];//已派单
    }
    else if([FCselectitemid isEqualToString:@"finishedbutneedappraise"])
    {
        FCinterfacecode = @"TBEAYUN004006005000";
        [self gettbealist:@"1" Pagesize:@"10" InterfaceCode:FCinterfacecode];//已完工
    }
    else if([FCselectitemid isEqualToString:@"finished"])
    {
        FCinterfacecode = @"TBEAYUN004006006000";
        [self gettbealist:@"1" Pagesize:@"10" InterfaceCode:FCinterfacecode];//已上传
    }
    [sortitem removeFromSuperview];
    sortitem = [self viewselectitem:CGRectMake(0, 40, SCREEN_WIDTH, 40)];
    [tabviewheader addSubview:sortitem];
}

-(void)ClickSelectcode:(id)sender
{
    FCorderitemvalue = @"subscribecode";
    FCorderstatus = @"";
    FCorderdate = @"";
    ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnWaterListSelectItembt1];
    ButtonItemLayoutView *buttonitem2 = [self.view viewWithTag:EnWaterListSelectItembt2];
    ButtonItemLayoutView *buttonitem3 = [self.view viewWithTag:EnWaterListSelectItembt3];
    [buttonitem1 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem2 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem3 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    if([FCordercode isEqualToString:@""])
    {
        FCordercode = @"desc";
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else if([FCordercode isEqualToString:@"desc"])
    {
        FCordercode = @"asc";
        [buttonitem1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else if([FCordercode isEqualToString:@"asc"])
    {
        FCordercode= @"desc";
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    FCorderid = FCordercode;
    [self gettbealist:@"1" Pagesize:@"10" InterfaceCode:FCinterfacecode];
}

-(void)ClickSelectstatus:(id)sender
{
    FCorderitemvalue = @"checkstatus";
    FCordercode = @"";
    FCorderdate = @"";
    ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnWaterListSelectItembt2];
    ButtonItemLayoutView *buttonitem2 = [self.view viewWithTag:EnWaterListSelectItembt1];
    ButtonItemLayoutView *buttonitem3 = [self.view viewWithTag:EnWaterListSelectItembt3];
    [buttonitem1 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem2 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem3 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    if([FCorderstatus isEqualToString:@""])
    {
        FCorderstatus = @"desc";
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else if([FCorderstatus isEqualToString:@"desc"])
    {
        FCorderstatus = @"asc";
        [buttonitem1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else if([FCorderstatus isEqualToString:@"asc"])
    {
        FCorderstatus= @"desc";
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    FCorderid = FCorderstatus;
    [self gettbealist:@"1" Pagesize:@"10" InterfaceCode:FCinterfacecode];
}

-(void)ClickSelectdate:(id)sender
{
    FCorderitemvalue = @"checkstatus";
    FCordercode = @"";
    FCorderstatus = @"";
    ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnWaterListSelectItembt3];
    ButtonItemLayoutView *buttonitem2 = [self.view viewWithTag:EnWaterListSelectItembt2];
    ButtonItemLayoutView *buttonitem3 = [self.view viewWithTag:EnWaterListSelectItembt1];
    [buttonitem1 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem2 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem3 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    if([FCorderdate isEqualToString:@""])
    {
        FCorderdate = @"desc";
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else if([FCorderdate isEqualToString:@"desc"])
    {
        FCorderdate = @"asc";
        [buttonitem1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else if([FCorderdate isEqualToString:@"asc"])
    {
        FCorderdate= @"desc";
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    FCorderid = FCorderdate;
    [self gettbealist:@"1" Pagesize:@"10" InterfaceCode:FCinterfacecode];
    
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
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
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
    
    float widthnow = (SCREEN_WIDTH-20)/11;
    UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, widthnow*6, 20)];
    labeltime.text = [dictemp objectForKey:@"subscribecode"];;
    labeltime.textColor = [UIColor blackColor];
    labeltime.font = FONTN(15.0f);
    labeltime.textAlignment = NSTextAlignmentLeft;
    [cell.contentView addSubview:labeltime];
    
    UILabel *lablearea = [[UILabel alloc] initWithFrame:CGRectMake(10+widthnow*6, 10, widthnow*2,20)];
    lablearea.text = [dictemp objectForKey:@"checkstatus"];
    lablearea.font = FONTN(15.0f);
    lablearea.textColor = [UIColor blackColor];
    lablearea.backgroundColor = [UIColor clearColor];
    lablearea.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:lablearea];
    
    UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-widthnow*3, 10,widthnow*3, 20)];
    lablemoneyvalue.text =[dictemp objectForKey:@"subscribetime"];
    lablemoneyvalue.font = FONTN(15.0f);
    lablemoneyvalue.textColor = [UIColor blackColor];
    lablemoneyvalue.textAlignment = NSTextAlignmentRight;
    lablemoneyvalue.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:lablemoneyvalue];
    
    if([FCselectitemid isEqualToString:@"assigned"])
    {
        lablearea.text = [dictemp objectForKey:@"electricianname"];
        lablemoneyvalue.text = [dictemp objectForKey:@"assigntime"];
    }
    else if([FCselectitemid isEqualToString:@"finishedbutneedappraise"])
    {

    }
    else if([FCselectitemid isEqualToString:@"finished"])
    {

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    if([[dictemp objectForKey:@"checkstatusid"] isEqualToString:@"new"])
    {
        TbeaDaiChuLiDetailViewController *daichuli = [[TbeaDaiChuLiDetailViewController alloc] init];
        daichuli.FCelectricalcheckid = [dictemp objectForKey:@"electricalcheckid"];
        [self.navigationController pushViewController:daichuli animated:YES];
    }
    else if([[dictemp objectForKey:@"checkstatusid"] isEqualToString:@"assigned"])
    {
        TbeaYiPaiDanDetailViewController *yipaidan = [[TbeaYiPaiDanDetailViewController alloc] init];
        yipaidan.FCelectricalcheckid = [dictemp objectForKey:@"electricalcheckid"];
        [self.navigationController pushViewController:yipaidan animated:YES];
    }
}


#pragma mark 接口
-(void)gettbeatype
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQTbeaHpSelectItemTypeCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraytbeatype = [[dic objectForKey:@"data"] objectForKey:@"electricalcheckstatuslist"];
            FCselectitemid = [[FCarraytbeatype objectAtIndex:0] objectForKey:@"id"];
            [self addtabviewheader];
            [self gettbealist:@"1" Pagesize:@"10" InterfaceCode:@"TBEAYUN004006002000"];//全部
        //    FCselectitemid=> all  new  assigned  finishedbutneedappraise  finished
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}

-(void)gettbealist:(NSString *)page Pagesize:(NSString *)pagesize InterfaceCode:(NSString *)interfacecode
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"orderitem"] = FCorderitemvalue;
    params[@"order"] = FCorderid;
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:interfacecode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"electricalchecklist"];
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
        [MBProgressHUD showError:@"请求失败,请检查网络喔" toView:self.view];
        
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
