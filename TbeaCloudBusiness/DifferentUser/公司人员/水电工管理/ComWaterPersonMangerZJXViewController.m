//
//  ComWaterPersonMangerZJXViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/14.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ComWaterPersonMangerZJXViewController.h"

@interface ComWaterPersonMangerZJXViewController ()

@end

@implementation ComWaterPersonMangerZJXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.title = @"总经销选择";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    FCorderitem = @"";
    FCorderid = @"desc";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight-100)];
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    //	[self addtabviewheader];
    [self setExtraCellLineHidden:tableview];
    
    [self getwaterzjxlist:@"1" Pagesize:@"10"];
}

-(void)addtabviewheader
{
    UIView *tabviewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    tabviewheader.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tabviewheader];
    [tabviewheader addSubview:[self getviewselectitem:CGRectMake(0, 0, SCREEN_WIDTH, 40)]];
}


//表头
-(UIView *)getviewselectitem:(CGRect)frame
{
    UIView *viewselectitem = [[UIView alloc] initWithFrame:frame];
    viewselectitem.backgroundColor = [UIColor whiteColor];
    //两根灰线
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.7)];
    line1.backgroundColor = COLORNOW(200, 200, 200);
    [viewselectitem addSubview:line1];
    
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.7)];
    line2.backgroundColor = COLORNOW(200, 200, 200);
    [viewselectitem addSubview:line2];
    
    float widthnow = (SCREEN_WIDTH-20)/4;
    //用户
    ButtonItemLayoutView *buttonstatus = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, XYViewBottom(line1), widthnow, 40)];
//    [buttonstatus.button addTarget:self action:@selector(ClickSelectTime:) forControlEvents:UIControlEventTouchUpInside];
    buttonstatus.tag = EnTixianDataSelectItembt1;
    [buttonstatus updatebuttonitem:EnButtonTextLeft TextStr:@"用户" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:nil];
    [viewselectitem addSubview:buttonstatus];
    

    
    //水电工数量
    ButtonItemLayoutView *buttonitemmoney = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-widthnow, XYViewBottom(line1), widthnow, 40)];
    [buttonitemmoney.button addTarget:self action:@selector(ClickSelectnumber:) forControlEvents:UIControlEventTouchUpInside];
    buttonitemmoney.tag = EnTixianDataSelectItembt3;
    [buttonitemmoney updatebuttonitem:EnButtonTextRight TextStr:@"水电工数量" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    [viewselectitem addSubview:buttonitemmoney];
    
    
    return viewselectitem;
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
}

#pragma mark ActionDelegate
-(void)DGSelectDateDone:(NSString *)starttime EndTime:(NSString *)endtime
{
//    FCsta = starttime;
//    FCenddate = endtime;
//    [self getwaterzjxlist:@"1" Pagesize:@"10"];
}


#pragma mark IBaction
-(void)clickpersonhp:(id)sender
{
    WaterPersonHpInfoViewController *waterperson = [[WaterPersonHpInfoViewController alloc] init];
    [self.navigationController pushViewController:waterperson animated:YES];
}

-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ClickSelectnumber:(id)sender
{
    //排序分
    //金额  从小到大   从大到小
    //数量  从小到大   从大到小
    //远近  从远到近   从近到远
    //激活  已激活  未激活
    FCorderitem = @"money";
    ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnTixianDataSelectItembt3];
    if([FCorderid isEqualToString:@"desc"])
    {
        FCorderid= @"asc";
        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else
    {
        FCorderid= @"desc";
        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
        [buttonitem1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    [self getwaterzjxlist:@"1" Pagesize:@"10"];
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
    return 50;
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
    
    float widthnow = (SCREEN_WIDTH-20)/4;
    
    UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
    NSString *strpic = [dictemp objectForKey:@"thumbpicture"];//[InterfaceResource stringByAppendingString:[[dictemp objectForKey:@"thumbpicture"] length]>0?[dictemp objectForKey:@"thumbpicture"]:@"noimage.png"];
    [imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
    imageheader.contentMode = UIViewContentModeScaleAspectFill;
    imageheader.layer.cornerRadius = 15.0f;
    imageheader.clipsToBounds = YES;
    [cell.contentView addSubview:imageheader];
    
    NSString *strsizename = [dictemp objectForKey:@"mastername"];
    CGSize sizeuser = [AddInterface getlablesize:strsizename Fwidth:100 Fheight:20 Sfont:FONTN(14.0f)];
    UILabel *labelusername = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, 7, sizeuser.width, 20)];
    labelusername.backgroundColor = [UIColor clearColor];
    labelusername.textColor = [UIColor blackColor];
    labelusername.font = FONTB(14.0f);
    labelusername.text = strsizename;
    [cell.contentView addSubview:labelusername];
    
    UILabel *straddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewBottom(labelusername)-2, SCREEN_WIDTH-100, 17)];
    straddr.backgroundColor = [UIColor clearColor];
    straddr.textColor = COLORNOW(117, 117, 117);
    straddr.font = FONTN(12.0f);
    straddr.text = [dictemp objectForKey:@"companyname"];
    [cell.contentView addSubview:straddr];
    
    NSString *strmoney = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"electriciannumber"]];
    CGSize size2 = [AddInterface getlablesize:strmoney Fwidth:widthnow Fheight:20 Sfont:FONTMEDIUM(17.0f)];
    UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-size2.width-10, 10, size2.width, 20)];
    lablemoneyvalue.text =strmoney;
    lablemoneyvalue.font = FONTMEDIUM(17.0f);
    lablemoneyvalue.textColor = [UIColor blackColor];
    lablemoneyvalue.textAlignment = NSTextAlignmentRight;
    lablemoneyvalue.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:lablemoneyvalue];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    WaterPersonMangerViewController *watermanger = [[WaterPersonMangerViewController alloc] init];
    watermanger.FCzjxid = [dictemp objectForKey:@"fdistributorid"];
    [self.navigationController pushViewController:watermanger animated:YES];
}

#pragma mark 接口
//获取列表
-(void)getwaterzjxlist:(NSString *)page Pagesize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"electricianid"] = self.FCelectricianid;

    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQComWaterPersonHpZJXCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"firstleveldistributorlist"];
            [self addtabviewheader];
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
