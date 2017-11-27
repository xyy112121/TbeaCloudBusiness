//
//  ComCommitMettingDoneViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ComCommitMettingDoneViewController.h"

@interface ComCommitMettingDoneViewController ()

@end

@implementation ComCommitMettingDoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initview];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    button.layer.borderColor = [UIColor clearColor].CGColor;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
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
    self.title = @"发起成功";
    //初始化注册按钮之上
    [self initviewtop];
    
    //初始化按钮之下
    [self initviewunder];
    
}

-(void)initviewtop
{
    UIImageView *imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-70)/2, 50, 70, 70)];
    imageviewicon.image = LOADIMAGE(@"scanqrpaydone", @"png");
    [self.view addSubview:imageviewicon];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, XYViewBottom(imageviewicon)+5, 200, 20)];
    labelname.text = @"发起会议成功";
    labelname.font = FONTN(15.0f);
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textAlignment = NSTextAlignmentCenter;
    labelname.textColor = [UIColor blackColor];
    [self.view addSubview:labelname];
    
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, XYViewBottom(labelname)+20, SCREEN_WIDTH, 0.7)];
    imageline.backgroundColor = COLORNOW(227, 227, 227);
    [self.view addSubview:imageline];
    
    UILabel *labelins = [[UILabel alloc] initWithFrame:CGRectMake(20, XYViewBottom(imageline)+10, SCREEN_WIDTH-30, 120)];
    labelins.text = @"提示\n[发起状态]会议开始前24小时,可编辑,删除,不可更新\n[进行状态]会议开始至结束24小时内,可编辑,不可删除,更新\n[结束状态]会议结束后,可更新,不可编辑,删除";
    labelins.font = FONTN(13.0f);
    labelins.backgroundColor = [UIColor clearColor];
    labelins.numberOfLines = 6;
    labelins.textColor = COLORNOW(172, 172, 172);
    [self.view addSubview:labelins];
    
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)ClickLook:(id)sender
{
    ComMettingDetailLookViewController *comcomitdone = [[ComMettingDetailLookViewController alloc] init];
    comcomitdone.FCmettingid = self.FCmettingid;
    comcomitdone.FCfromflag = @"2";
    [self.navigationController pushViewController:comcomitdone animated:YES];
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
