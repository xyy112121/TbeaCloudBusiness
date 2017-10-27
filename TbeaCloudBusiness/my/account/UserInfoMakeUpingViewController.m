//
//  UserInfoMakeUpingViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/21.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "UserInfoMakeUpingViewController.h"

@interface UserInfoMakeUpingViewController ()

@end

@implementation UserInfoMakeUpingViewController

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
    self.title = @"资料补全";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    
    UIButton *buttonnext = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonnext.frame = CGRectMake(20, SCREEN_HEIGHT-70-64, SCREEN_WIDTH-40, 40);
    [buttonnext setTitle:@"下一步" forState:UIControlStateNormal];
    buttonnext.layer.cornerRadius = 3.0f;
    buttonnext.clipsToBounds = YES;
    [buttonnext addTarget:self action:@selector(gotonext:) forControlEvents:UIControlEventTouchUpInside];
    [buttonnext setBackgroundColor:COLORNOW(0, 170, 238)];
    [self.view addSubview:buttonnext];
    [self getmakeupuserinfo];
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

-(void)viewcell1:(NSString *)dicfrom FromCell:(UITableViewCell *)fromcell
{
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 80, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = COLORNOW(117, 117, 117);
    labelname.font = FONTN(15.0f);
    labelname.text = @"隶属关系";
    [fromcell.contentView addSubview:labelname];
    
    UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelname)+10, 10, 30, 30)];
    imageheader.image = LOADIMAGE(@"scanrebatetest1", @"png");
    imageheader.layer.cornerRadius = 15.0f;
    imageheader.clipsToBounds = YES;
    [fromcell.contentView addSubview:imageheader];
    
    CGSize sizeuser = [AddInterface getlablesize:@"刘涛" Fwidth:100 Fheight:20 Sfont:FONTN(14.0f)];
    UILabel *labelusername = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, 7, sizeuser.width, 20)];
    labelusername.backgroundColor = [UIColor clearColor];
    labelusername.textColor = [UIColor blackColor];
    labelusername.font = FONTN(14.0f);
    labelusername.text = @"刘涛";
    [fromcell.contentView addSubview:labelusername];
    
    UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelusername)+5, XYViewTop(labelusername)+5, 10, 10)];
    imageicon.image = LOADIMAGE(@"scanrebateheader1", @"png");
    [fromcell.contentView addSubview:imageicon];
    
    UILabel *straddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewBottom(labelusername)-2, SCREEN_WIDTH-100, 17)];
    straddr.backgroundColor = [UIColor clearColor];
    straddr.textColor = COLORNOW(117, 117, 117);
    straddr.font = FONTN(12.0f);
    straddr.text = @"四川省成都市静养区XX路XX楼";
    [fromcell.contentView addSubview:straddr];
}

#pragma mark UITextfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if(textField.tag == EnUserMakeUpTextfield3)
    {
        //地区选择
        [self removekeyboard];
        [self clickselectcity];
        return NO;
    }
    else if(textField.tag == EnUserMakeUpTextfield4)
    {
        //隶属关系
        [self removekeyboard];
        [self clickgetmakelist];
        return NO;
    }
    else if(textField.tag == EnUserMakeUpTextfield6)
    {
        //性别
        [self removekeyboard];
        [self clickselectsex];
        return NO;
    }
    else if(textField.tag == EnUserMakeUpTextfield7)
    {
        //生日
        [self removekeyboard];
        [self clickselecttime];
        return NO;
    }
    return YES;
}

#pragma mark 时间选择，地点选择delegate
- (void)clickselecttime
{
    FDPickerTimer * pickerDate = [[FDPickerTimer alloc] init];
    pickerDate.FDDelegate = self;
    [pickerDate show];
}

- (void)pickerTimer:(FDPickerTimer *)pickerTimer year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    NSString *text = [NSString stringWithFormat:@"%ld-%ld-%ld", year, month, day];
    
    FCyear = [NSString stringWithFormat:@"%d",(int)year];
    FCmonth = [NSString stringWithFormat:@"%d",(int)month];;
    FCday = [NSString stringWithFormat:@"%d",(int)day];;
    
    UITextField *textfield = [tableview viewWithTag:EnUserMakeUpTextfield7];
    textfield.text = text;
    
}

//地址选择
- (void)clickselectcity{
    FDCityPicker *city = [[FDCityPicker alloc] initWithDelegate:self];
    [city show];
}
- (void)pickerAreaer:(FDCityPicker *)pickerAreaer province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    FCprovice = province;
    FCcity = city;
    FCarea = area;
    NSString *text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
    UITextField *textfield = [tableview viewWithTag:EnUserMakeUpTextfield3];
    textfield.text = text;
}

#pragma mark 弹窗求
-(void)clickselectsex   //选择性别
{
    NSArray *usertypes = @[@"男",@"女"];
    [ZJBLStoreShopTypeAlert showWithTitle:@"请选择用户性别" titles:usertypes deleGate1:self selectIndex:^(NSInteger selectIndex) {
    } selectValue:^(NSString *selectValue) {
        DLog(@"selectvalue====%@",selectValue);
        UITextField *textfield = [tableview viewWithTag:EnUserMakeUpTextfield6];
        textfield.text = selectValue;
        if([selectValue isEqualToString:@"男"])
            FCsex =@"male";
        else
            FCsex = @"female";
    } showCloseButton:YES];
}

-(void)clickgetmakelist   //选择隶属关系
{

}



#pragma mark IBaction
-(void)gotonext:(id)sender
{
    
    userAuthorizationingViewController *userauth = [[userAuthorizationingViewController alloc] init];
    [self.navigationController pushViewController:userauth animated:YES];
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
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        if(indexPath.row ==1)
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
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 0.001f;
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
    
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 65, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = COLORNOW(117, 117, 117);
    labelname.font = FONTN(15.0f);
    
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(90, 5, SCREEN_WIDTH-130, 30)];
    textfield.textColor = [UIColor blackColor];
    textfield.backgroundColor = [UIColor clearColor];
    textfield.font = FONTN(15.0f);
    textfield.delegate = self;
    textfield.enabled = NO;
    
    UIImageView *imageheader;
    NSString *strpic;
    if(indexPath.section == 0)
    {
        switch (indexPath.row)
        {
                
            case 0:
                labelname.text = @"账号";
                [cell.contentView addSubview:labelname];
                
                textfield.text = app.userinfo.useraccount;
                textfield.enabled = NO;
                textfield.textColor = COLORNOW(117, 117, 117);
                textfield.tag = EnUserMakeUpTextfield1;
                [cell.contentView addSubview:textfield];
                break;
            case 1:
                labelname.text = @"用户类型";
                [cell.contentView addSubview:labelname];
                
                if([app.userinfo.usertype isEqualToString:@"distributor"])
                    textfield.text = @"分销商";
                else
                    textfield.text = @"其它商家";
                textfield.enabled = NO;
                textfield.textColor = COLORNOW(117, 117, 117);
                textfield.tag = EnUserMakeUpTextfield2;
                [cell.contentView addSubview:textfield];
                break;
            case 2:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                labelname.text = @"地区选择";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"地区选择后将不能更改,请谨慎选择";
                textfield.tag = EnUserMakeUpTextfield3;
                textfield.text = [NSString stringWithFormat:@"%@ %@ %@",FCprovice,FCcity,FCarea];
                [cell.contentView addSubview:textfield];
                break;
            case 3:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                labelname.text = @"隶属关系";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"请选择您的上线经销商";
                textfield.tag = EnUserMakeUpTextfield4;
                textfield.text = FCcompanyname;
                [cell.contentView addSubview:textfield];
                break;
        }
    }
    else
    {
        switch (indexPath.row)
        {
            case 0:
                labelname.text = @"真实姓名";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"请填写您的姓名";
                textfield.tag = EnUserMakeUpTextfield5;
                textfield.text = FCrealname;
                [cell.contentView addSubview:textfield];
                break;
            case 1:
                labelname.text = @"头像";
                labelname.frame = CGRectMake(20, 15, 80, 20);
                [cell.contentView addSubview:labelname];
                
                imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(90, 10, 30, 30)];
                strpic = FCuploadstrpic;//[NSString stringWithFormat:@"%@%@",InterfaceResource,[FCuploadstrpic length]>0?FCuploadstrpic:@"123"];
                [imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"userhedergray", @"png")];
                imageheader.layer.cornerRadius = 15.0f;
                imageheader.clipsToBounds = YES;
                imageheader.tag = EnUserMakeUpImageView1;
                [cell.contentView addSubview:imageheader];
                break;
            case 2:
                labelname.text = @"性别";
                [cell.contentView addSubview:labelname];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                textfield.placeholder = @"请选择你的性别";
                textfield.tag = EnUserMakeUpTextfield6;
                textfield.text = FCsex;
                [cell.contentView addSubview:textfield];
                break;
            case 3:
                labelname.text = @"生日";
                [cell.contentView addSubview:labelname];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                textfield.placeholder = @"请选择你的生日";
                textfield.tag = EnUserMakeUpTextfield7;
                textfield.text = [NSString stringWithFormat:@"%@-%@",FCmonth,FCday];;
                [cell.contentView addSubview:textfield];
                break;
        }
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark 接口
-(void)getmakeupuserinfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQuserInfoGetMakeUpViewUserinfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCprovice = [[[dic objectForKey:@"data"] objectForKey:@"personinfo"] objectForKey:@"province"];
            FCcity = [[[dic objectForKey:@"data"] objectForKey:@"personinfo"] objectForKey:@"city"];
            FCarea = [[[dic objectForKey:@"data"] objectForKey:@"personinfo"] objectForKey:@"zone"];
            FCcompanyname = [[[[dic objectForKey:@"data"] objectForKey:@"personinfo"] objectForKey:@"firstdistributorinfo"] objectForKey:@"companyname"];
            FCrealname = [[[dic objectForKey:@"data"] objectForKey:@"personinfo"] objectForKey:@"realname"];
            FCuploadstrpic = [[[dic objectForKey:@"data"] objectForKey:@"personinfo"] objectForKey:@"picture"];
            FCsex = [[[[dic objectForKey:@"data"] objectForKey:@"personinfo"] objectForKey:@"sexid"] isEqualToString:@"male"]?@"男":@"女";
            FCyear = [[[dic objectForKey:@"data"] objectForKey:@"personinfo"] objectForKey:@"birthyear"];
            FCmonth = [[[dic objectForKey:@"data"] objectForKey:@"personinfo"] objectForKey:@"birthmonth"];
            FCday = [[[dic objectForKey:@"data"] objectForKey:@"personinfo"] objectForKey:@"birthday"];
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
