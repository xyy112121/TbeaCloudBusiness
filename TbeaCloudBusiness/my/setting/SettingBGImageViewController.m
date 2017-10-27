//
//  SettingBGImageViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "SettingBGImageViewController.h"

@interface SettingBGImageViewController ()

@end

@implementation SettingBGImageViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORNOW(240, 240, 240);
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
    [buttonright setTitle:@"删除" forState:UIControlStateNormal];
    buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
    [buttonright addTarget:self action: @selector(deletebgview:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright addSubview:buttonright];
    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    self.navigationItem.rightBarButtonItem = barButtonItemright;
}

-(void)initview
{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.title = @"设置背景";
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   
    imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 250)];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    [self.view addSubview:imageview];
    
    UIButton *buttonlibary = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonlibary.frame = CGRectMake(30, SCREEN_HEIGHT-64-120, SCREEN_WIDTH-60, 40);
    buttonlibary.layer.cornerRadius = 3.0f;
    buttonlibary.backgroundColor = [UIColor whiteColor];
    buttonlibary.clipsToBounds = YES;
    [buttonlibary setTitle:@"相册" forState:UIControlStateNormal];
    [buttonlibary setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
    buttonlibary.titleLabel.font = FONTN(15.0f);
    [buttonlibary addTarget:self action:@selector(clickselectlibary:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonlibary];
    
    UIButton *buttoncama = [UIButton buttonWithType:UIButtonTypeCustom];
    buttoncama.frame = CGRectMake(30, SCREEN_HEIGHT-64-60, SCREEN_WIDTH-60, 40);
    buttoncama.layer.cornerRadius = 3.0f;
    buttoncama.backgroundColor = [UIColor whiteColor];
    buttoncama.clipsToBounds = YES;
    [buttoncama setTitle:@"拍照" forState:UIControlStateNormal];
    [buttoncama setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
    buttoncama.titleLabel.font = FONTN(15.0f);
    [buttoncama addTarget:self action:@selector(clickselectcama:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttoncama];

}

#pragma mark IBAction
-(void)returnback
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)deletebgview:(id)sender
{
    [self deletebgimage];
}

-(void)clickselectlibary:(id)sender
{
    [JPhotoMagenage getTakeLibryImageInController:self finish:^(UIImage *images) {
        NSLog(@"%@",images);
        UIImage *image = [AddInterface scaleToSize:images size:CGSizeMake(800, 800)];
        imageview.image = image;
        NSMutableArray *arrayimage = [[NSMutableArray alloc] init];
        [arrayimage addObject:image];
        [self uploadcustompic:arrayimage];
    } cancel:^{
        
    }];
}

-(void)clickselectcama:(id)sender
{
    [JPhotoMagenage getTakePhotoImageInController:self finish:^(UIImage *images) {
        NSLog(@"%@",images);
        UIImage *image = [AddInterface scaleToSize:images size:CGSizeMake(800, 800)];
        imageview.image = image;
        NSMutableArray *arrayimage = [[NSMutableArray alloc] init];
        [arrayimage addObject:image];
        [self uploadcustompic:arrayimage];
    } cancel:^{
        
    }];
}

#pragma mark 接口  
-(void)commoitbgimage
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"picture"] = FCstrimagebg;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQUserCenterUploadBgImageCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
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

-(void)uploadcustompic:(NSArray *)arrayimage
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithArraypic:arrayimage Parameter:params App:app RequestCode:RQUploadCustomPicCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCstrimagebg = [[[dic objectForKey:@"data"] objectForKey:@"pictureinfo"] objectForKey:@"picturesavenames"];
            [self commoitbgimage];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
        
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
    }];
}


-(void)deletebgimage
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQUserCenterDeleteBgImageCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            [self returnback];
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
