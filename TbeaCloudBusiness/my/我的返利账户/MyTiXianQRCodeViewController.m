//
//  MyTiXianQRCodeViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyTiXianQRCodeViewController.h"

@interface MyTiXianQRCodeViewController ()

@end

@implementation MyTiXianQRCodeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //去除导航栏下方的横线
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
    //	[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.title = @"提现凭证";
    [self getmytixianqrcode];
    UIImage* img=LOADIMAGE(@"returnback", @"png");
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    [button setImage:img forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
    [buttonright setTitle:@"删除" forState:UIControlStateNormal];
    buttonright.titleLabel.font = FONTN(14.0f);
    [buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonright addTarget:self action: @selector(deletetixiancode:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright addSubview:buttonright];
    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    self.navigationItem.rightBarButtonItem = barButtonItemright;
    // Do any additional setup after loading the view.
}

-(void)initview:(NSDictionary *)dic
{
    NSDictionary *dicmoneyinfo = [dic objectForKey:@"takemoneyinfo"];
    //	NSDictionary *dicdistributorinfo = [dic objectForKey:@"distributorinfo"];
    
    UIImageView *imageviewbg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH-20, SCREEN_HEIGHT-84-40)];
    imageviewbg.backgroundColor = COLORNOW(0, 170, 238);
    [self.view addSubview:imageviewbg];
    
    //二维码之上
    UIImageView *imageviewxuxian1 = [[UIImageView alloc] initWithFrame:CGRectMake(imageviewbg.origin.x, imageviewbg.frame.origin.y+50, imageviewbg.frame.size.width, 0.5)];
    imageviewxuxian1.backgroundColor = COLORNOW(200, 200, 200);
    [self.view addSubview:imageviewxuxian1];
    
    UIImageView *imageviewpoint1 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-30, imageviewbg.frame.origin.y-30, 60, 60)];
    imageviewpoint1.layer.cornerRadius = 30.0f;
    imageviewpoint1.clipsToBounds = YES;
    imageviewpoint1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageviewpoint1];
    
    
    UIImageView *imageviewxuxian2 = [[UIImageView alloc] initWithFrame:CGRectMake(imageviewxuxian1.frame.origin.x, imageviewxuxian1.frame.origin.y+80, imageviewxuxian1.frame.size.width, 0.5)];
    
    [self.view addSubview:imageviewxuxian2];
    
    //数据
    UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(imageviewbg.frame.origin.x+imageviewbg.frame.size.width-150, imageviewbg.frame.origin.y+20, 140, 20)];
    labeltime.textColor = [UIColor whiteColor];
    labeltime.font = FONTN(14.0f);
    labeltime.text = [NSString stringWithFormat:@"有效期:%@",[dicmoneyinfo objectForKey:@"validexpiredtime"]];
    labeltime.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:labeltime];
    
    UILabel *labelcode = [[UILabel alloc] initWithFrame:CGRectMake(20, imageviewxuxian1.frame.origin.y+20, 90, 20)];
    labelcode.textColor = [UIColor whiteColor];
    labelcode.font = FONTN(15.0f);
    labelcode.text = @"验证码";
    [self.view addSubview:labelcode];
    
    UILabel *labelnumber = [[UILabel alloc] initWithFrame:CGRectMake(100, XYViewTop(labelcode), 200, 20)];
    labelnumber.textColor = [UIColor whiteColor];
    labelnumber.font = FONTN(16.0f);
    labelnumber.text = [dicmoneyinfo objectForKey:@"takemoneycode"];
    [self.view addSubview:labelnumber];
    
    
    UILabel *labeltixian = [[UILabel alloc] initWithFrame:CGRectMake(20, XYViewBottom(labelcode)+5, 90, 20)];
    labeltixian.textColor = [UIColor whiteColor];
    labeltixian.font = FONTN(15.0f);
    labeltixian.text = @"提现金额";
    [self.view addSubview:labeltixian];
    
    
    UILabel *lablemoneyflag2 = [[UILabel alloc] initWithFrame:CGRectMake(100, XYViewTop(labeltixian)+3, 10,10)];
    lablemoneyflag2.text = @"￥";
    lablemoneyflag2.font = FONTMEDIUM(11.0f);
    lablemoneyflag2.textColor = [UIColor whiteColor];
    lablemoneyflag2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lablemoneyflag2];
    
    UILabel *labelmoney = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(lablemoneyflag2),XYViewTop(labeltixian), labeltixian.frame.size.width, 20)];
    labelmoney.text =  [NSString stringWithFormat:@"%@",[dicmoneyinfo objectForKey:@"money"]];
    labelmoney.font = FONTMEDIUM(16.0f);
    labelmoney.textColor = [UIColor whiteColor];
    labelmoney.backgroundColor = [UIColor clearColor];
    [self.view addSubview:labelmoney];
    
    UIImageView *imageviewqrcode = [[UIImageView alloc] initWithFrame:CGRectMake(100, XYViewBottom(imageviewxuxian2)+10, SCREEN_WIDTH-200, SCREEN_WIDTH-200)];
    NSURL *urlstr = [NSURL URLWithString:[dicmoneyinfo objectForKey:@"qrcodepicture"]];
    [imageviewqrcode setImageWithURL:urlstr];
    [self.view addSubview:imageviewqrcode];
    
    
    UILabel *labeladdr = [[UILabel alloc] initWithFrame:CGRectMake(20, XYViewBottom(imageviewqrcode)+30, 200, 20)];
    labeladdr.textColor = [UIColor whiteColor];
    labeladdr.font = FONTN(15.0f);
    labeladdr.text = [NSString stringWithFormat:@"提现单位:%@",[[dic objectForKey:@"distributorinfo"] objectForKey:@"name"]];
    [self.view addSubview:labeladdr];
    
    //下面两要线
    float nowspace = 10;
    if(iphone6)
        nowspace = 60;
    else if(iphone6p)
        nowspace = 80;
    UIImageView *imageviewline1 = [[UIImageView alloc] initWithFrame:CGRectMake(imageviewxuxian1.origin.x, XYViewBottom(labeladdr)+10, imageviewxuxian1.frame.size.width, 0.5)];
    imageviewline1.backgroundColor = Colorgray;
    [self.view addSubview:imageviewline1];
    
    UILabel *labeldes = [[UILabel alloc] initWithFrame:CGRectMake(imageviewbg.frame.origin.x+10, imageviewline1.frame.origin.y+5, imageviewbg.frame.size.width-20, 80)];
    labeldes.textColor = [UIColor whiteColor];
    labeldes.font = FONTN(14.0f);
    labeldes.numberOfLines = 5;
    labeldes.text = [dicmoneyinfo objectForKey:@"note"];
    [self.view addSubview:labeldes];
    
    //	[self getmyincome:@"1" Pagesize:@"10"];
    
}

#pragma mark IBaction
-(void)returnback
{
    [timertixian invalidate];
    timertixian = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)gototixiandone:(id)sender
{
 //   [self getmytixianstatus];
}

-(void)deletetixiancode:(id)sender
{
    [self deletewalletcode:[[dicmytixian objectForKey:@"takemoneyinfo"] objectForKey:@"id"]];
}

#pragma mark 接口
-(void)getmytixianqrcode
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.tixianmoney forKey:@"money"];
    [params setObject:self.strdistribuid forKey:@"distributorid"];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQMyTiXianMoneyCreateQRCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            if([[dic objectForKey:@"success"] isEqualToString:@"true"])
            {
                dicmytixian = [dic objectForKey:@"data"];
                [self initview:dicmytixian];
                
                timertixian = [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(gototixiandone:) userInfo:nil repeats:YES];
                
            }
            else
            {
                [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
            }
            
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
    }];
    
}


-(void)deletewalletcode:(NSString *)code
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:code forKey:@"takemoneyqrcodeid"];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQMyTiXianQRRemoveCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            if([[dic objectForKey:@"success"] isEqualToString:@"true"])
            {
                [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
                [self returnback];
                
            }
            else
            {
                [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
            }
            
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
    }];
    
}

//-(void)deletewalletcode:(NSString *)code
//{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:code forKey:@"takemoneycodeid"];
//    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:@"TBEAENG005001210000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
//     {
//         
//     }
//                                          Success:^(NSDictionary *dic)
//     {
//         DLog(@"dic====%@",dic);
//         if([[dic objectForKey:@"success"] isEqualToString:@"true"])
//         {
//             [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
//             [self returnback];
//         }
//         else
//         {
//             [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
//         }
//     }];
//    
//}



//-(void)getmytixianstatus
//{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:[[dicmytixian objectForKey:@"mymoneyinfo"] objectForKey:@"takemoneycode"] forKey:@"takemoneycode"];
//    [RequestInterface doGetJsonWithParametersNoAn1:params App:app RequestCode:@"TBEAENG005001110000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
//     {
//         
//     }
//                                           Success:^(NSDictionary *dic)
//     {
//         DLog(@"dic====%@",dic);
//         if([[dic objectForKey:@"success"] isEqualToString:@"true"])
//         {
//             [timertixian invalidate];
//             timertixian = nil;
//             MyTiXianDoneViewController *tixiandone =  [[MyTiXianDoneViewController alloc] init];
//             tixiandone.dicfrom = [[dic objectForKey:@"data"] objectForKey:@"takemoneyinfo"];
//             tixiandone.fromflag = @"1";
//             [self.navigationController pushViewController:tixiandone animated:YES];
//         }
//         else
//         {
//             
//         }
//     }];
//}

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
