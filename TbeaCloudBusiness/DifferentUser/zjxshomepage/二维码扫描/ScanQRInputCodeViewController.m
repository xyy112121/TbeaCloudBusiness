//
//  ScanQRInputCodeViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ScanQRInputCodeViewController.h"

@interface ScanQRInputCodeViewController ()

@end

@implementation ScanQRInputCodeViewController

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
    self.title = @"输入编码";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.navigationController setNavigationBarHidden:NO];

    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 60, SCREEN_WIDTH-20, 0.7)];
    line1.backgroundColor = COLORNOW(200, 200, 200);
    [self.view addSubview:line1];
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(20, 24, SCREEN_WIDTH-40, 35)];
    textfield.backgroundColor = [UIColor clearColor];
    textfield.delegate = self;
    textfield.font = FONTN(14.0f);
    textfield.tag = EnScanQRCodeInputCodeTextfieldTag;
    textfield.placeholder = @"请输入编码";
    [self.view addSubview:textfield];
    
    UIButton *buttonloging = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonloging.frame = CGRectMake(20, XYViewBottom(line1)+20, SCREEN_WIDTH-40, 40);
    buttonloging.layer.cornerRadius = 3.0f;
    buttonloging.backgroundColor = COLORNOW(0, 170, 238);
    buttonloging.clipsToBounds = YES;
    [buttonloging setTitle:@"确定" forState:UIControlStateNormal];
    [buttonloging setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonloging.titleLabel.font = FONTN(15.0f);
    [buttonloging addTarget:self action:@selector(clickdone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonloging];
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

#pragma mark IBaction
-(void)clickdone:(id)sender
{
    UITextField *textfield = [self.view viewWithTag:EnScanQRCodeInputCodeTextfieldTag];
    if([textfield.text length]>0)
    {
        [self getscanrebatelist:[NSString stringWithFormat:@"tbscrfl_%@",textfield.text]];
    }
    else
    {
        [MBProgressHUD showError:@"二维码无效果" toView:app.window];
    }

}

-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 接口
-(void)getscanrebatelist:(NSString *)strcode
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"qrcode"]= strcode;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQScanQRCodeInfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            ScanQRZhiFuDoneViewController *scanqrzhifu = [[ScanQRZhiFuDoneViewController alloc] init];
            scanqrzhifu.FCdicscancodedetail = [[dic objectForKey:@"data"] objectForKey:@"takemoneyinfo"];
            [self.navigationController pushViewController:scanqrzhifu animated:YES];
            
        }
        else
        {
            
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
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
