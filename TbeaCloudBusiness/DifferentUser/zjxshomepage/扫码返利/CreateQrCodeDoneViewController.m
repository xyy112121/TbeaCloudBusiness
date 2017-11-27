//
//  CreateQrCodeDoneViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/7/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "CreateQrCodeDoneViewController.h"

@interface CreateQrCodeDoneViewController ()

@end

@implementation CreateQrCodeDoneViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self initview];
	
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	button.layer.borderColor = [UIColor clearColor].CGColor;
	[button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
	button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
	[button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	
	UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
	UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
	buttonright.titleLabel.font = FONTN(14.0f);
	[buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[buttonright setTitle:@"查看" forState:UIControlStateNormal];
	buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
	[buttonright addTarget:self action: @selector(ClickLook:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewright addSubview:buttonright];
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
	// Do any additional setup after loading the view.
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



-(void)initview
{
	self.view.backgroundColor = [UIColor whiteColor];
	self.title = @"生成返利二维码";
	//初始化注册按钮之上
	[self initviewtop];
	
	//初始化按钮之下
	[self initviewunder];
	
}

-(void)initviewtop
{
	UIImageView *imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-70)/2, 50, 70, 70)];
	imageviewicon.image = LOADIMAGE(@"userdone", @"png");
	[self.view addSubview:imageviewicon];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(imageviewicon), XYViewBottom(imageviewicon)+5, XYViewWidth(imageviewicon), 20)];
	labelname.text = @"生成成功";
	labelname.font = FONTN(16.0f);
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textAlignment = NSTextAlignmentCenter;
	labelname.textColor = [UIColor blackColor];
	[self.view addSubview:labelname];
}

-(void)initviewunder
{
	UIButton *buttonloging = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonloging.frame = CGRectMake(30, SCREEN_HEIGHT-60-StatusBarAndNavigationHeight-100, SCREEN_WIDTH-60, 40);
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
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)clickdone
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)ClickLook:(id)sender
{
	CreqteQRCodeListViewController *codelist = [[CreqteQRCodeListViewController alloc] init];
	codelist.FCcreateid = self.FCcreateid;
	[self.navigationController pushViewController:codelist animated:YES];
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
