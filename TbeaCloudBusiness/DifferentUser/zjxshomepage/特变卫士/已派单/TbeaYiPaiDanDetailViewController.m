//
//  TbeaYiPaiDanDetailViewController.m
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/10/24.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "TbeaYiPaiDanDetailViewController.h"

@interface TbeaYiPaiDanDetailViewController ()

@end

@implementation TbeaYiPaiDanDetailViewController

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
    self.title = @"派单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    [self getpaidandetailinfo];
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

-(void)viewcell1:(NSDictionary *)dic FromCell:(UITableViewCell *)fromcell LeftName:(NSString *)leftname
{
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 80, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = COLORNOW(117, 117, 117);
    labelname.font = FONTN(15.0f);
    labelname.text = leftname;
    [fromcell.contentView addSubview:labelname];
    
    UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelname)+10, 10, 30, 30)];
    NSString *strpic = [dic objectForKey:@"thumbpicture"];//[InterfaceResource stringByAppendingString:[[dic objectForKey:@"thumbpicture"] length]>0?[dic objectForKey:@"thumbpicture"]:@"noimage.png"];
    [imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
    imageheader.contentMode = UIViewContentModeScaleAspectFill;
    
    imageheader.layer.cornerRadius = 15.0f;
    imageheader.clipsToBounds = YES;
    [fromcell.contentView addSubview:imageheader];
    
    CGSize sizeuser = [AddInterface getlablesize:[dic objectForKey:@"personname"] Fwidth:100 Fheight:20 Sfont:FONTN(14.0f)];
    UILabel *labelusername = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, 7, sizeuser.width, 20)];
    labelusername.backgroundColor = [UIColor clearColor];
    labelusername.textColor = [UIColor blackColor];
    labelusername.font = FONTN(14.0f);
    labelusername.text = [dic objectForKey:@"personname"];
    [fromcell.contentView addSubview:labelusername];
    
    UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelusername)+5, XYViewTop(labelusername)+5, 10, 10)];
    strpic = [dic objectForKey:@"persontypeicon"];//[InterfaceResource stringByAppendingString:[[dic objectForKey:@"persontypeicon"] length]>0?[dic objectForKey:@"persontypeicon"]:@"noimage.png"];
    [imageicon setImageWithURL:[NSURL URLWithString:strpic]];
    [fromcell.contentView addSubview:imageicon];
    
    UILabel *straddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewBottom(labelusername)-2, SCREEN_WIDTH-100, 17)];
    straddr.backgroundColor = [UIColor clearColor];
    straddr.textColor = COLORNOW(117, 117, 117);
    straddr.font = FONTN(12.0f);
    straddr.text = [dic objectForKey:@"companyname"];
    [fromcell.contentView addSubview:straddr];
}

#pragma mark IBaction
-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
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
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if((indexPath.section == 0)&&(indexPath.row == 0))
        return 50;
    else if((indexPath.section == 1)&&(indexPath.row == 6))
        return 60;
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *strelecid = [[FCdicdata objectForKey:@"electricalcheckinfo"] objectForKey:@"electricalcheckstatusid"];
    if([strelecid isEqualToString:@"accepted"]||[strelecid isEqualToString:@"finishedbutneedappraise"])
    {
        if(section == 0)
            return 4;
    }
    else
    {
        if(section == 0)
            return 3;
        else if(section == 1)
            return 7;
    }
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 1;
    return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    viewheader.backgroundColor = COLORNOW(235, 235, 235);
    
    return viewheader;
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
    
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = COLORNOW(117, 117, 117);
    labelname.font = FONTN(15.0f);
    
    
    UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(labelname)+10, 10, SCREEN_WIDTH-100, 20)];
    labelvalue.backgroundColor = [UIColor clearColor];
    labelvalue.textColor = [UIColor blackColor];
    labelvalue.font = FONTN(15.0f);
    
    UIImageView *imageheader;
    UILabel *labelusername;
    UILabel *labeldes;
    NSString *strpic;
    CGSize size;
    NSString *strelecid = [[FCdicdata objectForKey:@"electricalcheckinfo"] objectForKey:@"electricalcheckstatusid"];
    
    if(indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                labelname.text = @"检测人员";
                labelname.frame = CGRectMake(20, 15, 80, 20);
                [cell.contentView addSubview:labelname];
                
                imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelname)+10, 10, 30, 30)];
                strpic = [[FCdicdata objectForKey:@"assigninfo"] objectForKey:@"thumbpicture"];
                [imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
                imageheader.contentMode = UIViewContentModeScaleAspectFill;
                imageheader.layer.cornerRadius = 15.0f;
                imageheader.clipsToBounds = YES;
                [cell.contentView addSubview:imageheader];

                labelusername = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewTop(imageheader)-3, 100, 18)];
                labelusername.backgroundColor = [UIColor clearColor];
                labelusername.textColor = [UIColor blackColor];
                labelusername.font = FONTN(15.0f);
                labelusername.text = [[FCdicdata objectForKey:@"assigninfo"] objectForKey:@"name"];
                [cell.contentView addSubview:labelusername];

                labeldes = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelusername), XYViewBottom(labelusername), 200, 20)];
                labeldes.backgroundColor = [UIColor clearColor];
                labeldes.textColor = COLORNOW(129, 129, 129);
                labeldes.font = FONTN(15.0f);
                labeldes.text = [[FCdicdata objectForKey:@"assigninfo"] objectForKey:@"info"];
                [cell.contentView addSubview:labeldes];
                break;
            case 1:
                labelname.text = @"派单日期";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [[FCdicdata objectForKey:@"assigninfo"] objectForKey:@"assigntime"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 2:
                labelname.text = @"状态";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [[FCdicdata objectForKey:@"electricalcheckinfo"] objectForKey:@"electricalcheckstatus"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 3:
                if([strelecid isEqualToString:@"accepted"])
                {
                    labelname.text = @"接单日期";
                    [cell.contentView addSubview:labelname];
                    
                    labelvalue.text = [[FCdicdata objectForKey:@"electricalcheckinfo"] objectForKey:@"subscribetime"];
                    [cell.contentView addSubview:labelvalue];
                }
                else if([strelecid isEqualToString:@"finishedbutneedappraise"])
                {
                    labelname.text = @"上传日期";
                    [cell.contentView addSubview:labelname];
                    
                    labelvalue.text = [[FCdicdata objectForKey:@"electricalcheckinfo"] objectForKey:@"subscribetime"];
                    [cell.contentView addSubview:labelvalue];
                }
                break;
        }
    }
    else if(indexPath.section == 1)
    {
        switch (indexPath.row)
        {
            case 0:
                labelname.text = @"预约用户";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [[FCdicdata objectForKey:@"electricalcheckinfo"] objectForKey:@"subscribeuser"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 1:
                labelname.text = @"预约编号";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [[FCdicdata objectForKey:@"electricalcheckinfo"] objectForKey:@"subscribecode"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 2:
                labelname.text = @"预约时间";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [[FCdicdata objectForKey:@"electricalcheckinfo"] objectForKey:@"subscribetime"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 3:
                labelname.text = @"凭证号";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [[FCdicdata objectForKey:@"electricalcheckinfo"] objectForKey:@"vouchercode"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 4:
                labelname.text = @"业主";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [[FCdicdata objectForKey:@"electricalcheckinfo"] objectForKey:@"customername"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 5:
                labelname.text = @"联系电话";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [[FCdicdata objectForKey:@"electricalcheckinfo"] objectForKey:@"customermobile"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 6:
                labelname.text = @"地址";
                [cell.contentView addSubview:labelname];
                
                strpic = [[FCdicdata objectForKey:@"electricalcheckinfo"] objectForKey:@"customeraddress"];
                size = [AddInterface getlablesize:strpic Fwidth:SCREEN_WIDTH-60 Fheight:40 Sfont:FONTN(15.0f)];
                labelvalue.text = strpic;
                labelvalue.numberOfLines = 0;
                [cell.contentView addSubview:labelvalue];
                break;
        }
    }
    else if(indexPath.section == 2)
    {
        switch (indexPath.row)
        {
            case 0:
                labelname.text = @"购买商家";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [[FCdicdata objectForKey:@"orderinfo"] objectForKey:@"ordercompany"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 1:
                labelname.text = @"购买日期";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [[FCdicdata objectForKey:@"orderinfo"] objectForKey:@"ordertime"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 2:
                labelname.text = @"购买产品";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [[FCdicdata objectForKey:@"orderinfo"] objectForKey:@"ordercompany"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 3:
                labelname.text = @"备注";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [[FCdicdata objectForKey:@"electricalcheckinfo"] objectForKey:@"subscribenote"];
                [cell.contentView addSubview:labelvalue];
                break;
        }
    }
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if((indexPath.section ==2)&&(indexPath.row == 2))
    {
        TbeaBuySomeProductViewController *tbeabuy = [[TbeaBuySomeProductViewController alloc] init];
        tbeabuy.FCvouchercode = [[FCdicdata objectForKey:@"electricalcheckinfo"] objectForKey:@"vouchercode"];
        [self.navigationController pushViewController:tbeabuy animated:YES];
    }
}

#pragma mark 接口
//获取详情
-(void)getpaidandetailinfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"electricalcheckid"] = self.FCelectricalcheckid;
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQTbeaYiPaiDanDetailInfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCdicdata = [dic objectForKey:@"data"];
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
