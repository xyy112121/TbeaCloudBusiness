//
//  ScanQRNoValidCodeViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/11.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ScanQRNoValidCodeViewController.h"

@interface ScanQRNoValidCodeViewController ()

@end

@implementation ScanQRNoValidCodeViewController

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
    self.title = @"提示";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //初始化注册按钮之上
    [self initviewtop];
    
    //初始化按钮之下
    [self initviewunder];
    
    
}

-(void)initviewtop
{
    UIImageView *imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2, 64+50, 60, 54)];
    imageviewicon.image = LOADIMAGE(@"scanqrnovalid", @"png");
    [self.view addSubview:imageviewicon];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-120)/2, XYViewBottom(imageviewicon)+5, 120, 20)];
    labelname.text = @"无效的二维码";
    labelname.font = FONTN(16.0f);
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textAlignment = NSTextAlignmentCenter;
    labelname.textColor = [UIColor blackColor];
    [self.view addSubview:labelname];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, XYViewBottom(labelname)+20, SCREEN_WIDTH, 0.7)];
    imageline.backgroundColor = COLORNOW(200, 200, 200);
    [self.view addSubview:imageline];
    
    //提示
//   NSString *alertstr = @"1.请确认二维码清晰可见交对准二维码扫描";
//    CGSize size = [AddInterface getlablesize:alertstr Fwidth:SCREEN_WIDTH-40 Fheight:60 Sfont:FONTN(14.0f)];
    UILabel *labelmsg = [[UILabel alloc] initWithFrame:CGRectMake(20, XYViewBottom(imageline)+10, SCREEN_WIDTH-25,20)];
    labelmsg.text = @"1.请确认二维码清晰可见交对准二维码扫描";;
    labelmsg.font = FONTN(14.0f);
    labelmsg.backgroundColor = [UIColor clearColor];
    labelmsg.textColor = COLORNOW(187, 187, 187);
    [self.view addSubview:labelmsg];
    
    UILabel *labelmsg1 = [[UILabel alloc] initWithFrame:CGRectMake(20, XYViewBottom(labelmsg),SCREEN_WIDTH-25,20)];
    labelmsg1.text = @"2.仅支持特变电工的返利二维码,其它无效";;
    labelmsg1.font = FONTN(14.0f);
    labelmsg1.backgroundColor = [UIColor clearColor];
    labelmsg1.textColor = COLORNOW(187, 187, 187);
    [self.view addSubview:labelmsg1];
}

-(void)initviewunder
{
    UIButton *buttondone = [UIButton buttonWithType:UIButtonTypeCustom];
    buttondone.frame = CGRectMake(30, SCREEN_HEIGHT-100-64, SCREEN_WIDTH-60, 40);
    buttondone.layer.cornerRadius = 3.0f;
    buttondone.backgroundColor = COLORNOW(0, 170, 238);
    buttondone.clipsToBounds = YES;
    [buttondone setTitle:@"完成" forState:UIControlStateNormal];
    [buttondone addTarget:self action:@selector(clickdone) forControlEvents:UIControlEventTouchUpInside];
    [buttondone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttondone.titleLabel.font = FONTN(16.0f);
    [self.view addSubview:buttondone];
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
