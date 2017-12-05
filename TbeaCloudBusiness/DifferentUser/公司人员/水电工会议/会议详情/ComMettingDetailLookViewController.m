//
//  ComMettingDetailLookViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ComMettingDetailLookViewController.h"

@interface ComMettingDetailLookViewController ()

@end

@implementation ComMettingDetailLookViewController

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
    self.title = @"会议详情";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
    [self getmettingdetail];
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

-(void)viewcell1:(NSDictionary *)dicfrom FromCell:(UITableViewCell *)fromcell LabelName:(NSString *)strname
{
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 70, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = COLORNOW(117, 117, 117);
    labelname.font = FONTN(15.0f);
    labelname.text = strname;
    [fromcell.contentView addSubview:labelname];
    
    UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelname)+10, 10, 30, 30)];
    NSString *strpic;
    strpic = [dicfrom objectForKey:@"thumbpicture"];
    [imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
    imageheader.contentMode = UIViewContentModeScaleAspectFill;
    imageheader.layer.cornerRadius = 15.0f;
    imageheader.clipsToBounds = YES;
    [fromcell.contentView addSubview:imageheader];
    
    NSString *strsizename;
    strsizename = [dicfrom objectForKey:@"name"];
    CGSize sizeuser = [AddInterface getlablesize:strsizename Fwidth:100 Fheight:20 Sfont:FONTB(14.0f)];
    UILabel *labelusername = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, 7, sizeuser.width, 20)];
    labelusername.backgroundColor = [UIColor clearColor];
    labelusername.textColor = [UIColor blackColor];
    labelusername.font = FONTB(14.0f);
    labelusername.text = strsizename;
    [fromcell.contentView addSubview:labelusername];
    
    UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelusername)+5, XYViewTop(labelusername)+5, 10, 10)];
    strpic = [dicfrom objectForKey:@"persontypeicon"];
    [imageicon setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebateheader1", @"png")];
    [fromcell.contentView addSubview:imageicon];
    
    UILabel *straddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewBottom(labelusername)-2, SCREEN_WIDTH-100, 17)];
    straddr.backgroundColor = [UIColor clearColor];
    straddr.textColor = COLORNOW(117, 117, 117);
    straddr.font = FONTN(12.0f);
    straddr.text = [dicfrom objectForKey:@"jobposition"];
    [fromcell.contentView addSubview:straddr];
}

-(UIView *)viewcelljuban:(NSDictionary *)dicfrom FromFrame:(CGRect)fromframe
{
    UIView *view = [[UIView alloc] initWithFrame:fromframe];
    
    UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 30, 30)];
    NSString *strpic = [dicfrom objectForKey:@"masterthumbpicture"];
    [imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
    imageheader.layer.cornerRadius = 15.0f;
    imageheader.clipsToBounds = YES;
    [view addSubview:imageheader];
    
    CGSize sizeuser = [AddInterface getlablesize:[dicfrom objectForKey:@"mastername"] Fwidth:200 Fheight:20 Sfont:FONTB(16.0f)];
    UILabel *labelusername = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, 7, sizeuser.width, 20)];
    labelusername.backgroundColor = [UIColor clearColor];
    labelusername.textColor = [UIColor blackColor];
    labelusername.font = FONTB(16.0f);
    labelusername.text = [dicfrom objectForKey:@"mastername"];
    [view addSubview:labelusername];
    
    UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelusername)+5, XYViewTop(labelusername)+5, 25, 10)];
    NSString *strpic1 = [dicfrom objectForKey:@"companytypeicon"];
    [imageicon setImageWithURL:[NSURL URLWithString:strpic1] placeholderImage:LOADIMAGE(@"scanrebateheader1", @"png")];
    [view addSubview:imageicon];
    
    UILabel *straddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewBottom(labelusername), SCREEN_WIDTH-100, 18)];
    straddr.backgroundColor = [UIColor clearColor];
    straddr.textColor = COLORNOW(117, 117, 117);
    straddr.font = FONTN(12.0f);
    straddr.text = [dicfrom objectForKey:@"name"];
    [view addSubview:straddr];
    
    return view;
    
}

#pragma mark IBaction
-(void)returnback
{
    if([self.FCfromflag isEqualToString:@"2"])
        [self dismissViewControllerAnimated:YES completion:nil];
    else
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
    if(indexPath.section == 0)
    {
        if(indexPath.row ==2)
        {
            return [FCarrayjibandanwei count]==0?50:[FCarrayjibandanwei count]*50;
        }
    }
    else if(indexPath.section == 1)
    {
        if(indexPath.row ==0)
        {
            return 50;
        }
    }
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 5;
    else if(section == 1)
        return 2;
    else if(section == 3)
        return 1;
    return 1;
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
    
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 70, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = COLORNOW(117, 117, 117);
    labelname.font = FONTN(15.0f);
    
    
    UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(labelname)+10, 10, SCREEN_WIDTH-100, 20)];
    labelvalue.backgroundColor = [UIColor clearColor];
    labelvalue.textColor = [UIColor blackColor];
    labelvalue.font = FONTN(15.0f);
    
    if(indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0:
                labelname.text = @"会议编号";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [[FCdicdata objectForKey:@"meetingbaseinfo"] objectForKey:@"meetingcode"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 1:
                labelname.text = @"举办时间";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text =  [[FCdicdata objectForKey:@"meetingbaseinfo"] objectForKey:@"meetingtime"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 2:
                labelname.text = @"举办单位";
                [cell.contentView addSubview:labelname];
                
                for(int i=0;i<[FCarrayjibandanwei count];i++)
                {
                    [cell.contentView addSubview:[self viewcelljuban:[FCarrayjibandanwei objectAtIndex:i] FromFrame:CGRectMake(100, 50*i, SCREEN_WIDTH-130, 50)]];
                }
                break;
            case 3:
                labelname.text = @"举办地点";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [[FCdicdata objectForKey:@"meetingbaseinfo"] objectForKey:@"meetingplace"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 4:
                labelname.text = @"会议状态";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [[FCdicdata objectForKey:@"meetingbaseinfo"] objectForKey:@"meetingstatus"];
                [cell.contentView addSubview:labelvalue];
                break;
        }
    }
    else if(indexPath.section == 1)
    {
        switch (indexPath.row)
        {
            case 0:
                [self viewcell1:[FCdicdata objectForKey:@"meetingoriginatorinfo"] FromCell:cell LabelName:@"发起人"];
                
                break;
            case 1:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                labelname.text = @"参与人员";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [NSString stringWithFormat:@"%@",[[FCdicdata objectForKey:@"participantlist"] objectForKey:@"participantnumber"]];
                
                labelvalue.textAlignment = NSTextAlignmentRight;
                labelvalue.frame = CGRectMake(SCREEN_WIDTH-30-XYViewWidth(labelvalue), XYViewTop(labelvalue), XYViewWidth(labelvalue), XYViewHeight(labelvalue));
                [cell.contentView addSubview:labelvalue];
                break;
        }
    }
    else if(indexPath.section == 2)
    {
        switch (indexPath.row)
        {
            case 0:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                labelname.text = @"会议安排";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = FCmettingarrangement;
                [cell.contentView addSubview:labelvalue];
                break;
        }
    }
    else
    {
        switch (indexPath.row)
        {
            case 0:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                labelname.text = @"会议签到";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [NSString stringWithFormat:@"%@",[[FCdicdata objectForKey:@"meetingsigninfo"] objectForKey:@"signnumber"]];
                labelvalue.textAlignment = NSTextAlignmentRight;
                labelvalue.frame = CGRectMake(SCREEN_WIDTH-30-XYViewWidth(labelvalue), XYViewTop(labelvalue), XYViewWidth(labelvalue), XYViewHeight(labelvalue));
                [cell.contentView addSubview:labelvalue];
                break;
        }
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WaterMettingJoinMemberViewController *joinmember;//只是参与人员
    ComMettingScheduleViewController *mettingschedule;
    switch (indexPath.section)
    {
        case 1:
            if(indexPath.row == 1)
            {
                joinmember = [[WaterMettingJoinMemberViewController alloc] init];
                joinmember.FCmettingid = [[FCdicdata objectForKey:@"meetingbaseinfo"] objectForKey:@"id"];
                [self.navigationController pushViewController:joinmember animated:YES];
            }
            break;
        case 2:
            mettingschedule = [[ComMettingScheduleViewController alloc] init];
            mettingschedule.FCmettingdes = [FCmettingarrangement length]>0?FCmettingarrangement:@"";
            mettingschedule.delegate1 = self;
            mettingschedule.FCfromflag = @"0";
            [self.navigationController pushViewController:mettingschedule animated:YES];
            break;
    }
}

#pragma mark 接口
-(void)getmettingdetail
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"meetingid"] = self.FCmettingid;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQWaterMettingDetailCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCdicdata = [dic objectForKey:@"data"];
            FCarrayjibandanwei = [[dic objectForKey:@"data"] objectForKey:@"organizecompanylist"];
            FCmettingarrangement = [[FCdicdata objectForKey:@"meetinginfo"] objectForKey:@"meetingitems"];
            FCjoinmemberids = [[FCdicdata objectForKey:@"participantlist"] objectForKey:@"participantlist"];
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
