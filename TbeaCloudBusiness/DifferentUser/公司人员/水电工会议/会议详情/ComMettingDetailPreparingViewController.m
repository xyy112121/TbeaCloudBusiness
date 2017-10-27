//
//  ComMettingDetailPreparingViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#define TITLES @[@"编辑"]

#import "ComMettingDetailPreparingViewController.h"

@interface ComMettingDetailPreparingViewController ()

@end

@implementation ComMettingDetailPreparingViewController

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
    self.title = @"会议详情";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    editstatus = EnMettingNotEdit;
    
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
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
    strpic = [dicfrom objectForKey:@"thumbpicture"];//[InterfaceResource stringByAppendingString:[[dicfrom objectForKey:@"thumbpicture"] length]>0?[dicfrom objectForKey:@"thumbpicture"]:@"noimage.png"];
    [imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
    imageheader.contentMode = UIViewContentModeScaleAspectFill;
    imageheader.layer.cornerRadius = 15.0f;
    imageheader.clipsToBounds = YES;
    [fromcell.contentView addSubview:imageheader];
    
    NSString *strsizename;
    strsizename = [dicfrom objectForKey:@"name"];
    CGSize sizeuser = [AddInterface getlablesize:strsizename Fwidth:100 Fheight:20 Sfont:FONTB(16.0f)];
    UILabel *labelusername = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, 7, sizeuser.width, 20)];
    labelusername.backgroundColor = [UIColor clearColor];
    labelusername.textColor = [UIColor blackColor];
    labelusername.font = FONTB(16.0f);
    labelusername.text = strsizename;
    [fromcell.contentView addSubview:labelusername];
    
    UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelusername)+5, XYViewTop(labelusername)+5, 10, 10)];
    strpic = [dicfrom objectForKey:@"thumbpicture"];//[InterfaceResource stringByAppendingString:[[dicfrom objectForKey:@"thumbpicture"] length]>0?[dicfrom objectForKey:@"thumbpicture"]:@"noimage.png"];
    [imageicon setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebateheader1", @"png")];
    [fromcell.contentView addSubview:imageicon];
    
    UILabel *straddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewBottom(labelusername)-2, SCREEN_WIDTH-100, 17)];
    straddr.backgroundColor = [UIColor clearColor];
    straddr.textColor = COLORNOW(117, 117, 117);
    straddr.font = FONTN(12.0f);
    straddr.text = [dicfrom objectForKey:@"jobposition"];
    [fromcell.contentView addSubview:straddr];
}

-(void)initviewunder
{
    UIButton *buttonloging = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonloging.frame = CGRectMake(30, SCREEN_HEIGHT-60-64, SCREEN_WIDTH-60, 40);
    buttonloging.layer.cornerRadius = 3.0f;
    buttonloging.backgroundColor = COLORNOW(0, 170, 238);
    buttonloging.clipsToBounds = YES;
    [buttonloging setTitle:@"保存" forState:UIControlStateNormal];
    [buttonloging addTarget:self action:@selector(clicksave:) forControlEvents:UIControlEventTouchUpInside];
    [buttonloging setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonloging.titleLabel.font = FONTN(16.0f);
    [self.view addSubview:buttonloging];
}

-(UIView *)viewcelljuban:(NSDictionary *)dicfrom FromFrame:(CGRect)fromframe
{
    UIView *view = [[UIView alloc] initWithFrame:fromframe];
    
    UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 30, 30)];
    NSString *strpic = [dicfrom objectForKey:@"masterthumbpicture"];//[InterfaceResource stringByAppendingString:[[dicfrom objectForKey:@"masterthumbpicture"] length]>0?[dicfrom objectForKey:@"masterthumbpicture"]:@"noimage.png"];
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
    
    UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelusername)+5, XYViewTop(labelusername)+5, 10, 10)];
    NSString *strpic1 = [dicfrom objectForKey:@"companytypeicon"];//[InterfaceResource stringByAppendingString:[[dicfrom objectForKey:@"companytypeicon"] length]>0?[dicfrom objectForKey:@"companytypeicon"]:@"noimage.png"];
    [imageheader setImageWithURL:[NSURL URLWithString:strpic1] placeholderImage:LOADIMAGE(@"scanrebateheader1", @"png")];
    [view addSubview:imageicon];
    
    UILabel *straddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewBottom(labelusername), SCREEN_WIDTH-100, 18)];
    straddr.backgroundColor = [UIColor clearColor];
    straddr.textColor = COLORNOW(117, 117, 117);
    straddr.font = FONTN(12.0f);
    straddr.text = [dicfrom objectForKey:@"name"];
    [view addSubview:straddr];
    
    return view;
    
}

#pragma mark pop弹出框
- (void)Clickmorefunction:(id)sender
{
    NSMutableArray *arrayicons = [[NSMutableArray alloc] init];
    [arrayicons addObject:LOADIMAGE(@"metting编辑", @"png")];
    ybpopmenu = [YBPopupMenu showRelyOnView:sender titles:TITLES icons:arrayicons menuWidth:130 otherSettings:^(YBPopupMenu *popupMenu)
                 {
                     popupMenu.dismissOnSelected = NO;
                     popupMenu.isShowShadow = YES;
                     popupMenu.delegate = self;
                     popupMenu.offset = 5;
                     popupMenu.type = YBPopupMenuTypeDefault;
                     popupMenu.rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight|UIRectCornerAllCorners;
                 }];
    
}

- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    if([TITLES[index] isEqualToString:@"编辑"])
    {
        editstatus = EnMettingEdit;
        [self initviewunder];
    }
    else if([TITLES[index] isEqualToString:@"删除"])
    {
        
    }
    [ybpopmenu dismiss];
    NSLog(@"点击了 %@ 选项",TITLES[index]);
}

#pragma mark ActionDelegate
-(void)DGSelectJXSCellView:(NSArray *)sender
{
    FCarrayjibandanwei = sender;
    
    FCjubandanweiids = @"";
    for(int i=0;i<[sender count];i++)
    {
        NSDictionary *dictemp = [sender objectAtIndex:i];
        FCjubandanweiids = [FCjubandanweiids length]==0?[dictemp objectForKey:@"id"]:[NSString stringWithFormat:@"%@,%@",FCjubandanweiids,[dictemp objectForKey:@"id"]];
    }
    
    [tableview reloadData];
}

-(void)DGMettingScheduleDone:(NSString *)sender
{
    FCmettingarrangement = sender;
    [tableview reloadData];
}

-(void)DGSelectJoinMemberCellView:(id)sender
{
    FCarrayjoinmember = sender;
    FCjoinmemberids = @"";
    for(int i=0;i<[sender count];i++)
    {
        NSDictionary *dictemp = [sender objectAtIndex:i];
        FCjoinmemberids = [FCjoinmemberids length]==0?[dictemp objectForKey:@"userid"]:[NSString stringWithFormat:@"%@,%@",FCjoinmemberids,[dictemp objectForKey:@"userid"]];
    }
    
    UILabel *label = [tableview viewWithTag:EnComWaterJoinMemberNumberValue];
    label.text = [NSString stringWithFormat:@"%d",(int)[FCarrayjoinmember count]];
}

#pragma mark IBaction
-(void)clicksave:(id)sender
{
    if(([FCstraddress length]==0)||([FCstrtime length]==0)||([FCarrayjibandanwei count]==0)||([FCjoinmemberids length]==0)||([FCmettingarrangement length]==0))
    {
        [MBProgressHUD showError:@"请完善会议信息" toView:app.window];
    }
    else
    {
        [self createmetting];
        
    }
}

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
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.row ==2)
        {
            if(indexPath.row ==2)
            {
                return [FCarrayjibandanwei count]==0?50:[FCarrayjibandanwei count]*50;
            }
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
    labelvalue.textColor = COLORNOW(117, 117, 117);
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
                
                labelvalue.text = FCstrtime;
                [cell.contentView addSubview:labelvalue];
                break;
            case 2:
                labelname.text = @"举办单位";
                [cell.contentView addSubview:labelname];
                
                if([FCarrayjibandanwei count]>0)
                {
                    for(int i=0;i<[FCarrayjibandanwei count];i++)
                    {
                        [cell.contentView addSubview:[self viewcelljuban:[FCarrayjibandanwei objectAtIndex:i] FromFrame:CGRectMake(100, 50*i, SCREEN_WIDTH-130, 50)]];
                    }
                }
                
                break;
            case 3:
                labelname.text = @"举办地点";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = FCstraddress;
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
                
                labelvalue.tag = EnComWaterJoinMemberNumberValue;
                labelvalue.text = FCparticipantnumber;
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
    
    if(editstatus == EnMettingNotEdit)
    {
        WaterMettingJoinMemberViewController *joinmember;//只是参与人员
        ComMettingScheduleViewController *mettingschedule;
        WaterMettingCheckInViewController *checkin;
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
            case 3:
                checkin = [[WaterMettingCheckInViewController alloc] init];
                checkin.FCmettingid = [[FCdicdata objectForKey:@"meetingbaseinfo"] objectForKey:@"id"];
                [self.navigationController pushViewController:checkin animated:YES];
                break;
        }
        
    }
    else
    {
        ComWaterJoinMemberSelectViewController *joinmember;
        WaterMettingCheckInViewController *checkin;
        ComMettingScheduleViewController *mettingschedule;
        ComWaterJXSSelectViewController *comjsxlist;
        switch (indexPath.section)
        {
            case 0:
                if(indexPath.row == 2)
                {
                    comjsxlist = [[ComWaterJXSSelectViewController alloc] init];
                    comjsxlist.delegate1 = self;
                    comjsxlist.FCselectdata = FCarrayjibandanwei;
                    [self.navigationController pushViewController:comjsxlist animated:YES];
                }
                break;
            case 1:
                if(indexPath.row == 1)
                {
                    joinmember = [[ComWaterJoinMemberSelectViewController alloc] init];
                    joinmember.FCmettingid = [[FCdicdata objectForKey:@"meetingbaseinfo"] objectForKey:@"id"];
                    joinmember.delegate1 = self;
                    joinmember.FCjoinmemberids = FCjoinmemberids;
                    [self.navigationController pushViewController:joinmember animated:YES];
                }
                break;
            case 2:
                mettingschedule = [[ComMettingScheduleViewController alloc] init];
                mettingschedule.FCmettingdes = [FCmettingarrangement length]>0?FCmettingarrangement:@"";
                mettingschedule.delegate1 = self;
                mettingschedule.FCfromflag = @"1";
                [self.navigationController pushViewController:mettingschedule animated:YES];
                break;
            case 3:
                if(indexPath.row == 0)
                {
                    checkin = [[WaterMettingCheckInViewController alloc] init];
                    checkin.FCmettingid = @"";
                    [self.navigationController pushViewController:checkin animated:YES];
                    
                }
                break;
            default:
                break;
        }
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
            FCarrayjibandanwei = [FCdicdata objectForKey:@"organizecompanylist"];
            FCjoinmemberids = [[FCdicdata objectForKey:@"participantlist"] objectForKey:@"participantlist"];
            FCprovice = [[FCdicdata objectForKey:@"meetingbaseinfo"] objectForKey:@"meetingprovince"];
            FCcity = [[FCdicdata objectForKey:@"meetingbaseinfo"] objectForKey:@"meetingcity"];
            FCarea = [[FCdicdata objectForKey:@"meetingbaseinfo"] objectForKey:@"meetingzone"];
            FCspecificaddress = [[FCdicdata objectForKey:@"meetingbaseinfo"] objectForKey:@"meetingaddr"];
            FCstraddress = [[FCdicdata objectForKey:@"meetingbaseinfo"] objectForKey:@"meetingplace"];
            FCstrtime = [[FCdicdata objectForKey:@"meetingbaseinfo"] objectForKey:@"meetingtime"];
            FCendtime = [[FCdicdata objectForKey:@"meetingbaseinfo"] objectForKey:@"meetingendtime"];
            FCstarttime = [[FCdicdata objectForKey:@"meetingbaseinfo"] objectForKey:@"meetingstarttime"];
            FCmettingarrangement = [[FCdicdata objectForKey:@"meetinginfo"] objectForKey:@"meetingitems"];
            FCparticipantnumber = [NSString stringWithFormat:@"%@",[[FCdicdata objectForKey:@"participantlist"] objectForKey:@"participantnumber"]];
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

-(void)createmetting
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"meetingcode"] = [[FCdicdata objectForKey:@"meetingbaseinfo"] objectForKey:@"meetingcode"];
    params[@"meetingstarttime"] = FCstarttime;
    params[@"meetingendtime"] = FCendtime;
    params[@"organizecompanylist"] = FCjubandanweiids;
    params[@"meetingprovinceid"] = FCprovice;
    params[@"meetingcityid"] = FCcity;
    params[@"meetingzoneid"] = FCarea;
    params[@"meetingaddr"] = FCspecificaddress;
    params[@"originatoruserid"] = app.userinfo.userid;
    params[@"participantlist"] = FCjoinmemberids;
    params[@"meetingitems"] = FCmettingarrangement;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:REComWaterMettingCreateMettingCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            [self.navigationController popViewControllerAnimated:YES];
            
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
