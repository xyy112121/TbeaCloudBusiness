//
//  LoginPageViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/8.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "LoginPageViewController.h"

@interface LoginPageViewController ()

@end

@implementation LoginPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self initview];
    // Do any additional setup after loading the view.
}


-(void)initview
{
	[self.navigationController setNavigationBarHidden:YES];
	self.view.backgroundColor = COLORNOW(0, 170, 238);
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	//初始化按钮之前
	[self initviewtop];
	
	//初始化按钮之下
	[self initviewunder];
}

-(void)initviewtop
{
	UIView *viewtop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenHeight/2)];
	viewtop.backgroundColor = [UIColor clearColor];
	
	//头顶logo
	UIImageView *imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-102)/2,XYViewHeight(viewtop)/4-10, 102, 21)];
	imageviewicon.image = LOADIMAGE(@"tbeaicon", @"png");
	[viewtop addSubview:imageviewicon];
	
	//输入框
	UIView *inputview = [[UIView alloc] initWithFrame:CGRectMake(30, XYViewHeight(viewtop)/2, SCREEN_WIDTH-60, 100)];
	inputview.backgroundColor = [UIColor clearColor];
	[viewtop addSubview:inputview];
	
	UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, XYViewWidth(inputview), 1)];
	imageline.backgroundColor = [UIColor whiteColor];
	[inputview addSubview:imageline];
	
	UIImageView *imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 99, XYViewWidth(inputview), 1)];
	imageline1.backgroundColor = [UIColor whiteColor];
	[inputview addSubview:imageline1];
	
	//电话
	UIImageView *imageviewphone = [[UIImageView alloc] initWithFrame:CGRectMake(6, 15, 13, 20)];
	imageviewphone.image = LOADIMAGE(@"userphone", @"png");
	[inputview addSubview:imageviewphone];
	
	UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(50, 10, XYViewWidth(inputview)-60, 30)];
	textfield.placeholder = @"输入手机号";
	textfield.font = FONTN(15.0f);
	textfield.tag = EnLoginPhoneTextfield;
//	textfield.text = @"17780619820"; //总经销商
//    textfield.text = @"13220171001";  //分经销商
    textfield.text = @"13220170100";     //公司人员
//   textfield.text  = @"18669069389";
//    textfield.text = @"13220175001";//检修人员
	textfield.tintColor = [UIColor whiteColor];
	textfield.textColor = [UIColor whiteColor];
    textfield.clearButtonMode=UITextFieldViewModeWhileEditing;
	[textfield setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
	[inputview addSubview:textfield];
	
	//密码
	UIImageView *imageviewpwd = [[UIImageView alloc] initWithFrame:CGRectMake(5,XYViewBottom(imageline)+15, 16, 20)];
	imageviewpwd.image = LOADIMAGE(@"userpwd", @"png");
	[inputview addSubview:imageviewpwd];
	
	UITextField *textfield1 = [[UITextField alloc] initWithFrame:CGRectMake(50, XYViewTop(imageviewpwd)-5, XYViewWidth(inputview)-60, 30)];
	textfield1.tag = EnLoginPwdTextfield;
	textfield1.textColor = [UIColor whiteColor];
	textfield1.placeholder = @"密码";
	textfield1.font = FONTN(15.0f);
	textfield1.text = @"123456";
	textfield1.tintColor = [UIColor whiteColor];
    textfield1.clearsOnBeginEditing = YES;
	textfield1.secureTextEntry = YES;
	[textfield1 setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
	[inputview addSubview:textfield1];
	
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(XYViewWidth(inputview)-40, XYViewBottom(imageline)+5, 40, 40)];
	[button setImage:LOADIMAGE(@"usereye", @"png") forState:UIControlStateNormal];
	[inputview addSubview:button];
	
	[self.view addSubview:viewtop];
}

-(void)initviewunder
{
	UIView *viewunder = [[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT/2-20, SCREEN_WIDTH, SCREEN_HEIGHT/2+20)];
	viewunder.backgroundColor = [UIColor clearColor];
	[self.view addSubview:viewunder];
	
	UIButton *buttonloging = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonloging.frame = CGRectMake(30, 0, SCREEN_WIDTH-60, 40);
	buttonloging.layer.cornerRadius = 3.0f;
	buttonloging.backgroundColor = [UIColor whiteColor];
	buttonloging.clipsToBounds = YES;
	[buttonloging setTitle:@"登录" forState:UIControlStateNormal];
	[buttonloging setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
	buttonloging.titleLabel.font = FONTN(15.0f);
	[buttonloging addTarget:self action:@selector(clicklogin) forControlEvents:UIControlEventTouchUpInside];
	[viewunder addSubview:buttonloging];
	
	UIButton *buttonleft = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonleft.frame = CGRectMake(30, XYViewBottom(buttonloging)+20, 80, 40);
	buttonleft.backgroundColor = [UIColor clearColor];
	[buttonleft setTitle:@"找回密码" forState:UIControlStateNormal];
	[buttonleft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	buttonleft.titleLabel.font = FONTN(14.0f);
	[buttonleft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
	[viewunder addSubview:buttonleft];
	
	UIButton *buttonright = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonright.frame = CGRectMake(SCREEN_WIDTH-80-30, XYViewTop(buttonleft), 80, 40);
	buttonright.backgroundColor = [UIColor clearColor];
	[buttonright setTitle:@"注册" forState:UIControlStateNormal];
	[buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	buttonright.titleLabel.font = FONTN(14.0f);
	[buttonright addTarget:self action:@selector(gotoregiest) forControlEvents:UIControlEventTouchUpInside];
	[buttonright setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
	[viewunder addSubview:buttonright];
	
	//其它方式
	
	UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(30, XYViewBottom(buttonleft)+30, SCREEN_WIDTH/2-80, 1)];
	imageline.backgroundColor = [UIColor whiteColor];
	[viewunder addSubview:imageline];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageline), XYViewTop(imageline)-10, 100, 20)];
	labelname.text = @"其它方式登录";
	labelname.font = FONTN(14.0f);
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textAlignment = NSTextAlignmentCenter;
	labelname.textColor = [UIColor whiteColor];
	[viewunder addSubview:labelname];
	
	UIImageView *imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+50, XYViewTop(imageline), XYViewWidth(imageline), 1)];
	imageline1.backgroundColor = [UIColor whiteColor];
	[viewunder addSubview:imageline1];
	
	//微信登录
	UIButton *buttonwx = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonwx.frame = CGRectMake((SCREEN_WIDTH-50)/2, XYViewBottom(labelname)+30, 50, 50);
	buttonwx.backgroundColor = [UIColor clearColor];
	[buttonwx setImage:LOADIMAGE(@"userwxlogin", @"png") forState:UIControlStateNormal];
	[viewunder addSubview:buttonwx];
	
	UILabel *labelthree = [[UILabel alloc] initWithFrame:CGRectMake(100, XYViewBottom(buttonwx)+10, SCREEN_WIDTH-200, 20)];
	labelthree.text = @"微信";
	labelthree.font = FONTN(14.0f);
	labelthree.backgroundColor = [UIColor clearColor];
	labelthree.textColor = [UIColor whiteColor];
	labelthree.textAlignment = NSTextAlignmentCenter;
	[viewunder addSubview:labelthree];
	
}



#pragma mark IBAction
-(void)clicklogin
{
	UITextField *textfield1 = [self.view viewWithTag:EnLoginPhoneTextfield];
	UITextField *textfield2 = [self.view viewWithTag:EnLoginPwdTextfield];
	if(([textfield1.text length]==0)||[textfield2.text length] == 0)
	{
		[MBProgressHUD showError:@"请输入用户名密码" toView:app.window];
	}
	else if(![AddInterface isValidateMobile:textfield1.text])
	{
		[MBProgressHUD showError:@"请输入正确的电话号码" toView:app.window];
	}
	else
	{
//		if([textfield1.text isEqualToString:@"zjx"])
//			app.enappusertype = EnZJXUser;
//		else if([textfield1.text isEqualToString:@"fjx"])
//			app.enappusertype = EnFJXUser;
//		
//		if([self.delegate1 respondsToSelector:@selector(DGLoginSuccess:)])
//		{
//			[self.delegate1 DGLoginSuccess:nil];
//		}
//		[self.navigationController dismissViewControllerAnimated:YES completion:nil];
		
		[self IFLogin:textfield1.text Pwd:[AddInterface md5:textfield2.text]];
		
	}
	
	
}

-(void)gotoregiest
{
	RegiestPageViewController *regiest = [[RegiestPageViewController alloc] init];
	[self.navigationController pushViewController:regiest animated:YES];
}

#pragma mark 接口
-(void)IFLogin:(NSString *)tel Pwd:(NSString *)pwd
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:tel forKey:@"mobilenumber"];
	[params setObject:pwd forKey:@"userpas"];
	[params setObject:app.GBmachid forKey:@"devicetoken"];
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQLoginCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
		
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
            
			if([self.delegate1 respondsToSelector:@selector(DGLoginSuccess:)])
			{
				[self.delegate1 DGLoginSuccess:nil];
			}
			[self.navigationController dismissViewControllerAnimated:YES completion:nil];
			
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
