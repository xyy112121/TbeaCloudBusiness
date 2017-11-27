//
//  MallStoreTopImageViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/7.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MallStoreTopImageViewController.h"

@interface MallStoreTopImageViewController ()

@end

@implementation MallStoreTopImageViewController

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
    
    UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
    [buttonright setTitle:@"删除" forState:UIControlStateNormal];
    buttonright.titleLabel.font = FONTN(15.0f);
    [buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonright addTarget:self action: @selector(deletetopimage:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright addSubview:buttonright];
    buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    self.navigationItem.rightBarButtonItem = barButtonItemright;
    
    // Do any additional setup after loading the view.
}

-(void)initview
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"形象图";
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 250)];
    imageview.backgroundColor = [UIColor clearColor];
    imageview.clipsToBounds = YES;
    imageview.contentMode = UIViewContentModeScaleAspectFill;
//    NSString *strpic = [NSString stringWithFormat:@"%@%@",InterfaceResource,[FCuploadstrpic length]>0?FCuploadstrpic:@"123"];
//    [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"watertest", @"png")];
    [self.view addSubview:imageview];
    
    UIButton *buttonlibry = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonlibry.frame = CGRectMake(30, SCREEN_HEIGHT-StatusBarAndNavigationHeight-180, SCREEN_WIDTH-60, 40);
    buttonlibry.layer.cornerRadius = 3.0f;
    buttonlibry.backgroundColor = COLORNOW(0, 170, 238);
    buttonlibry.clipsToBounds = YES;
    [buttonlibry setTitle:@"相册" forState:UIControlStateNormal];
    [buttonlibry setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonlibry.titleLabel.font = FONTN(15.0f);
    [buttonlibry addTarget:self action:@selector(clicktakelibry) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonlibry];

    UIButton *buttonphoto = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonphoto.frame = CGRectMake(30, SCREEN_HEIGHT-StatusBarAndNavigationHeight-100, SCREEN_WIDTH-60, 40);
    buttonphoto.layer.cornerRadius = 3.0f;
    buttonphoto.backgroundColor = COLORNOW(0, 170, 238);
    buttonphoto.clipsToBounds = YES;
    [buttonphoto setTitle:@"拍照" forState:UIControlStateNormal];
    [buttonphoto setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonphoto.titleLabel.font = FONTN(15.0f);
    [buttonphoto addTarget:self action:@selector(clicktakephoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonphoto];

    [self getstorehppic];
}


#pragma mark IBaction
-(void)clicktakephoto
{
    [JPhotoMagenage getTakePhotoImageInController:self finish:^(UIImage *images) {
        NSLog(@"%@",images);
        UIImage *image = [AddInterface scaleToSize:images size:CGSizeMake(800, 800)];
        imageview.image = image;
        FCimage = image;
        [self uploadcustompic];
    } cancel:^{
        
    }];
}

-(void)clicktakelibry
{
    [JPhotoMagenage getTakeLibryImageInController:self finish:^(UIImage *images) {
        NSLog(@"%@",images);
        UIImage *image = [AddInterface scaleToSize:images size:CGSizeMake(800, 800)];
        imageview.image = image;
        FCimage = image;
        [self uploadcustompic];
    } cancel:^{
        
    }];
}

#pragma mark IBAction

-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 接口
-(void)uploadcustompic
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //    params[@"meetingcontent"] = @"测试内容。。。。。。。";
    
    NSMutableArray *arrayimage = [[NSMutableArray alloc] init];
    [arrayimage addObject:FCimage];
    
    
    [RequestInterface doGetJsonWithArraypic:arrayimage Parameter:params App:app RequestCode:RQUploadCustomPicCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCuploadstrpic = [[[dic objectForKey:@"data"] objectForKey:@"pictureinfo"] objectForKey:@"picturesavenames"];
            [self uploadtopimagepic];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
        
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
    }];
}

-(void)deletetopimage:(id)sender
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQStoreDeleteFrontCoverpicCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
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


-(void)uploadtopimagepic
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"picture"] = FCuploadstrpic;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQStoreUploadFrontCoverpicCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
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


-(void)getstorehppic
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQStoreFrontCoverPicCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            NSString *strpic = [[[dic objectForKey:@"data"] objectForKey:@"shoppictureinfo"] objectForKey:@"picture"];
            [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"watertest", @"png")];
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
