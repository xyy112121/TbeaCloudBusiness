//
//  userAuthorizationingViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/21.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "userAuthorizationingViewController.h"

@interface userAuthorizationingViewController ()

@end

@implementation userAuthorizationingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initview];
    [self initfootview];
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
-(void)initfootview
{
    UIView *viewfoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    viewfoot.backgroundColor = [UIColor whiteColor];
    [tableview setTableFooterView:viewfoot];
    
    UIButton *buttonnext = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonnext.frame = CGRectMake(20, 40, SCREEN_WIDTH-40, 40);
    
    [buttonnext setTitle:@"查看认证状态" forState:UIControlStateNormal];
    buttonnext.layer.cornerRadius = 3.0f;
    buttonnext.clipsToBounds = YES;
    
    [buttonnext setBackgroundColor:COLORNOW(0, 170, 238)];
    if([_FCidentifystatus isEqualToString:@"identifyfailed"])
    {
        [buttonnext setTitle:@"重新认证" forState:UIControlStateNormal];
        [buttonnext setBackgroundColor:[UIColor redColor]];
        [buttonnext addTarget:self action:@selector(recommitauth:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [buttonnext addTarget:self action:@selector(commitauth:) forControlEvents:UIControlEventTouchUpInside];
    }
    [viewfoot addSubview:buttonnext];
}


-(void)initview
{
    self.title = @"实名认证";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    [self getauthoruserinfo];
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

#pragma mark UITextfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == EnUserAuthorizaTextfield3)
    {
        AddressSelectInputViewController *addressselect = [[AddressSelectInputViewController alloc] init];
        addressselect.delegate1 = self;
        [self.navigationController pushViewController:addressselect animated:YES];
        return NO;
    }
    return YES;
}





#pragma mark IBaction

-(void)recommitauth:(id)sender
{
    
}

-(void)commitauth:(id)sender
{
    
    [self getnowauthorstatus];
    
}

-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)removekeyboard
{
    UITextField *textfield = [tableview viewWithTag:EnUserMakeUpTextfield5];
    [textfield resignFirstResponder];
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
        if(indexPath.row ==4)
        {
            return 100;
        }
    }
    else if(indexPath.section == 1)
    {
        if((indexPath.row ==2)||(indexPath.row ==3))
        {
            return 100;
        }
    }
    else if(indexPath.section == 2)
    {
        
        return 100;
    }
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 5;
    else if(section == 1)
        return 4;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 40.0f;
    return 50;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        viewheader.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 0.7)];
        imageline.backgroundColor = COLORNOW(220, 220, 220);
        [viewheader addSubview:imageline];
        
        UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
        labeltitle.backgroundColor = [UIColor clearColor];
        labeltitle.font = FONTMEDIUM(15.0f);
        labeltitle.textColor = [UIColor blackColor];
        [viewheader addSubview:labeltitle];
        labeltitle.text = @"企业信息";
        return viewheader;
    }
    else
    {
        UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        viewheader.backgroundColor = COLORNOW(235, 235, 235);
        
        UIImageView *imageviewback = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 40)];
        imageviewback.backgroundColor = [UIColor whiteColor];
        [viewheader addSubview:imageviewback];
        
        UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 0.7)];
        imageline.backgroundColor = COLORNOW(220, 220, 220);
        [viewheader addSubview:imageline];
        
        UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 20)];
        labeltitle.backgroundColor = [UIColor clearColor];
        labeltitle.font = FONTMEDIUM(15.0f);
        labeltitle.textColor = [UIColor blackColor];
        [viewheader addSubview:labeltitle];
        if(section == 1)
            labeltitle.text = @"法人信息";
        else if(section == 2)
            labeltitle.text = @"实景信息";
        
        return viewheader;
    }
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
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = COLORNOW(117, 117, 117);
    labelname.font = FONTN(15.0f);
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, SCREEN_WIDTH-110, 30)];
    textfield.textColor = [UIColor blackColor];
    textfield.backgroundColor = [UIColor clearColor];
    textfield.font = FONTN(15.0f);
    textfield.delegate = self;
    textfield.enabled = NO;
    
    UIImageView *imageadd,*imageadd2;
    UITapGestureRecognizer *singleTap;
    NSString *strpic;
    NSArray *arraypic;
    if(indexPath.section == 0)
    {
        switch (indexPath.row)
        {
                
            case 0:
                labelname.text = @"名称";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"请填写营业执照上的企业名称";
                textfield.textColor = COLORNOW(117, 117, 117);
                textfield.tag = EnUserAuthorizaTextfield1;
                textfield.text = FCcompanyname;
                [cell.contentView addSubview:textfield];
                break;
            case 1:
                labelname.text = @"注册号";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"请填写营业执照上的注册号";
                textfield.textColor = COLORNOW(117, 117, 117);
                textfield.tag = EnUserAuthorizaTextfield2;
                textfield.text = FClisencecode;
                [cell.contentView addSubview:textfield];
                break;
            case 2:
                labelname.text = @"所在地";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"请填写营业执照上的注册所在详细地址";
                textfield.textColor = COLORNOW(117, 117, 117);
                textfield.tag = EnUserAuthorizaTextfield3;
                textfield.text = FCaddress;
                [cell.contentView addSubview:textfield];
                break;
            case 3:
                labelname.text = @"经营范围";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"请填写营业执照上的经营范围";
                textfield.textColor = COLORNOW(117, 117, 117);
                textfield.tag = EnUserAuthorizaTextfield4;
                textfield.text = FCbusinesscope;
                [cell.contentView addSubview:textfield];
                break;
            case 4:
                labelname.text = @"营业执照";
                labelname.frame = CGRectMake(10, 40, XYViewWidth(labelname), 20);
                [cell.contentView addSubview:labelname];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                imageadd = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, 80, 80)];
                strpic = FCcompanylisencepicture;//[NSString stringWithFormat:@"%@%@",InterfaceResource,[FCcompanylisencepicture length]>0?FCcompanylisencepicture:@"123"];
                [imageadd setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"useraddpic", @"png")];
                
                imageadd.userInteractionEnabled = YES;
                imageadd.tag = EnUserAuthorizaImageview1;
                
                [cell.contentView addSubview:imageadd];
        }
    }
    else if(indexPath.section == 1)
    {
        switch (indexPath.row)
        {
            case 0:
                labelname.text = @"法人姓名";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"请输入与营业执照一致的姓名";
                textfield.tag = EnUserAuthorizaTextfield5;
                 textfield.text = FCmasterperson;
                [cell.contentView addSubview:textfield];
                break;
            case 1:
                labelname.text = @"身份证号";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"请输入与营业执照一致的号码";
                textfield.textColor = COLORNOW(117, 117, 117);
                textfield.tag = EnUserAuthorizaTextfield6;
                textfield.text = FCmasterpersonid;
                [cell.contentView addSubview:textfield];
                break;
            case 2:
                labelname.text = @"个人信息面";
                labelname.frame = CGRectMake(10, 40, XYViewWidth(labelname), 20);
                [cell.contentView addSubview:labelname];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                imageadd = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, 80, 80)];
                strpic = FCpersoncard1;//[NSString stringWithFormat:@"%@%@",InterfaceResource,[FCpersoncard1 length]>0?FCpersoncard1:@"123"];
                [imageadd setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"useraddpic", @"png")];
                
                imageadd.tag = EnUserAuthorizaImageview2;
                [cell.contentView addSubview:imageadd];
                break;
            case 3:
                labelname.text = @"国徽面";
                labelname.frame = CGRectMake(10, 40, XYViewWidth(labelname), 20);
                [cell.contentView addSubview:labelname];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                imageadd = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, 80, 80)];
                strpic = FCpersoncard2;//[NSString stringWithFormat:@"%@%@",InterfaceResource,[FCpersoncard2 length]>0?FCpersoncard2:@"123"];
                [imageadd setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"useraddpic", @"png")];
                
                imageadd.tag = EnUserAuthorizaImageview3;
                [cell.contentView addSubview:imageadd];
                
                break;
        }
    }
    else if(indexPath.section == 2)
    {
        labelname.text = @"实景照片";
        labelname.frame = CGRectMake(10, 40, XYViewWidth(labelname), 20);
        [cell.contentView addSubview:labelname];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        arraypic = [FCcompanyphoto componentsSeparatedByString:@","];
        
        if([arraypic count]>0)
        {
            imageadd = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, 80, 80)];
            strpic = [[arraypic objectAtIndex:0] length]>0?[arraypic objectAtIndex:0]:@"123";//[NSString stringWithFormat:@"%@%@",InterfaceResource,[[arraypic objectAtIndex:0] length]>0?[arraypic objectAtIndex:0]:@"123"];
            [imageadd setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"useraddpic", @"png")];
            
            imageadd.tag = EnUserAuthorizaImageview4;
            [cell.contentView addSubview:imageadd];
        }
        
        if([arraypic count]>1)
        {
            imageadd2 = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(imageadd)+10, 10, 80, 80)];
            strpic = [[arraypic objectAtIndex:1] length]>0?[arraypic objectAtIndex:1]:@"123";//[NSString stringWithFormat:@"%@%@",InterfaceResource,[[arraypic objectAtIndex:1] length]>0?[arraypic objectAtIndex:1]:@"123"];
            [imageadd setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"useraddpic", @"png")];
            
            imageadd2.tag = EnUserAuthorizaImageview5;
            [cell.contentView addSubview:imageadd2];
        }
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark 接口

-(void)getnowauthorstatus
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQUserGetAuthStatusNowCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            NSFileManager *filemanger = [NSFileManager defaultManager];
            [filemanger removeItemAtPath:UserMessage error:nil];
            
            NSDictionary *dicuserinfo = [[dic objectForKey:@"data"] objectForKey:@"userinfo"];
            [dicuserinfo writeToFile:UserMessage atomically:NO];
            app.userinfo.userid = [dicuserinfo objectForKey:@"id"];
            app.userinfo.userpermission = [dicuserinfo objectForKey:@"whetheridentifiedid"];
            app.userinfo.usertel = [dicuserinfo objectForKey:@"mobile"];
            app.userinfo.username = [dicuserinfo objectForKey:@"name"];
            app.userinfo.userheader = [dicuserinfo objectForKey:@"name"];
            app.userinfo.usertype = [dicuserinfo objectForKey:@"usertypeid"];
            app.userinfo.useraccount = [dicuserinfo objectForKey:@"account"];
            
            [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:app.window];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}


-(void)getauthoruserinfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQUserRealNameAuthInfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCcompanyname = [[[dic objectForKey:@"data"] objectForKey:@"companyidentifyinfo"] objectForKey:@"companyname"];
            FClisencecode = [[[dic objectForKey:@"data"] objectForKey:@"companyidentifyinfo"] objectForKey:@"companylisencecode"];
            FCaddress = [[[dic objectForKey:@"data"] objectForKey:@"companyidentifyinfo"] objectForKey:@"companyaddress"];
            FCbusinesscope = [[[dic objectForKey:@"data"] objectForKey:@"companyidentifyinfo"] objectForKey:@"businessscope"];
            FCcompanylisencepicture = [[[dic objectForKey:@"data"] objectForKey:@"companyidentifyinfo"] objectForKey:@"companylisencepicture"];
            FCmasterperson = [[[dic objectForKey:@"data"] objectForKey:@"companyidentifyinfo"] objectForKey:@"masterperson"];
            FCmasterpersonid = [[[dic objectForKey:@"data"] objectForKey:@"companyidentifyinfo"] objectForKey:@"masterpersonid"];
            FCpersoncard1 = [[[dic objectForKey:@"data"] objectForKey:@"companyidentifyinfo"] objectForKey:@"masterpersonidcard1"];
            FCpersoncard2 = [[[dic objectForKey:@"data"] objectForKey:@"companyidentifyinfo"] objectForKey:@"masterpersonidcard2"];
            FCcompanyphoto = [[[dic objectForKey:@"data"] objectForKey:@"companyidentifyinfo"] objectForKey:@"companypicture"];
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
