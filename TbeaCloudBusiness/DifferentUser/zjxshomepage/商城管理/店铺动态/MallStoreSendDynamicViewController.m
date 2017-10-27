//
//  MallStoreSendDynamicViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/9/1.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MallStoreSendDynamicViewController.h"

@interface MallStoreSendDynamicViewController ()

@end

@implementation MallStoreSendDynamicViewController

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
    [buttonright setTitle:@"预览" forState:UIControlStateNormal];
    buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
    [buttonright addTarget:self action: @selector(clickreview:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright addSubview:buttonright];
    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    self.navigationItem.rightBarButtonItem = barButtonItemright;
    
    [self initview];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    // Do any additional setup after loading the view.
}

-(void)initview
{
    FCarraypic = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发表文章";
    
    UILabel *labletitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 50, 20)];
    labletitle.text = @"标题";
    labletitle.font = FONTN(15.0f);
    labletitle.textColor = COLORNOW(117, 117, 117);
    labletitle.textAlignment = NSTextAlignmentCenter;
    labletitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:labletitle];
    
    FCtextfieldtitle = [[UITextField alloc] initWithFrame:CGRectMake(XYViewR(labletitle), 5, 200, 30)];
    FCtextfieldtitle.delegate = self;
    FCtextfieldtitle.placeholder = @"请输入标题内容";
    FCtextfieldtitle.font = FONTN(15.0f);
    FCtextfieldtitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:FCtextfieldtitle];
    
    UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 1)];
    imageviewline.backgroundColor = COLORNOW(220, 220, 220);
    [self.view addSubview:imageviewline];
    
    [self picaddview];
    
    UIImageView *imageviewline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, XYViewBottom(FCviewpic)+20, SCREEN_WIDTH, 1)];
    imageviewline1.backgroundColor = COLORNOW(220, 220, 220);
    [self.view addSubview:imageviewline1];
    
    UILabel *lablecontent = [[UILabel alloc] initWithFrame:CGRectMake(20, XYViewBottom(imageviewline1)+10, 50, 20)];
    lablecontent.text = @"内容";
    lablecontent.font = FONTN(15.0f);
    lablecontent.textColor = COLORNOW(117, 117, 117);
    lablecontent.textAlignment = NSTextAlignmentCenter;
    lablecontent.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lablecontent];
    
    FCtextfieldcontent = [[UITextField alloc] initWithFrame:CGRectMake(XYViewR(labletitle), XYViewBottom(imageviewline1)+5, 200, 30)];
    FCtextfieldcontent.delegate = self;
    FCtextfieldcontent.font = FONTN(15.0f);
    FCtextfieldcontent.placeholder = @"请输入文章内容";
    FCtextfieldcontent.backgroundColor = [UIColor clearColor];
    [self.view addSubview:FCtextfieldcontent];
    
    UIImageView *imageviewline2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, XYViewBottom(imageviewline1)+40, SCREEN_WIDTH, 1)];
    imageviewline2.backgroundColor = COLORNOW(220, 220, 220);
    [self.view addSubview:imageviewline2];
    
    UIButton *buttonloging = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonloging.frame = CGRectMake(30, SCREEN_HEIGHT-40-60-40, SCREEN_WIDTH-60, 40);
    buttonloging.layer.cornerRadius = 3.0f;
    buttonloging.backgroundColor = COLORNOW(0, 170, 238);
    buttonloging.clipsToBounds = YES;
    [buttonloging setTitle:@"保存" forState:UIControlStateNormal];
    [buttonloging setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonloging.titleLabel.font = FONTN(15.0f);
    [buttonloging addTarget:self action:@selector(uploadpic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonloging];
}



-(void)picaddview
{
    float nowwidth = ((SCREEN_WIDTH-40)-30)/4;
    FCviewpic = [[UIView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, nowwidth*2+10)];
    FCviewpic.backgroundColor = [UIColor clearColor];
    [self refreshpiclayout];
    [self.view addSubview:FCviewpic];
}

-(void)refreshpiclayout
{
    float widthspace = 20;//左右的距离
    
    float widthnow = (SCREEN_WIDTH-10*3-widthspace*2)/4;
    
    int counth = 0;
    int countv = 0;
    int countspecifi = (int)[FCarraypic count]+1;
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
            if(i*4+j<countspecifi-1)
            {
                UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20+(widthnow+10)*j, (widthnow+10)*i, widthnow, widthnow)];
                imageview.contentMode = UIViewContentModeScaleAspectFill;
                imageview.clipsToBounds = YES;
                imageview.image = [[FCarraypic objectAtIndex:i*4+j] objectForKey:@"result"];
                [FCviewpic addSubview:imageview];
                
                UIButton *buttondelete = [UIButton buttonWithType:UIButtonTypeCustom];
                buttondelete.frame = CGRectMake(XYViewL(imageview)-2, XYViewTop(imageview)-2, 20, 20);
                buttondelete.tag = EnMallStoreDynamicDeleteBtTag+i*4+j;
                [buttondelete addTarget:self action:@selector(clickdeletepic:) forControlEvents:UIControlEventTouchUpInside];
                [buttondelete setImage:LOADIMAGE(@"closeorder", @"png") forState:UIControlStateNormal];
                [FCviewpic addSubview:buttondelete];
            }
            else
            {
                
                UIImageView *imageviewadpic = [[UIImageView alloc] initWithFrame:CGRectMake(20+(widthnow+10)*j, (widthnow+10)*i, widthnow, widthnow)];
                if(countspecifi>8)
                {
                    imageviewadpic.frame = CGRectMake(20+(widthnow+10)*3, (widthnow+10)*1, widthnow, widthnow);
                }
                imageviewadpic.image = LOADIMAGE(@"useraddpic", @"png");
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicktakephoto:)];
                imageviewadpic.userInteractionEnabled = YES;
                [imageviewadpic addGestureRecognizer:singleTap];
                
                
                [FCviewpic insertSubview:imageviewadpic atIndex:0];
            }
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
//    self.navigationController.navigationBar.translucent = NO;
//    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
//    UIColor* color = [UIColor whiteColor];
//    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
//    self.navigationController.navigationBar.titleTextAttributes= dict;
}



#pragma mark 添加图片

-(void)clicktakephoto:(id)sender
{
    FYAlbumManager * manager =[FYAlbumManager shareAlbumManager];
    manager.maxSelect = 8;
    manager.delegate1 = self;
    manager.complate = ^(NSArray *array)
    {
        DLog(@"array====%@",[array objectAtIndex:0]);
        
        for(int i=0;i<[array count];i++)
        {
            NSDictionary *dic = [array objectAtIndex:i];
            int flag = 0;
            for(int j=0;j<[FCarraypic count];j++)
            {
                NSDictionary *dicphoto = [FCarraypic objectAtIndex:j];
                if([[dic objectForKey:@"localid"] isEqualToString:[dicphoto objectForKey:@"localid"]])
                {
                    flag = 1;
                    break;
                }
            }
            
            if(flag == 0)
            {
                if([FCarraypic count]<8)
                    [FCarraypic addObject:[array objectAtIndex:i]];
            }
        }
        
        [self picaddview];
        
    };
    [manager showInView:self Photo:@"4"];
}

#pragma mark IBAction
-(void)clickreview:(id)sender
{
    
}

-(void)keyboardHide:(id)sender
{
    [FCtextfieldcontent resignFirstResponder];
    [FCtextfieldtitle resignFirstResponder];
}


-(void)clickdeletepic:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int tagnow = (int)[button tag]-EnMallStoreDynamicDeleteBtTag;
    if([FCarraypic count]>tagnow)
    {
        [FCarraypic removeObjectAtIndex:tagnow];
    }
    [FCviewpic removeFromSuperview];
    [self picaddview];
}

-(void)returnback
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)uploadpic:(id)sender
{
    if([FCarraypic count]==0)
        [MBProgressHUD showError:@"请选择图片" toView:app.window];
    else if(([FCtextfieldtitle.text length]==0)||([FCtextfieldcontent.text length]==0))
        [MBProgressHUD showError:@"请填写动态内容" toView:app.window];
    else
        [self uploadcustompic];

}

#pragma mark 接口
-(void)uploadcustompic
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //    params[@"meetingcontent"] = @"测试内容。。。。。。。";
    
    NSMutableArray *arrayimage = [[NSMutableArray alloc] init];
    for(int i=0;i<[FCarraypic count];i++)
    {
        NSDictionary *dictemp = [FCarraypic objectAtIndex:i];
        [arrayimage addObject:[dictemp objectForKey:@"result"]];
    }
    
    
    [RequestInterface doGetJsonWithArraypic:arrayimage Parameter:params App:app RequestCode:RQUploadCustomPicCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCuploadstrpic = [[[dic objectForKey:@"data"] objectForKey:@"pictureinfo"] objectForKey:@"picturesavenames"];
            [self uploadpicpath:FCuploadstrpic];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
        
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
    }];
}

-(void)uploadpicpath:(NSString *)picpath
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"newsid"] = @"";
    params[@"title"] = FCtextfieldtitle.text;
    params[@"PictureList"] = picpath;
    params[@"Content"] = FCtextfieldcontent.text;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQMallStoreSaveDynamicCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:app.window];
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
