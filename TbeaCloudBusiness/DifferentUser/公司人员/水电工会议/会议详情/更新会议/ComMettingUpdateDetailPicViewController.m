//
//  ComMettingUpdateDetailPicViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/12/7.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ComMettingUpdateDetailPicViewController.h"

@interface ComMettingUpdateDetailPicViewController ()
@property (strong, nonatomic)UIView *photoView;
@property (strong, nonatomic)UIButton *FCButtondon;
@property (strong,nonatomic)UITextField *FCtextfield;
@property (nonatomic, strong) WSImagePickerView *pickerView;
@end

@implementation ComMettingUpdateDetailPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片上传";
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
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.title = @"图片上传";

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidekeyboard:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    UILabel *strtitle = [[UILabel alloc] initWithFrame:CGRectMake(10,10,40,20)];
    strtitle.backgroundColor = [UIColor clearColor];
    strtitle.textColor = [UIColor blackColor];
    strtitle.font = FONTB(16.0f);
    strtitle.text = @"主题";
    [self.view addSubview:strtitle];
    
    _FCtextfield = [[UITextField alloc] initWithFrame:CGRectMake(strtitle.frame.origin.x+strtitle.frame.size.width+10, 5, SCREEN_WIDTH-90, 30)];
    _FCtextfield.layer.cornerRadius = 3;
    _FCtextfield.layer.borderColor = COLORNOW(230, 230, 230).CGColor;
    _FCtextfield.layer.borderWidth = 0.5f;
    _FCtextfield.backgroundColor = COLORNOW(245, 245, 245);
    _FCtextfield.tag = 621;
    _FCtextfield.delegate = self;
    _FCtextfield.placeholder = @"填写主题";
    _FCtextfield.font = FONTN(15.0f);
    _FCtextfield.returnKeyType = UIReturnKeyDone;
    _FCtextfield.clearButtonMode = UITextFieldViewModeAlways;
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    _FCtextfield.leftView = leftview;
    leftview.userInteractionEnabled = NO;
    _FCtextfield.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_FCtextfield];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 0.7)];
    imageline.backgroundColor = COLORNOW(220, 220, 220);
    [self.view addSubview:imageline];
    
    _photoView = [[UIView alloc] initWithFrame:CGRectMake(0, XYViewBottom(imageline)+20, SCREEN_WIDTH, 100)];
    
    WSImagePickerConfig *config = [WSImagePickerConfig new];
    config.itemSize = CGSizeMake(80, 80);
    config.photosMaxCount = 8;
    
    WSImagePickerView *pickerView = [[WSImagePickerView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 0) config:config];
    //Height changed with photo selection
    __weak typeof(self) weakSelf = self;
    pickerView.viewHeightChanged = ^(CGFloat height) {
        weakSelf.photoView.frame = CGRectMake(XYViewL(weakSelf.photoView), XYViewTop(weakSelf.photoView), XYViewWidth(weakSelf.photoView), height);
        [weakSelf.view setNeedsLayout];
        [weakSelf.view layoutIfNeeded];
    };
    pickerView.navigationController = self.navigationController;
    [_photoView addSubview:pickerView];
    self.pickerView = pickerView;
    
    [self.view addSubview:_photoView];
    //refresh superview height
    [pickerView refreshImagePickerViewWithPhotoArray:nil];
}



#pragma mark IBAction
-(void)uploadpic:(id)sender
{
    FCArraySelectPic = [_pickerView getPhotos];
    if([_FCtextfield.text length]==0)
        [MBProgressHUD showMessage:@"请填写主题" toView:app.window];
    else if([FCArraySelectPic count]==0)
        [MBProgressHUD showMessage:@"请添加图片" toView:app.window];
    else
        [self uploadcustompic];
}

-(void)hidekeyboard:(id)sender
{
    
}

-(void)returnback
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onClickConfirm:(id)sender {
    NSArray *array = [_pickerView getPhotos];
    NSLog(@"%@",array);
    [[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"共选择了%@张照片",@(array.count)] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
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
    params[@"picturetitle"] = _FCtextfield.text;
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
