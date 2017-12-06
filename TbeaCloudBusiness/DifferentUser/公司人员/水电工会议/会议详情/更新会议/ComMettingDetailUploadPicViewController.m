//
//  ComMettingDetailUploadPicViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/14.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ComMettingDetailUploadPicViewController.h"

@interface ComMettingDetailUploadPicViewController ()

@end

@implementation ComMettingDetailUploadPicViewController

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
    [buttonright addTarget:self action: @selector(uploadpic:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright addSubview:buttonright];
    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    self.navigationItem.rightBarButtonItem = barButtonItemright;
    
    [self initview];
}

-(void)initview
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"图片上传";
    FCArraySelectPic = [[NSMutableArray alloc] init];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidekeyboard:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    UILabel *strtitle = [[UILabel alloc] initWithFrame:CGRectMake(10,10,40,20)];
    strtitle.backgroundColor = [UIColor clearColor];
    strtitle.textColor = [UIColor blackColor];
    strtitle.font = FONTB(16.0f);
    strtitle.text = @"主题";
    [self.view addSubview:strtitle];
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(strtitle.frame.origin.x+strtitle.frame.size.width+10, 5, SCREEN_WIDTH-90, 30)];
    textfield.layer.cornerRadius = 3;
    textfield.layer.borderColor = COLORNOW(230, 230, 230).CGColor;
    textfield.layer.borderWidth = 0.5f;
    textfield.backgroundColor = COLORNOW(245, 245, 245);
    textfield.tag = 621;
    textfield.delegate = self;
    textfield.placeholder = @"填写主题";
    textfield.font = FONTN(15.0f);
    textfield.returnKeyType = UIReturnKeyDone;
    textfield.clearButtonMode = UITextFieldViewModeAlways;
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    textfield.leftView = leftview;
    leftview.userInteractionEnabled = NO;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:textfield];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 0.7)];
    imageline.backgroundColor = COLORNOW(220, 220, 220);
    [self.view addSubview:imageline];
    
    float space = 10; //每两块间的空隔是10个朴素，
    int verticalnum = 5; //一排排5个
    int widthnow = (SCREEN_WIDTH-space*(verticalnum+1))/verticalnum;
    CMArrangementPicView *cmarrangement = [[CMArrangementPicView alloc] initWithFrame:CGRectMake(0, XYViewBottom(imageline)+10, SCREEN_WIDTH, widthnow*2+30) ArraySelect:FCArraySelectPic];
    [self.view addSubview:cmarrangement];
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

-(void)hidekeyboard:(id)sender
{
    
}

-(void)clickselectpic:(id)sender
{
    [JPhotoMagenage JphotoGetFromLibrayInController:self finish:^(NSArray<UIImage *> *images) {
        
    } cancel:^{
        
    }];
}

-(void)uploadpic:(id)sender
{
    [self uploadcustompic];
}

#pragma mark actiondelegate
-(void)DGClickDeleteArrangementPic:(int)sender
{
    [FCArraySelectPic removeObjectAtIndex:sender];
}

#pragma mark 接口
-(void)uploadcustompic
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    
    
    NSMutableArray *arrayimage = [[NSMutableArray alloc] init];
    [arrayimage addObject:LOADIMAGE(@"metting编辑", @"png")];
    [arrayimage addObject:LOADIMAGE(@"metting会议列表", @"png")];
    
    
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
    params[@"meetingid"] = self.FCmettingid;
    params[@"picturetitle"] = @"主题";
    params[@"pictures"] = picpath;
    params[@"primarypictureindex"] = @"1";
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQComWaterUploadPicCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
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
