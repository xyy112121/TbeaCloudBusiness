//
//  RegiestDonePageViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/9.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "RegiestDonePageViewController.h"

@interface RegiestDonePageViewController ()

@end

@implementation RegiestDonePageViewController

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
	self.view.backgroundColor = [UIColor whiteColor];
	
	//初始化注册按钮之上
	[self initviewtop];
	
	//初始化按钮之下
	[self initviewunder];
	
	//返回按钮和标题
	UIImageView *imagetopbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, StatusBarAndNavigationHeight)];
	imagetopbg.backgroundColor = COLORNOW(0, 170, 238);
	[self.view addSubview:imagetopbg];
	
//	UIButton *buttonback = [UIButton buttonWithType:UIButtonTypeCustom];
//	buttonback.frame = CGRectMake(10, 22, 40, 40);
//	buttonback.backgroundColor = [UIColor clearColor];
//	[buttonback setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
//	[buttonback addTarget:self action:@selector(returnback:) forControlEvents:UIControlEventTouchUpInside];
//	[self.view addSubview:buttonback];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(50, StatusBarHeight+2, SCREEN_WIDTH-100, 40)];
	labelname.text = @"注册成功";
	labelname.font = FONTN(16.0f);
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textAlignment = NSTextAlignmentCenter;
	labelname.textColor = [UIColor whiteColor];
	[self.view addSubview:labelname];
}

-(void)initviewtop
{
	UIImageView *imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-70)/2, StatusBarAndNavigationHeight+50, 70, 70)];
	imageviewicon.image = LOADIMAGE(@"userdone", @"png");
	[self.view addSubview:imageviewicon];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(imageviewicon), XYViewBottom(imageviewicon)+5, XYViewWidth(imageviewicon), 20)];
	labelname.text = @"注册成功";
	labelname.font = FONTN(16.0f);
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textAlignment = NSTextAlignmentCenter;
	labelname.textColor = [UIColor blackColor];
	[self.view addSubview:labelname];
	
	UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, XYViewBottom(labelname)+20, SCREEN_WIDTH, 0.7)];
	imageline.backgroundColor = COLORNOW(200, 200, 200);
	[self.view addSubview:imageline];
	
	//提示
	UIImageView *imagealert = [[UIImageView alloc] initWithFrame:CGRectMake(20, XYViewBottom(imageline)+10, 18, 18)];
	imagealert.image = LOADIMAGE(@"useralert", @"png");
	[self.view addSubview:imagealert];
	
	UILabel *labelalert = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imagealert)+5, XYViewTop(imagealert)-1, 100, 20)];
	labelalert.text = @"提示";
	labelalert.font = FONTN(15.0f);
	labelalert.backgroundColor = [UIColor clearColor];
	labelalert.textColor = COLORNOW(137, 137, 137);
	[self.view addSubview:labelalert];
	
	NSString *alertstr = @"为建设诚信商业平台,商家须补全资料并进行实名认证才可使用系统完整功能";
	CGSize size = [AddInterface getlablesize:alertstr Fwidth:SCREEN_WIDTH-40 Fheight:60 Sfont:FONTN(14.0f)];
	UILabel *labelmsg = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(imagealert), XYViewBottom(imagealert)+3, size.width,size.height)];
	labelmsg.text = alertstr;
	labelmsg.font = FONTN(14.0f);
	labelmsg.numberOfLines = 0;
	labelmsg.backgroundColor = [UIColor clearColor];
	labelmsg.textColor = COLORNOW(187, 187, 187);
	[self.view addSubview:labelmsg];
}

-(void)initviewunder
{
	UIButton *buttonbuquan = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonbuquan.frame = CGRectMake(30, SCREEN_HEIGHT-120, SCREEN_WIDTH-60, 40);
	buttonbuquan.layer.cornerRadius = 3.0f;
	buttonbuquan.backgroundColor = COLORNOW(46, 204, 113);
	buttonbuquan.clipsToBounds = YES;
	[buttonbuquan setTitle:@"前往补全资料" forState:UIControlStateNormal];
	[buttonbuquan addTarget:self action:@selector(clickbuquan) forControlEvents:UIControlEventTouchUpInside];
	[buttonbuquan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	buttonbuquan.titleLabel.font = FONTN(16.0f);
	[self.view addSubview:buttonbuquan];
	
	UIButton *buttonloging = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonloging.frame = CGRectMake(30, SCREEN_HEIGHT-60, SCREEN_WIDTH-60, 40);
	buttonloging.layer.cornerRadius = 3.0f;
	buttonloging.backgroundColor = COLORNOW(0, 170, 238);
	buttonloging.clipsToBounds = YES;
	[buttonloging setTitle:@"完成" forState:UIControlStateNormal];
	[buttonloging addTarget:self action:@selector(clickdone) forControlEvents:UIControlEventTouchUpInside];
	[buttonloging setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	buttonloging.titleLabel.font = FONTN(16.0f);
	[self.view addSubview:buttonloging];
}

#pragma mark IBaction
-(void)returnback:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)clickbuquan
{
	UserInfoMakeUpViewController *userinfo = [[UserInfoMakeUpViewController alloc] init];
	[self.navigationController pushViewController:userinfo animated:YES];
}

-(void)clickdone
{
	[self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
