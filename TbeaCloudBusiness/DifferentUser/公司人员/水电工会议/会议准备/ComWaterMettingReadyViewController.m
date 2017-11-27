//
//  ComWaterMettingReadyViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/31.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ComWaterMettingReadyViewController.h"

@interface ComWaterMettingReadyViewController ()

@end

@implementation ComWaterMettingReadyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initview];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
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
    self.title = @"会议准备";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    FCarrayjibandanwei = [[NSArray alloc] init];
    FCarrayjoinmember = [[NSArray alloc] init];
    FCstrtime = @"";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
    [self getmettingready];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, SCREEN_HEIGHT-StatusBarAndNavigationHeight-80, SCREEN_WIDTH-40, 40);
    [button setTitle:@"发起会议" forState:UIControlStateNormal];
    button.titleLabel.font = FONTN(15.0f);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = COLORNOW(0, 170, 236);
    [button addTarget:self action:@selector(initiatemetting:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
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
    NSString *strpic = [dicfrom objectForKey:@"headpicture"];//[InterfaceResource stringByAppendingString:[[dicfrom objectForKey:@"headpicture"] length]>0?[dicfrom objectForKey:@"headpicture"]:@"noimage.png"];
    [imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
    imageheader.contentMode = UIViewContentModeScaleAspectFill;
    imageheader.layer.cornerRadius = 15.0f;
    imageheader.clipsToBounds = YES;
    [fromcell.contentView addSubview:imageheader];
    
    NSString *strsizename = [dicfrom objectForKey:@"name"];
    CGSize sizeuser = [AddInterface getlablesize:strsizename Fwidth:100 Fheight:20 Sfont:FONTN(14.0f)];
    UILabel *labelusername = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, 7, sizeuser.width, 20)];
    labelusername.backgroundColor = [UIColor clearColor];
    labelusername.textColor = [UIColor blackColor];
    labelusername.font = FONTB(14.0f);
    labelusername.text = strsizename;
    [fromcell.contentView addSubview:labelusername];
    
    UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelusername)+5, XYViewTop(labelusername)+5, 10, 10)];
    strpic = [dicfrom objectForKey:@"persontypeicon"];//[InterfaceResource stringByAppendingString:[[dicfrom objectForKey:@"persontypeicon"] length]>0?[dicfrom objectForKey:@"persontypeicon"]:@"noimage.png"];
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
    
    UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
    NSString *strpic = [dicfrom objectForKey:@"masterthumbpicture"];//[InterfaceResource stringByAppendingString:[[dicfrom objectForKey:@"masterthumbpicture"] length]>0?[dicfrom objectForKey:@"masterthumbpicture"]:@"noimage.png"];
    [imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
    imageheader.layer.cornerRadius = 15.0f;
    imageheader.clipsToBounds = YES;
    [view addSubview:imageheader];
    
    CGSize sizeuser = [AddInterface getlablesize:[dicfrom objectForKey:@"mastername"] Fwidth:200 Fheight:20 Sfont:FONTMEDIUM(16.0f)];
    UILabel *labelusername = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, 7, sizeuser.width, 20)];
    labelusername.backgroundColor = [UIColor clearColor];
    labelusername.textColor = [UIColor blackColor];
    labelusername.font = FONTMEDIUM(16.0f);
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

#pragma mark ActionDelegate
-(void)DGSelectAreaAddress:(NSString *)pstr City:(NSString *)city Area:(NSString *)area Address:(NSString *)address
{
    FCprovice = pstr;
    FCcity = city;
    FCarea = area;
    FCspecificaddress = address;
    
    
    FCstraddress = [NSString stringWithFormat:@"%@%@%@%@",pstr,city,area,address];
    
    UILabel *labelvalue = [tableview viewWithTag:EnWaterMettingpreparaddresstextfieldtag];
    labelvalue.text = FCstraddress;
}

-(void)DGSelectDateHourSecondDone:(NSString *)starttime EndTime:(NSString *)endtime
{
    
    DLog(@"starttime====%@,%@",starttime,endtime);
    FCstarttime = starttime;
    FCendtime = endtime;
    NSString *strendtime;
    if([endtime length]>11)
        strendtime = [endtime substringFromIndex:11];
    
    FCstrtime = [NSString stringWithFormat:@"%@~%@",starttime,strendtime];
    
    UILabel *labelvalue = [tableview viewWithTag:EnComWaterTimeSelectLabelTag];
    labelvalue.text = FCstrtime;
}

-(void)DGMettingScheduleDone:(NSString *)sender
{
    FCmettingarrangement = sender;
    UILabel *labelvalue = [tableview viewWithTag:EnComMettingScheduleLabelValue];
    labelvalue.text = sender;
}

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
-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initiatemetting:(id)sender
{
    if(([FCstraddress length]==0)||([FCstrtime length]==0)||([FCarrayjibandanwei count]==0)||([FCarrayjoinmember count]==0)||([FCmettingarrangement length]==0))
    {
        [MBProgressHUD showError:@"请完善会议信息" toView:app.window];
    }
    else
    {
        [self addAlertView];
        
    }
}

#pragma mark 警告弹出框及代理
-(void)addAlertView
{
    self.view.backgroundColor =[UIColor whiteColor];
    alert =[[AlertViewExtension alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, SCREEN_HEIGHT)];
    alert.delegate=self;
    [alert setbackviewframeWidth:300 Andheight:260];
    [alert settipeTitleStr:@"确保正确录入数据,相关操作会根据时间节点受限\n【发起状态】会议开始前24小时,可编辑,删除,不可更新\n【进行状态】会议开始至结束24小时内,可编辑,不可删除,更新\n【结束状态】会议结束后,可更新,不可编辑,删除" Andfont:14.0f Title:@"提示" BtStr:@"确定"];
    [app.window addSubview:alert];
}

-(void)clickBtnSelector:(UIButton *)btn
{
    if (btn.tag == 1920) {
        [alert removeFromSuperview];
        [self createmetting];
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
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        if(indexPath.row ==0)
        {
            return 50;
        }
    }
    else if(indexPath.section == 0)
    {
        if(indexPath.row ==2)
        {
            return [FCarrayjibandanwei count]==0?40:[FCarrayjibandanwei count]*50;
        }
        else if(indexPath.row ==3)
        {
            return 50;
        }
    }
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 4;
    else if(section == 1)
        return 2;
    else if(section == 2)
        return 1;
    return 0;
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
    
    
    UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(labelname)+10, 10, SCREEN_WIDTH-130, 20)];
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
                
                labelvalue.text = [[FCdicdata objectForKey:@"meetinginfo"] objectForKey:@"meetingcode"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 1:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                labelname.text = @"举办时间";
                [cell.contentView addSubview:labelname];
                
                if([FCstrtime length]==0)
                {
                    labelvalue.text = @"请选择";
                }
                else
                    labelvalue.text = FCstrtime;
                labelvalue.tag = EnComWaterTimeSelectLabelTag;
                [cell.contentView addSubview:labelvalue];
                
                
                break;
            case 2:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                labelname.text = @"举办单位";
                [cell.contentView addSubview:labelname];
                if([FCarrayjibandanwei count]>0)
                {
                    for(int i=0;i<[FCarrayjibandanwei count];i++)
                    {
                        [cell.contentView addSubview:[self viewcelljuban:[FCarrayjibandanwei objectAtIndex:i] FromFrame:CGRectMake(100, 50*i, SCREEN_WIDTH-130, 50)]];
                    }
                }
                else
                {
                    labelvalue.text = @"请选择";
                    [cell.contentView addSubview:labelvalue];
                }
                break;
            case 3:
                labelname.text = @"会议地点";
                labelname.frame = CGRectMake(XYViewL(labelname), 5, XYViewWidth(labelname), 40);
                [cell.contentView addSubview:labelname];
                
                if([FCprovice length]==0)
                {
                    labelvalue.text = @"请选择";
                }
                else
                    labelvalue.text = FCstraddress;
                labelvalue.tag = EnWaterMettingpreparaddresstextfieldtag;
                labelvalue.numberOfLines = 2;
                labelvalue.frame = CGRectMake(XYViewL(labelvalue), 5, XYViewWidth(labelvalue), 40);
                [cell.contentView addSubview:labelvalue];
                break;
        }
    }
    else if(indexPath.section == 1)
    {
        switch (indexPath.row)
        {
            case 0:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                [self viewcell1:[FCdicdata objectForKey:@"meetingoriginatorinfo"] FromCell:cell LabelName:@"发起人"];
                
                break;
            case 1:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                labelname.text = @"参与人员";
                [cell.contentView addSubview:labelname];
                
                labelvalue.frame = CGRectMake(SCREEN_WIDTH-80, 10, 40, 20);
                labelvalue.textAlignment = NSTextAlignmentRight;
                labelvalue.tag = EnComWaterJoinMemberNumberValue;
                labelvalue.font = FONTN(15.0f);
                if([FCarrayjoinmember count]>0)
                    labelvalue.text = [NSString stringWithFormat:@"%d",(int)[FCarrayjoinmember count]];
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
                
                if([FCmettingarrangement length]>0)
                    labelvalue.text = FCmettingarrangement;
                labelvalue.tag = EnComMettingScheduleLabelValue;
                [cell.contentView addSubview:labelvalue];
                break;
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTimeSelectViewController *timeselect;
    ComWaterJXSSelectViewController *comjsxlist;
    ComWaterJoinMemberSelectViewController *joinmember;
    ComMettingScheduleViewController *mettingschedule;
    AddressSelectInputViewController *addressselect;
    UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexPath];
    UILabel *label;
    switch (indexPath.section)
    {
        case 0:
            switch (indexPath.row)
            {
                case 0:
                
                    break;
                case 1:
                    timeselect = [[CustomTimeSelectViewController alloc] init];
                    timeselect.delegate1 = self;
                    timeselect.FCstarttime = FCstarttime;
                    timeselect.FCendtime = FCendtime;
                    [self.navigationController pushViewController:timeselect animated:YES];
                    break;
                case 2:
                    comjsxlist = [[ComWaterJXSSelectViewController alloc] init];
                    comjsxlist.delegate1 = self;
                    [self.navigationController pushViewController:comjsxlist animated:YES];
                    break;
                case 3:
                    addressselect = [[AddressSelectInputViewController alloc] init];
                    addressselect.delegate1 = self;
                    [self.navigationController pushViewController:addressselect animated:YES];
                    break;
            }
            break;
        case 1:
            switch (indexPath.row)
            {
                case 0:
                
                    break;
                case 1:
                    joinmember = [[ComWaterJoinMemberSelectViewController alloc] init];
                    joinmember.delegate1 = self;
                    [self.navigationController pushViewController:joinmember animated:YES];
                    break;
                
            }
            break;
        case 2:
            mettingschedule = [[ComMettingScheduleViewController alloc] init];
            label = [cell.contentView viewWithTag:EnComMettingScheduleLabelValue];
            mettingschedule.FCmettingdes = [label.text length]>0?label.text:@"";
            mettingschedule.delegate1 = self;
            [self.navigationController pushViewController:mettingschedule animated:YES];
            break;
        default:
            break;
    }
}

#pragma mark 接口
-(void)getmettingready
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQComWaterMettingReadyInfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
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

-(void)createmetting
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"meetingcode"] = [[FCdicdata objectForKey:@"meetinginfo"] objectForKey:@"meetingcode"];
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
            if([self.delegate1 respondsToSelector:@selector(DGWaterMettingCommitDone:)])
            {
                [self.delegate1 DGWaterMettingCommitDone:[[[dic objectForKey:@"data"] objectForKey:@"meetinginfo"] objectForKey:@"meetingid"]];
                [self.navigationController popViewControllerAnimated:NO];
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
