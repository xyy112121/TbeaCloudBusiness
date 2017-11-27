//
//  ComMettingDetailSHowPicViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/14.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ComMettingDetailSHowPicViewController.h"

@interface ComMettingDetailSHowPicViewController ()

@end

@implementation ComMettingDetailSHowPicViewController

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
    
    if([self.FCfromflag isEqualToString:@"1"])
    {
        UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
        buttonright.titleLabel.font = FONTN(14.0f);
        [buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buttonright setTitle:@"上传" forState:UIControlStateNormal];
        buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
        [buttonright addTarget:self action: @selector(gotomettingupload:) forControlEvents: UIControlEventTouchUpInside];
        [contentViewright addSubview:buttonright];
        UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
        self.navigationItem.rightBarButtonItem = barButtonItemright;
    }
    [self initview];
    
    // Do any additional setup after loading the view.
}

-(void)initview
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"现场照片";
    
    imageviewno = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2, (SCREEN_HEIGHT-89-StatusBarAndNavigationHeight)/2, 60, 89)];
    imageviewno.image = LOADIMAGE(@"暂无图片", @"png");
    imageviewno.alpha = 0;
    [self.view addSubview:imageviewno];
    
    
}

-(void)picarrment
{
    float rithgleftspace = 20; //左右间隔
    float picspace = 10;
    float widthnow = (SCREEN_WIDTH-rithgleftspace*2-picspace*3)/4;
    int counth = 0;
    int countv = 0;
    int countspecifi = (int)[FCarraydata count];
    counth = (countspecifi%4==0?countspecifi/4:countspecifi/4+1);
    
    for(int i=0;i<counth;i++)
    {
        if(i<counth-1)
        {
            countv = 4;
        }
        else
        {
            countv = countspecifi%4==0?4:countspecifi%4;
        }
        
        for(int j=0;j<countv;j++)
        {
            NSDictionary *dictemp = [FCarraydata objectAtIndex:i*4+j];
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20+(widthnow+10)*j, 20+(widthnow+10)*i, widthnow, widthnow)];
            imageview.tag = EnWaterMettingPicArrmentImageViewTag+i*4+j;
            NSString *strpic = [dictemp objectForKey:@"thumbpictureurl"];
            [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
            imageview.contentMode = UIViewContentModeScaleAspectFill;
            imageview.clipsToBounds = YES;
            [self.view addSubview:imageview];
            
            if([_FCfromflag isEqualToString:@"1"])
            {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(XYViewL(imageview), XYViewTop(imageview), 15, 15);
                [button setImage:LOADIMAGE(@"closeorder", @"png") forState:UIControlStateNormal];
                button.tag= EnWaterMettingPicArrmentDeleteBtTag+i*4+j;
                [button addTarget:self action:@selector(removeimage:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button];
            }
            
        }
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [self getpiclist];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
}
#pragma mark IBAction
-(void)removeimage:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int tagnow = (int)[button tag]-EnWaterMettingPicArrmentDeleteBtTag;
    NSDictionary *dictemp = [FCarraydata objectAtIndex:tagnow];
    [self requestremoveimage:[dictemp objectForKey:@"pictureid"]];
    
}


-(void)returnback
{
    if([self.delegate1 respondsToSelector:@selector(DGGetMettingPicNumber:)])
    {
        [self.delegate1 DGGetMettingPicNumber:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)gotomettingupload:(id)sender
{
    ComMettingDetailUploadPicViewController *pic = [[ComMettingDetailUploadPicViewController alloc] init];
    pic.delegate1 = self;
    pic.FCmettingid = self.FCmettingid;
    [self.navigationController pushViewController:pic animated:YES];
}


#pragma mark 接口
-(void)requestremoveimage:(NSString *)removiid
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pictureid"] = removiid;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQMettingShowPicDeletePicCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            [self getpiclist];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}

-(void)getpiclist
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"meetingid"] = self.FCmettingid;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQWaterMettingPicListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            NSArray *arraypic = [[dic objectForKey:@"data"] objectForKey:@"picturelist"];
            FCarraydata = [[NSMutableArray alloc] initWithArray:arraypic];
            if([FCarraydata count]==0)
            {
                imageviewno.alpha = 1;
            }
            else
            {
                imageviewno.alpha = 0;
                [self picarrment];
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
