//
//  SonAccountAddNewViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/20.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "SonAccountAddNewViewController.h"

@interface SonAccountAddNewViewController ()

@end

@implementation SonAccountAddNewViewController

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
	
    if([_FCisedit isEqualToString:@"NO"])
    {
        UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
        buttonright.titleLabel.font = FONTN(14.0f);
        buttonright.tag = 900;
        [buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buttonright setTitle:@"删除" forState:UIControlStateNormal];
        buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
        [buttonright addTarget:self action: @selector(clickdelete:) forControlEvents: UIControlEventTouchUpInside];
        [contentViewright addSubview:buttonright];
        UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
        self.navigationItem.rightBarButtonItem = barButtonItemright;
    }
	// Do any additional setup after loading the view.
}

#pragma mark 页面布局

-(void)initview
{
	self.title = @"子账号权限";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
    FCarrayauthorization = [[NSArray alloc] init];
    
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	
	[self setExtraCellLineHidden:tableview];
	
	UIButton *buttonnext = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonnext.frame = CGRectMake(20, SCREEN_HEIGHT-70-StatusBarAndNavigationHeight, SCREEN_WIDTH-40, 40);
	[buttonnext setTitle:@"保存" forState:UIControlStateNormal];
	buttonnext.layer.cornerRadius = 3.0f;
	buttonnext.clipsToBounds = YES;
	[buttonnext addTarget:self action:@selector(createsonaccount:) forControlEvents:UIControlEventTouchUpInside];
	[buttonnext setBackgroundColor:COLORNOW(0, 170, 238)];
	[self.view addSubview:buttonnext];
    
    [self getsonaccountusertype];
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

-(void)returnkey
{
    UITextField *textfield1 = [self.view viewWithTag:EnSonAccountMangerTextfieldTag1];
    UITextField *textfield2 = [self.view viewWithTag:EnSonAccountMangerTextfieldTag2];
    UITextField *textfield3 = [self.view viewWithTag:EnSonAccountMangerTextfieldTag3];
    UITextField *textfield4 = [self.view viewWithTag:EnSonAccountMangerTextfieldTag4];
    UITextField *textfield5 = [self.view viewWithTag:EnSonAccountMangerTextfieldTag5];
    UITextField *textfield6 = [self.view viewWithTag:EnSonAccountMangerTextfieldTag6];
    UITextField *textfield7 = [self.view viewWithTag:EnSonAccountMangerTextfieldTag7];
    [textfield1 resignFirstResponder];
    [textfield2 resignFirstResponder];
    [textfield3 resignFirstResponder];
    [textfield4 resignFirstResponder];
    [textfield5 resignFirstResponder];
    [textfield6 resignFirstResponder];
    [textfield7 resignFirstResponder];
}

#pragma mark UITextfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if(textField.tag == EnSonAccountMangerTextfieldTag4)
	{
        //性别
        [self returnkey];
        [self clickselectsex];
		return NO;
	}
	else if(textField.tag == EnSonAccountMangerTextfieldTag5)
	{
		//生日
		[self returnkey];
		[self clickselecttime];
		return NO;
	}
    else if(textField.tag == EnSonAccountMangerTextfieldTag8)
    {
        [self returnkey];
        SonAccountAuthorizeViewController *sonaccount = [[SonAccountAuthorizeViewController alloc] init];
        sonaccount.delegate1 = self;
        sonaccount.FCfromflag = @"1";  //修改字账户权限 用1
        [self.navigationController pushViewController:sonaccount animated:YES];
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
    FCmonth = [NSString stringWithFormat:@"%2d",(int)month];
    FCday = [NSString stringWithFormat:@"%2d",(int)day];
	UITextField *textfield = [tableview viewWithTag:EnSonAccountMangerTextfieldTag5];
	textfield.text = text;
	
}

#pragma mark Actiondelegate
-(void)DGSaveSonAccountFunctionAuthorList:(id)sender
{
    FCarrayauthorization = sender;
}

#pragma mark 弹窗求
-(void)clickselectsex   //选择性别
{
	NSArray *usertypes = @[@"男",@"女"];
	[ZJBLStoreShopTypeAlert showWithTitle:@"请选择用户性别" titles:usertypes deleGate1:self selectIndex:^(NSInteger selectIndex) {
	} selectValue:^(NSString *selectValue) {
		DLog(@"selectvalue====%@",selectValue);
		UITextField *textfield = [tableview viewWithTag:EnSonAccountMangerTextfieldTag4];
		textfield.text = selectValue;
	} showCloseButton:YES];
}

#pragma mark 图片请求
-(void)picupload
{
    UIImageView *imageview = [tableview viewWithTag:EnUserCenterSonAccountHeaderPicTag];
    [JPhotoMagenage getOneImageInController:self finish:^(UIImage *images) {
        NSLog(@"%@",images);
        UIImage *image = [AddInterface scaleToSize:images size:CGSizeMake(800, 800)];
        imageview.image = image;
        FCimage = image;
        
    } cancel:^{
        
    }];
}

#pragma mark IBaction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)clickdelete:(id)sender
{
    
}

-(void)createsonaccount:(id)sender
{
    UITextField *textfield1 = [self.view viewWithTag:EnSonAccountMangerTextfieldTag1];//电话
    UITextField *textfield2 = [self.view viewWithTag:EnSonAccountMangerTextfieldTag2];//姓名
    UITextField *textfield3 = [self.view viewWithTag:EnSonAccountMangerTextfieldTag3];//用户类型
    UITextField *textfield4 = [self.view viewWithTag:EnSonAccountMangerTextfieldTag4];//性别
    UITextField *textfield5 = [self.view viewWithTag:EnSonAccountMangerTextfieldTag5];//生日
    UITextField *textfield6 = [self.view viewWithTag:EnSonAccountMangerTextfieldTag6];//登录密码
    UITextField *textfield7 = [self.view viewWithTag:EnSonAccountMangerTextfieldTag7];//职务显示
    DLog(@"textfield===%@,%@,%@,%@,%@,%@,%@",textfield1.text,textfield2.text,textfield3.text,textfield4.text,textfield5.text,textfield6.text,textfield7.text);
    if(([textfield1.text length]==0)||([textfield2.text length]==0)||([textfield3.text length]==0)||([textfield4.text length]==0)||([textfield5.text length]==0)||([textfield6.text length]==0)||([textfield7.text length]==0))
    {
        [MBProgressHUD showError:@"请填写子账户信息" toView:app.window];
    }
    else if(FCimage == nil)
    {
        [MBProgressHUD showError:@"请上传头像" toView:app.window];
    }
    else if([FCarrayauthorization count]==0)
    {
        [MBProgressHUD showError:@"请选择授权功能" toView:app.window];
    }
    else
    {
        FCtel = textfield1.text;
        FCname = textfield2.text;
        FCsex = textfield4.text;
        FCpwd = textfield6.text;
        FCjobtitle = textfield7.text;
        [self crateaccountinterface];
  //      [self uploadcustompic:FCimage];
        
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
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.row == 7)
		return 50;
	return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 9;
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
    
        
	labelname.font = FONTN(14.0f);
	
	
	UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, SCREEN_WIDTH-140, 30)];
	textfield.textColor = [UIColor blackColor];
	textfield.backgroundColor = [UIColor clearColor];
	textfield.font = FONTN(14.0f);
	textfield.delegate = self;
	if([_FCisedit isEqualToString:@"NO"])
        textfield.enabled = NO;
	
	UIImageView *imageheader;

	switch (indexPath.row)
	{
			
		case 0:
			labelname.text = @"手机号码";
			[cell.contentView addSubview:labelname];
			
		//	textfield.text = @"138****8888";
//			textfield.enabled = NO;
			textfield.textColor = COLORNOW(117, 117, 117);
			textfield.tag = EnSonAccountMangerTextfieldTag1;
			[cell.contentView addSubview:textfield];
			break;
		case 1:
			labelname.text = @"真实姓名";
			[cell.contentView addSubview:labelname];
			
		//	textfield.text = @"李明";
		//	textfield.enabled = NO;
			textfield.tag = EnSonAccountMangerTextfieldTag2;
			[cell.contentView addSubview:textfield];
			break;
		case 2:
			labelname.text = @"用户类型";
			[cell.contentView addSubview:labelname];
			
			textfield.placeholder = @"总经销 子账户";
            textfield.text = FCusertype;
            textfield.enabled = NO;
			textfield.tag = EnSonAccountMangerTextfieldTag3;
			[cell.contentView addSubview:textfield];
			break;
		case 3:
			labelname.text = @"性别";
			[cell.contentView addSubview:labelname];
			
		//	textfield.text = @"男";
			textfield.tag = EnSonAccountMangerTextfieldTag4;
			[cell.contentView addSubview:textfield];
			break;
		case 4:
			labelname.text = @"生日";
			[cell.contentView addSubview:labelname];
			
		//	textfield.text = @"1985-05-18";
			textfield.tag = EnSonAccountMangerTextfieldTag5;
			[cell.contentView addSubview:textfield];
			break;
		case 5:
			labelname.text = @"登录密码";
			[cell.contentView addSubview:labelname];
			
		//	textfield.text = @"******";
            textfield.secureTextEntry = YES;
			textfield.tag = EnSonAccountMangerTextfieldTag6;
			[cell.contentView addSubview:textfield];
			break;
		case 6:
			labelname.text = @"职务显示";
			[cell.contentView addSubview:labelname];
			
		//	textfield.text = @"营销总监";
			textfield.tag = EnSonAccountMangerTextfieldTag7;
			[cell.contentView addSubview:textfield];
			break;
		case 7:
			labelname.text = @"头像";
			[cell.contentView addSubview:labelname];
			
			imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, 30, 30)];
			imageheader.image = LOADIMAGE(@"userhedergray", @"png");
			imageheader.layer.cornerRadius = 15.0f;
            imageheader.tag = EnUserCenterSonAccountHeaderPicTag;
			imageheader.clipsToBounds = YES;
			[cell.contentView addSubview:imageheader];
			break;
		case 8:
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			labelname.text = @"授权功能";
			[cell.contentView addSubview:labelname];
			
		//	textfield.text = @"营销总监";
			textfield.tag = EnSonAccountMangerTextfieldTag8;
			[cell.contentView addSubview:textfield];
			break;
	}
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.row == 7)
    {
        [self picupload];
    }
}


#pragma mark 接口
-(void)uploadcustompic:(UIImage *)image
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //    params[@"meetingcontent"] = @"测试内容。。。。。。。";
    
    NSMutableArray *arrayimage = [[NSMutableArray alloc] init];
    [arrayimage addObject:image];
    
    
    [RequestInterface doGetJsonWithArraypic:arrayimage Parameter:params App:app RequestCode:RQUploadCustomPicCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCpicpath = [[[dic objectForKey:@"data"] objectForKey:@"pictureinfo"] objectForKey:@"picturesavenames"];
            [self crateaccountinterface];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
        
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
    }];
}

-(void)getsonaccountusertype
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:REUserCenterAddSonAccountUserTypeCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCusertypeid = [[[dic objectForKey:@"data"] objectForKey:@"subaccountusertypeinfo"] objectForKey:@"id"];
            FCusertype = [[[dic objectForKey:@"data"] objectForKey:@"subaccountusertypeinfo"] objectForKey:@"name"];
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

-(void)deletesonaccount
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"personid"] = _FCpersonid;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQUserCenterDeleteSonAccountCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
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

-(void)crateaccountinterface
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobilenumber"] = FCtel;
    params[@"realname"] = FCname;
    params[@"sex"] = @"male";//FCsex;
    params[@"birthday"] = FCday;
    params[@"birthmonth"] = FCmonth;
    params[@"birthyear"] = FCyear;
    params[@"password"] = FCpwd;
    params[@"jobtitle"] = FCjobtitle;
    params[@"thumbpicture"] = @"123";//FCpicpath;
    params[@"authorizationlist"] = [AddInterface DataTOjsonString:FCarrayauthorization];
    params[@"usertypeid"] = FCusertypeid;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:REUserCenterAddSonAccountCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:app.window];
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
