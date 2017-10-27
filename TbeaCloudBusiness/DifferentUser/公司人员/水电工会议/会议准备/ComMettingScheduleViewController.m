//
//  ComMettingScheduleViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ComMettingScheduleViewController.h"

@interface ComMettingScheduleViewController ()

@end

@implementation ComMettingScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
    buttonright.titleLabel.font = FONTN(14.0f);
    [buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonright setTitle:@"保存" forState:UIControlStateNormal];
    buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
    [buttonright addTarget:self action: @selector(gotomettingsave:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright addSubview:buttonright];
    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    self.navigationItem.rightBarButtonItem = barButtonItemright;
    
    [self initview];
    
    // Do any additional setup after loading the view.
}

-(void)initview
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"会议安排";
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(18, 5, 40, 30)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = [UIColor blackColor];
    labelname.text = @"安排";
    labelname.clipsToBounds = YES;
    labelname.font = FONTMEDIUM(16.0f);
    [self.view addSubview:labelname];
    
//    UILabel *labelnumber = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-120, 5, 100, 30)];
//    labelnumber.backgroundColor = [UIColor clearColor];
//    labelnumber.textColor = [UIColor blackColor];
//    labelnumber.text = [NSString stringWithFormat:@"%d",0];
//    labelnumber.clipsToBounds = YES;
//    labelnumber.tag = EnComWaterJXSSelectNumberTag;
//    labelnumber.textAlignment = NSTextAlignmentRight;
//    labelnumber.font = FONTMEDIUM(15.0f);
//    [self.view addSubview:labelnumber];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.7)];
    imageline.backgroundColor = COLORNOW(220, 220, 220);
    [self.view addSubview:imageline];
    
    vbtextview = [[VBTextView alloc] initWithFrame:CGRectMake(15, XYViewBottom(imageline)+10, SCREEN_WIDTH-30, 200)];
    vbtextview.placeHolder = @"请输入内容";
    if([_FCmettingdes length]>0)
        vbtextview.text = _FCmettingdes;
    vbtextview.font = FONTN(15.0f);
    vbtextview.delegate = self;
    if([self.FCfromflag isEqualToString:@"0"])
        vbtextview.editable = NO;
    vbtextview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vbtextview];
    
    UIImageView *imagegray = [[UIImageView alloc] initWithFrame:CGRectMake(0, XYViewBottom(vbtextview)+10, SCREEN_WIDTH, 10)];
    imagegray.backgroundColor = COLORNOW(230, 230, 230);
    [self.view addSubview:imagegray];
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
#pragma mark IBAction
-(void)returnback
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)gotomettingsave:(id)sender
{
    if([self.delegate1 respondsToSelector:@selector(DGMettingScheduleDone:)])
    {
        [self.delegate1 DGMettingScheduleDone:vbtextview.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
