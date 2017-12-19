//
//  MallStoreLinkSelectItemPageViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MallStoreLinkSelectItemPageViewController.h"

@interface MallStoreLinkSelectItemPageViewController ()

@end

@implementation MallStoreLinkSelectItemPageViewController

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
    self.title = @"链接页面";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    FCorder = @"desc";
    FCorderid = @"";
    FCorderprice = @"";
    FCordernew = @"";
    FCordersalenum = @"";
    FCorderrecommend = @"";
    FCordertime = @"";
    
    linkselectitem = EnMallStoreLinkSelectCommodity;  //默认店铺商品
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if(linkselectitem == EnMallStoreLinkSelectCommodity)
            [weakSelf getgoodsmanger:@"1" PageSize:@"10"];
        else
            [weakSelf getlinkactivitylist:@"1" PageSize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if(linkselectitem == EnMallStoreLinkSelectCommodity)
            [weakSelf getgoodsmanger:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
        else
            [weakSelf getlinkactivitylist:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
        
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
    
    [self getgoodsmanger:@"1" PageSize:@"10"];
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
    if([title isEqualToString:@"推荐"])
        [button setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
    button.titleLabel.font = FONTN(15.0f);
    
    return button;
}

-(UIView *)viewcellcommdity:(NSDictionary *)sender Frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 100, 100)];
    [imageview setImageWithURL:[NSURL URLWithString:[sender objectForKey:@"thumbpicture"]] placeholderImage:LOADIMAGE(@"testpic", @"png")];
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
    
    UILabel *labelpingjia = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10,XYViewTop(lablemoneyvalue)-20,120,20)];
    labelpingjia.backgroundColor = [UIColor clearColor];
    labelpingjia.textColor = COLORNOW(117, 117, 117);
    labelpingjia.font = FONTN(13.0f);
    labelpingjia.text = [NSString stringWithFormat:@"%@评价",[sender objectForKey:@"evaluatenumber"]];
    [view addSubview:labelpingjia];
    
    return view;
}

-(UIView *)viewcellactivity:(NSDictionary *)sender Frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 120, 80)];
    [imageview setImageWithURL:[NSURL URLWithString:[sender objectForKey:@"thumbpicture"]] placeholderImage:LOADIMAGE(@"testpic", @"png")];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    [view addSubview:imageview];
    
    CGSize size = [AddInterface getlablesize:[sender objectForKey:@"name"] Fwidth:SCREEN_WIDTH-160 Fheight:40 Sfont:FONTN(15.0f)];
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10,XYViewTop(imageview),size.width,size.height)];
    labeltitle.backgroundColor = [UIColor clearColor];
    labeltitle.textColor = [UIColor blackColor];
    labeltitle.font = FONTN(15.0f);
    labeltitle.text = [sender objectForKey:@"name"];
    labeltitle.numberOfLines = 2;
    [view addSubview:labeltitle];

    UILabel *labelpingjia = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labeltitle),XYViewBottom(imageview)-20,140,20)];
    labelpingjia.backgroundColor = [UIColor clearColor];
    labelpingjia.textColor = COLORNOW(117, 117, 117);
    labelpingjia.font = FONTN(13.0f);
    labelpingjia.text = [sender objectForKey:@"time"];
    [view addSubview:labelpingjia];
    
    return view;
}

#pragma mark 弹窗求
-(void)clickselecttype
{
    NSArray *usertypes = @[@"店铺商品",@"店铺动态"];
    [ZJBLStoreShopTypeAlert showWithTitle:@"类型选择" titles:usertypes deleGate1:self selectIndex:^(NSInteger selectIndex) {
    } selectValue:^(NSString *selectValue) {
        DLog(@"selectvalue====%@",selectValue);
        if([selectValue isEqualToString:@"店铺商品"])
        {
            linkselectitem = EnMallStoreLinkSelectCommodity;
            [self getgoodsmanger:@"1" PageSize:@"10"];
        }
        else
        {
            linkselectitem = EnMallStoreLinkSelectActivity;
            [self getlinkactivitylist:@"1" PageSize:@"10"];
        }
        UITextField *textfield = [self.view viewWithTag:EnMallStoreLinkTypeSelectValue];
        textfield.text = selectValue;
    } showCloseButton:YES];
}


#pragma mark IBAction
-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickselectitem:(id)sender
{
    ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnMallStoreMangerLinkTypeSelectItem2];
    ButtonItemLayoutView *buttonitem2 = [self.view viewWithTag:EnMallStoreMangerLinkTypeSelectItem3];
    ButtonItemLayoutView *buttonitem3 = [self.view viewWithTag:EnMallStoreMangerLinkTypeSelectItem4];
    [buttonitem1 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem2 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem3 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    FCorderprice = @"";
    FCordersalenum = @"";
    FCordernew = @"";
    UIButton *button = (UIButton *)sender;
    int tagnow = (int)[button tag];
    switch (tagnow)
    {
        case EnMallStoreMangerLinkTypeSelectItem1:
            FCorderid = @"";

//            [button setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
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
    ButtonItemLayoutView *buttonitem2 = [self.view viewWithTag:EnMallStoreMangerLinkTypeSelectItem2];
    ButtonItemLayoutView *buttonitem3 = [self.view viewWithTag:EnMallStoreMangerLinkTypeSelectItem3];
    [buttonitem2 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem3 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    FCorderrecommend = @"";
    FCordersalenum = @"";
    FCordernew = @"";
    FCordertime = @"";
    FCorderid = @"price";
    if([FCorderprice isEqualToString:@""])
    {
        FCorderprice = @"desc";
        [buttonitem updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else if([FCorderprice isEqualToString:@"desc"])
    {
        FCorderprice = @"asc";
        
        [buttonitem updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else
    {
        FCorderprice = @"desc";
        [buttonitem updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    FCorder = FCorderprice;
    [self getgoodsmanger:@"1" PageSize:@"10"];
}

-(void)selectnew:(id)sender
{
    ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnMallStoreMangerLinkTypeSelectItem3];
    ButtonItemLayoutView *buttonitem2 = [self.view viewWithTag:EnMallStoreMangerLinkTypeSelectItem2];
    ButtonItemLayoutView *buttonitem3 = [self.view viewWithTag:EnMallStoreMangerLinkTypeSelectItem4];
    [buttonitem2 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem3 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    FCorderprice = @"";
    FCorderrecommend = @"";
    FCordersalenum = @"";
    FCorderid = @"time";
    if([FCordernew isEqualToString:@""])
    {
        FCordernew = @"desc";
        [buttonitem updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else if([FCordernew isEqualToString:@"desc"])
    {
        FCordernew = @"asc";
        
        [buttonitem updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else
    {
        FCordernew = @"desc";
        [buttonitem updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    FCorder = FCordernew;
    [self getgoodsmanger:@"1" PageSize:@"10"];
}

-(void)selectsalenum:(id)sender
{
    ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnMallStoreMangerLinkTypeSelectItem2];
    ButtonItemLayoutView *buttonitem2 = [self.view viewWithTag:EnMallStoreMangerLinkTypeSelectItem3];
    ButtonItemLayoutView *buttonitem3 = [self.view viewWithTag:EnMallStoreMangerLinkTypeSelectItem4];
    [buttonitem2 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem3 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    FCorderprice = @"";
    FCorderrecommend = @"";
    FCordernew = @"";
    FCorderid = @"salenumber";
    if([FCordersalenum isEqualToString:@""])
    {
        FCordersalenum = @"desc";
        [buttonitem updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else if([FCordersalenum isEqualToString:@"desc"])
    {
        FCordersalenum = @"asc";
        
        [buttonitem updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else
    {
        FCordersalenum = @"desc";
        [buttonitem updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    FCorder = FCordersalenum;
    [self getgoodsmanger:@"1" PageSize:@"10"];
}

-(void)selecttime:(id)sender
{
    ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnMallStoreMangerLinkTypeSelectItem5];
    FCorderid = @"time";
    if([FCordertime isEqualToString:@""])
    {
        FCordertime = @"desc";
        [buttonitem updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else if([FCordertime isEqualToString:@"desc"])
    {
        FCordertime = @"asc";
        [buttonitem updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else
    {
        FCordertime = @"desc";
        [buttonitem updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    FCorder = FCordertime;
    [self getlinkactivitylist:@"1" PageSize:@"10"];
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
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        return 45;
    if(linkselectitem == EnMallStoreLinkSelectCommodity)
        return 120;
    else
        return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 1)
        return [FCarraydata count];
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return nil;
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableview.frame.size.width,40)];
//    view.backgroundColor = [UIColor clearColor];
    
    if(linkselectitem == EnMallStoreLinkSelectCommodity)
    {
        viewActivity = nil;
        if(viewCommodity == nil)
        {
            FCorderprice = @"";
            FCorderrecommend = @"";
            FCordersalenum = @"";
            FCordernew = @"";
            FCordertime = @"";
            
            viewCommodity = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableview.frame.size.width,40)];
            viewCommodity.backgroundColor = [UIColor whiteColor];
            
            UIButton *button1 = [self initbutton:@"推荐" Frame:CGRectMake(0,0,SCREEN_WIDTH/4,40)];
            [button1 addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
            button1.tag = EnMallStoreMangerLinkTypeSelectItem1;
            [viewCommodity addSubview:button1];
            
            ButtonItemLayoutView *buttonitemsalenum = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4,0,SCREEN_WIDTH/4,40)];
            [buttonitemsalenum.button addTarget:self action:@selector(selectsalenum:) forControlEvents:UIControlEventTouchUpInside];
            buttonitemsalenum.tag = EnMallStoreMangerLinkTypeSelectItem2;
            [buttonitemsalenum updatebuttonitem:EnButtonTextCenter TextStr:@"销量" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
            [viewCommodity addSubview:buttonitemsalenum];
            
            
            ButtonItemLayoutView *buttonitemnew = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*2,0,SCREEN_WIDTH/4,40)];
            [buttonitemnew.button addTarget:self action:@selector(selectnew:) forControlEvents:UIControlEventTouchUpInside];
            buttonitemnew.tag = EnMallStoreMangerLinkTypeSelectItem3;
            [buttonitemnew updatebuttonitem:EnButtonTextCenter TextStr:@"新品" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
            [viewCommodity addSubview:buttonitemnew];
            
            
            ButtonItemLayoutView *buttonitemmoney = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*3, 0, SCREEN_WIDTH/4, 40)];
            [buttonitemmoney.button addTarget:self action:@selector(selectprice:) forControlEvents:UIControlEventTouchUpInside];
            buttonitemmoney.tag = EnMallStoreMangerLinkTypeSelectItem4;
            [buttonitemmoney updatebuttonitem:EnButtonTextCenter TextStr:@"价格" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
            [viewCommodity addSubview:buttonitemmoney];
            
            UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 0.7)];
            imageline.backgroundColor = COLORNOW(220, 220, 220);
            [viewCommodity addSubview:imageline];
        }
        return viewCommodity;
    }
    else
    {
        viewCommodity = nil;
        if(viewActivity == nil)
        {
            FCorderprice = @"";
            FCorderrecommend = @"";
            FCordersalenum = @"";
            FCordernew = @"";
            FCordertime = @"";
            
            viewActivity = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableview.frame.size.width,40)];
            viewActivity.backgroundColor = [UIColor whiteColor];
            
            ButtonItemLayoutView *buttonitemmoney = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, 0, (SCREEN_WIDTH-20)/4, 40)];
            [buttonitemmoney.button addTarget:self action:@selector(selecttime:) forControlEvents:UIControlEventTouchUpInside];
            buttonitemmoney.tag = EnMallStoreMangerLinkTypeSelectItem5;
            [buttonitemmoney updatebuttonitem:EnButtonTextCenter TextStr:@"发布时间" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
            [viewActivity addSubview:buttonitemmoney];
            
            UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 0.7)];
            imageline.backgroundColor = COLORNOW(220, 220, 220);
            [viewActivity addSubview:imageline];
        }
        return viewActivity;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
        return 0.1;
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
    
    if(indexPath.section == 0)
    {
        cell.backgroundColor = COLORNOW(230, 230, 230);
        
        UIImageView *imageviewbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        imageviewbg.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:imageviewbg];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, 20)];
        labelname.backgroundColor = [UIColor clearColor];
        labelname.textColor = COLORNOW(117, 117, 117);
        labelname.font = FONTN(15.0f);
        labelname.text = @"类型选择";
        [cell.contentView addSubview:labelname];
        
        UILabel *labelnamevalue = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-70, 20)];
        labelnamevalue.backgroundColor = [UIColor clearColor];
        labelnamevalue.textColor = [UIColor blackColor];
        labelnamevalue.font = FONTN(16.0f);
        if(linkselectitem == EnMallStoreLinkSelectCommodity)
        {
            labelnamevalue.text = @"店铺商品";
        }
        else
            labelnamevalue.text = @"店铺动态";
        labelnamevalue.tag = EnMallStoreLinkTypeSelectValue;
        [cell.contentView addSubview:labelnamevalue];
    }
    else
    {
        NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
        if(linkselectitem == EnMallStoreLinkSelectCommodity)
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell.contentView addSubview:[self viewcellcommdity:dictemp Frame:CGRectMake(0, 0, 0, 120)]];
        }
        else if(linkselectitem == EnMallStoreLinkSelectActivity)
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell.contentView addSubview:[self viewcellactivity:dictemp Frame:CGRectMake(0, 0, 0, 100)]];
        }
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        [self clickselecttype];
    }
    else
    {
        NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
        if([self.delegate1 respondsToSelector:@selector(DGSlectLinkSelectItemDong:SelectItem:)])
        {
            [self.delegate1 DGSlectLinkSelectItemDong:linkselectitem SelectItem:dictemp];
        }
        [self.navigationController popViewControllerAnimated:YES];
    //    MallStoreTurnDoneViewController *turndone = [[MallStoreTurnDoneViewController alloc] init];
    //    [self.navigationController pushViewController:turndone animated:YES];
    }
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


-(void)getlinkactivitylist:(NSString *)page PageSize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"orderitem"] = FCorderid;
    params[@"order"] = FCorder;
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQStoreLinkActivityListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"newslist"];
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
