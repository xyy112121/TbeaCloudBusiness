//
//  RegiestPageViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/9.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "RegiestPageViewController.h"

@interface RegiestPageViewController ()

@end

@implementation RegiestPageViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self initview];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:YES animated:NO];
}



-(void)initview
{
	[self.navigationController setNavigationBarHidden:YES];
	self.view.backgroundColor = COLORNOW(0, 170, 238);
	getyanzhengcodeflag = 0;
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	//初始化注册按钮之上
	[self initviewtop];
	
	//初始化按钮之下
	[self initviewunder];
	
	//返回按钮和标题
	UIButton *buttonback = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonback.frame = CGRectMake(10, 22, 40, 40);
	buttonback.backgroundColor = [UIColor clearColor];
	[buttonback setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
	[buttonback addTarget:self action:@selector(returnback:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttonback];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(50, XYViewTop(buttonback), SCREEN_WIDTH-100, 40)];
	labelname.text = @"注册";
	labelname.font = FONTN(16.0f);
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textAlignment = NSTextAlignmentCenter;
	labelname.textColor = [UIColor whiteColor];
	[self.view addSubview:labelname];
    [self getusertype];
}

-(void)initviewtop
{
	UIView *viewtop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenHeight/2)];
	viewtop.backgroundColor = [UIColor clearColor];
	

	//输入框
	UIView *inputview = [[UIView alloc] initWithFrame:CGRectMake(30, XYViewHeight(viewtop)-200, SCREEN_WIDTH-60, 200)];
	inputview.backgroundColor = [UIColor clearColor];
	[viewtop addSubview:inputview];
	
	UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, XYViewWidth(inputview), 0.7)];
	imageline.backgroundColor = [UIColor whiteColor];
	[inputview addSubview:imageline];
	
	UIImageView *imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 99, XYViewWidth(inputview), 0.7)];
	imageline1.backgroundColor = [UIColor whiteColor];
	[inputview addSubview:imageline1];
	
	UIImageView *imageline2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 149, XYViewWidth(inputview), 0.7)];
	imageline2.backgroundColor = [UIColor whiteColor];
	[inputview addSubview:imageline2];
	
	UIImageView *imageline3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 199, XYViewWidth(inputview), 0.7)];
	imageline3.backgroundColor = [UIColor whiteColor];
	[inputview addSubview:imageline3];
	
	//电话
	UIImageView *imageviewphone = [[UIImageView alloc] initWithFrame:CGRectMake(6, XYViewTop(imageline)-35, 13, 20)];
	imageviewphone.image = LOADIMAGE(@"userphone", @"png");
	[inputview addSubview:imageviewphone];
	
	UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(50, XYViewTop(imageviewphone)-5, XYViewWidth(inputview)-60, 30)];
	textfield.placeholder = @"输入手机号";
	textfield.font = FONTN(15.0f);
	textfield.textColor = [UIColor whiteColor];
	textfield.tag = EnUserRegiestTextfield1;
	[textfield setValue:COLORNOW(230, 230, 230) forKeyPath:@"_placeholderLabel.textColor"];
	[inputview addSubview:textfield];
	
	//验证码
	UIImageView *imageviewcode = [[UIImageView alloc] initWithFrame:CGRectMake(3, XYViewTop(imageline1)-30, 20, 9)];
	imageviewcode.image = LOADIMAGE(@"usercode", @"png");
	[inputview addSubview:imageviewcode];
	
	UITextField *textfieldcode = [[UITextField alloc] initWithFrame:CGRectMake(50, XYViewTop(imageline1)-40, 100, 30)];
	textfieldcode.placeholder = @"验证码";
	textfieldcode.font = FONTN(15.0f);
	textfieldcode.textColor = [UIColor whiteColor];
	textfieldcode.tag = EnUserRegiestTextfield2;
	[textfieldcode setValue:COLORNOW(230, 230, 230) forKeyPath:@"_placeholderLabel.textColor"];
	[inputview addSubview:textfieldcode];
	
	UIButton *buttoncode = [UIButton buttonWithType:UIButtonTypeCustom];
	buttoncode.frame = CGRectMake(XYViewR(imageline3)-80, XYViewTop(textfieldcode), 80, 30);
	buttoncode.backgroundColor = [UIColor clearColor];
	[buttoncode setTitle:@"获取验证码" forState:UIControlStateNormal];
	[buttoncode addTarget:self action:@selector(clickgetcode:) forControlEvents:UIControlEventTouchUpInside];
	[buttoncode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	buttoncode.tag = EnUserRegiestGetCodeBt5;
	buttoncode.titleLabel.font = FONTN(14.0f);
	[inputview addSubview:buttoncode];
	
	//密码
	UIImageView *imageviewpwd = [[UIImageView alloc] initWithFrame:CGRectMake(5,XYViewBottom(imageline2)-35, 16, 20)];
	imageviewpwd.image = LOADIMAGE(@"userpwd", @"png");
	[inputview addSubview:imageviewpwd];
	
	UITextField *textfield1 = [[UITextField alloc] initWithFrame:CGRectMake(50, XYViewTop(imageviewpwd)-5, XYViewWidth(inputview)-60, 30)];
	textfield1.placeholder = @"密码";
	textfield1.font = FONTN(15.0f);
    textfield1.secureTextEntry = YES;
	textfield1.textColor = [UIColor whiteColor];
	textfield1.tag = EnUserRegiestTextfield3;
	[textfield1 setValue:COLORNOW(230, 230, 230) forKeyPath:@"_placeholderLabel.textColor"];
	[inputview addSubview:textfield1];
	
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(XYViewWidth(inputview)-40, XYViewBottom(imageline1)+5, 40, 40)];
	[button setImage:LOADIMAGE(@"usereye", @"png") forState:UIControlStateNormal];
	[inputview addSubview:button];
	
	//用户类型
	UIImageView *imageviewutype = [[UIImageView alloc] initWithFrame:CGRectMake(4,XYViewBottom(imageline3)-35, 18, 20)];
	imageviewutype.image = LOADIMAGE(@"usertype", @"png");
	[inputview addSubview:imageviewutype];
	
	UITextField *textfieldutype = [[UITextField alloc] initWithFrame:CGRectMake(50, XYViewTop(imageviewutype)-5, XYViewWidth(inputview)-60, 30)];
	textfieldutype.placeholder = @"用户类型";
	textfieldutype.font = FONTN(15.0f);
	textfieldutype.delegate = self;
	textfieldutype.textColor = [UIColor whiteColor];
	textfieldutype.tag = EnUserRegiestTextfield4;
	[textfieldutype setValue:COLORNOW(230, 230, 230) forKeyPath:@"_placeholderLabel.textColor"];
	[inputview addSubview:textfieldutype];
	
	UIButton *buttonutyperight = [[UIButton alloc] initWithFrame:CGRectMake(XYViewWidth(inputview)-40, XYViewBottom(imageline2)+5, 40, 40)];
	[buttonutyperight setImage:LOADIMAGE(@"userarrowright", @"png") forState:UIControlStateNormal];
	[inputview addSubview:buttonutyperight];
	
	[self.view addSubview:viewtop];
}

-(void)initviewunder
{
	UIView *viewunder = [[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
	viewunder.backgroundColor = [UIColor clearColor];
	[self.view addSubview:viewunder];
	
	UIButton *buttonloging = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonloging.frame = CGRectMake(30, 40, SCREEN_WIDTH-60, 40);
	buttonloging.layer.cornerRadius = 3.0f;
	buttonloging.backgroundColor = [UIColor whiteColor];
	buttonloging.clipsToBounds = YES;
	[buttonloging setTitle:@"注册" forState:UIControlStateNormal];
	[buttonloging addTarget:self action:@selector(clickregiest) forControlEvents:UIControlEventTouchUpInside];
	[buttonloging setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
	buttonloging.titleLabel.font = FONTN(15.0f);
	[viewunder addSubview:buttonloging];
	
	UIButton *buttonleft = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonleft.frame = CGRectMake(30, XYViewBottom(buttonloging)+20, 40, 40);
	buttonleft.backgroundColor = [UIColor clearColor];
	[buttonleft setImage:LOADIMAGE(@"userselectd", @"png") forState:UIControlStateNormal];
	[buttonleft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
	[viewunder addSubview:buttonleft];
	
	UILabel *labeldes = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(buttonleft)-20, XYViewTop(buttonleft)+10, 200, 20)];
	labeldes.text = @"注册即同意用户协议";
	labeldes.font = FONTN(14.0f);
	labeldes.backgroundColor = [UIColor clearColor];
	labeldes.textColor = [UIColor whiteColor];
	[viewunder addSubview:labeldes];
	
}

#pragma markd textfielddelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if(textField.tag == EnUserRegiestTextfield4)
	{
		[self clickselectusertype];
		return NO;
	}
	return YES;
}

#pragma mark 弹窗求
-(void)clickselectusertype
{
    NSMutableArray *arrayuser = [[NSMutableArray alloc] init];
    for(int i=0;i<[FCarrayusertype count];i++)
    {
        NSDictionary *dicuser = [FCarrayusertype objectAtIndex:i];
        [arrayuser addObject:[dicuser objectForKey:@"name"]];
    }
//	NSArray *usertypes = @[@"用户1",@"用户2",@"用户三",@"用户4",@"用户5",@"用户6",@"用户7"];
	[ZJBLStoreShopTypeAlert showWithTitle:@"用户类型选择后将不能修改!" titles:arrayuser deleGate1:self selectIndex:^(NSInteger selectIndex) {
	} selectValue:^(NSString *selectValue) {
		DLog(@"selectvalue====%@",selectValue);
        
		UITextField *textfield = [self.view viewWithTag:EnUserRegiestTextfield4];
		textfield.text = selectValue;
        FCusertypeid = [AddInterface returnselectid:FCarrayusertype SelectValue:selectValue];
	} showCloseButton:YES];
}

#pragma mark IBaction
-(void)returnback:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)clickregiest
{
    UITextField *textfield = (UITextField *)[self.view viewWithTag:EnUserRegiestTextfield1];
    UITextField *textfield1 = (UITextField *)[self.view viewWithTag:EnUserRegiestTextfield2];
    UITextField *textfield2 = (UITextField *)[self.view viewWithTag:EnUserRegiestTextfield3];
    UITextField *textfield3 = (UITextField *)[self.view viewWithTag:EnUserRegiestTextfield4];
    if(([[textfield text] length]==0)||([[textfield1 text] length]==0)||([[textfield2 text] length]==0)||([[textfield3 text] length]==0))
    {
        [MBProgressHUD showError:@"请填写电话和密码" toView:self.view];
    }
    else if(![AddInterface isValidateMobile:textfield.text])
    {
        [MBProgressHUD showError:@"请填写正确格式的电话号码" toView:self.view];
    }
    else
    {
        [self returnkeytextfield];
        
        [self createregiest:textfield.text VerifyCode:textfield1.text Pwd:[AddInterface md5:textfield2.text] UserType:FCusertypeid];
    }

}

-(void)returnkeytextfield
{
	UITextField *textfield = (UITextField *)[self.view viewWithTag:EnUserRegiestTextfield1];
	UITextField *textfield1 = (UITextField *)[self.view viewWithTag:EnUserRegiestTextfield2];
	UITextField *textfield2 = (UITextField *)[self.view viewWithTag:EnUserRegiestTextfield3];
	UITextField *textfield3 = (UITextField *)[self.view viewWithTag:EnUserRegiestTextfield4];
	[textfield resignFirstResponder];
	[textfield1 resignFirstResponder];
	[textfield2 resignFirstResponder];
	[textfield3 resignFirstResponder];
}

-(void)clickgetcode:(id)sender
{
	if(getyanzhengcodeflag == 0)
	{
		UITextField *textfield1 = [self.view viewWithTag:EnUserRegiestTextfield1];
	
		if([[textfield1 text] length]==0)
		{
			[MBProgressHUD showError:@"请填写电话和密码" toView:self.view];
		}
		else if(![AddInterface isValidateMobile:textfield1.text])
		{
			[MBProgressHUD showError:@"请填写正确格式的电话号码" toView:self.view];
		}
		else
		{
			[self returnkeytextfield];
			getyanzhengcodeflag = 1;
			[self IFGetcode:textfield1.text ServiceCode:@"TBEAYUN003001002000"];
			timerone= [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updasecond:) userInfo:nil repeats:YES];
		}
	}
	
}

-(void)updasecond:(id)sender
{
	UIButton *button = (UIButton *)[self.view viewWithTag:EnUserRegiestGetCodeBt5];
	NSString *strtemp = [button currentTitle];
	if([strtemp length]== 5)
	{
		[button setTitle:@"重新获取60" forState:UIControlStateNormal];
	}
	else
	{
		NSString *strsecond = [strtemp substringFromIndex:4];
		strsecond = [strsecond substringToIndex:[strsecond length]];
		int second = [strsecond intValue];
		[button setTitle:[NSString stringWithFormat:@"重新获取%d",second-1] forState:UIControlStateNormal];
		if(second > 1)
		{
			
			button.enabled = NO;
		}
		else
		{
			getyanzhengcodeflag = 0;
			[button setTitle:@"获取验证码" forState:UIControlStateNormal];
			button.enabled = YES;
			[timerone invalidate];
			timerone = nil;
		}
	}
}

#pragma mark 接口
-(void)getusertype
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQRegiestGetUserTypeCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarrayusertype = [[dic objectForKey:@"data"] objectForKey:@"usertypelist"];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}

-(void)IFGetcode:(NSString *)phone ServiceCode:(NSString *)servicecode
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"mobilenumber"];
    [params setObject:servicecode forKey:@"servicecode"];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQGetAuthCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
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


-(void)createregiest:(NSString *)phone VerifyCode:(NSString *)verifycode Pwd:(NSString *)pwd UserType:(NSString *)usertype
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"mobilenumber"];
    [params setObject:pwd forKey:@"password"];
    [params setObject:verifycode forKey:@"verifycode"];
    [params setObject:usertype forKey:@"usertypeid"];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQGoRegiest ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            NSDictionary *dicuserinfo = [[dic objectForKey:@"data"] objectForKey:@"userinfo"];
            [dicuserinfo writeToFile:UserMessage atomically:NO];
            app.userinfo.userid = [dicuserinfo objectForKey:@"id"];
            app.userinfo.userpermission = [dicuserinfo objectForKey:@"whetheridentifiedid"];
            app.userinfo.usertel = [dicuserinfo objectForKey:@"mobile"];
            app.userinfo.username = [dicuserinfo objectForKey:@"name"];
            app.userinfo.userheader = [dicuserinfo objectForKey:@"name"];
            app.userinfo.usertype = [dicuserinfo objectForKey:@"usertypeid"];
            app.userinfo.useraccount = [dicuserinfo objectForKey:@"account"];
            
           	RegiestDonePageViewController *regiest = [[RegiestDonePageViewController alloc] init];
            [self.navigationController pushViewController:regiest animated:YES];
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
