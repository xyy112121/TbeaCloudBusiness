//
//  ScanQRCodeARViewController.m
//  CcwbNews5_0
//
//  Created by xyy on 2017/7/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ScanQRCodeARViewController.h"

@interface ScanQRCodeARViewController ()<SGQRCodeScanManagerDelegate, SGQRCodeAlbumManagerDelegate>
{
    UIButton *_importQRCodeImageBtn;//导入二维码图片按钮
    UIButton *_LightBtn;
    UIButton *_LibrayBtn;
}
@property (nonatomic, strong) SGQRCodeScanningView *scanningView;
@property(nonatomic,strong)SGQRCodeScanManager *manager;

@end

@implementation ScanQRCodeARViewController

-(void)returnback:(id)sender
{
    [_manager SG_stopRunning];
    [self removeScanningView];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [_manager SG_startRunning];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    NSLog(@"SGQRCodeScanningVC - dealloc");
    [self removeScanningView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    [self.view addSubview:self.scanningView];
    [self setupQRCodeScanning];
    [self.scanningView addTimer];
    [self setupNavigationBar];
}

- (SGQRCodeScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [SGQRCodeScanningView scanningViewWithFrame:self.view.bounds layer:self.view.layer];
        
        //二维码扫描
        _LightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _LightBtn.layer.borderColor = [UIColor clearColor].CGColor;
        _LightBtn.frame = CGRectMake((SCREEN_WIDTH-100-120)/2, SCREEN_HEIGHT-150, 60, 60);
        [_LightBtn setImage:LOADIMAGE(@"scancodelight", @"png") forState:UIControlStateNormal];
        [_LightBtn setBackgroundColor:[UIColor clearColor]];
        _LightBtn.tag = IMPORTQRcode;
        [_LightBtn addTarget:_scanningView action:@selector(light_buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_scanningView addSubview:_LightBtn];
        
        //Library扫描
        _LibrayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _LibrayBtn.layer.borderColor = [UIColor clearColor].CGColor;
        _LibrayBtn.frame = CGRectMake(_LightBtn.frame.origin.x+_LightBtn.frame.size.width+100, SCREEN_HEIGHT-150, 60, 60);
        [_LibrayBtn setImage:LOADIMAGE(@"scancodelibry", @"png") forState:UIControlStateNormal];
        _LibrayBtn.titleLabel.font = FONTN(15.0f);
        [_LibrayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_LibrayBtn setBackgroundColor:[UIColor clearColor]];
        _LibrayBtn.tag = IMPORTARcode;
        [_LibrayBtn addTarget:self action:@selector(rightBarButtonItenAction) forControlEvents:UIControlEventTouchUpInside];
        [_scanningView addSubview:_LibrayBtn];
        
    }
    return _scanningView;
}

- (void)removeScanningView {
    [_scanningView removeTimer];
    [_scanningView removeFromSuperview];
    _scanningView = nil;
}

- (void)setupNavigationBar {
    [self.navigationController setNavigationBarHidden:YES];
    _importQRCodeImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _importQRCodeImageBtn.layer.borderColor = [UIColor clearColor].CGColor;
    _importQRCodeImageBtn.frame = CGRectMake(SCREEN_WIDTH-100, 22, 90, 40);
    [_importQRCodeImageBtn setTitle:@"输入条形码" forState:UIControlStateNormal];
    [_importQRCodeImageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _importQRCodeImageBtn.titleLabel.font = FONTN(14.0f);
    [_importQRCodeImageBtn setBackgroundColor:[UIColor clearColor]];
    _importQRCodeImageBtn.tag = IMPORTBUTTONTAG;
    [_importQRCodeImageBtn addTarget:self action:@selector(gotoinputcode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_importQRCodeImageBtn];
    
    //返回按钮
    UIButton *btreturn = [UIButton buttonWithType:UIButtonTypeCustom];
    btreturn.layer.borderColor = [UIColor clearColor].CGColor;
    btreturn.frame = CGRectMake(10, 22, 40, 40);
    [btreturn setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
    [btreturn addTarget:self action:@selector(returnback:) forControlEvents:UIControlEventTouchUpInside];
    [btreturn setTitleColor:COLORNOW(102, 102, 102) forState:UIControlStateNormal];
    [self.view addSubview:btreturn];
    
}

- (void)rightBarButtonItenAction {
    SGQRCodeAlbumManager *manager = [SGQRCodeAlbumManager sharedManager];
    [manager SG_readQRCodeFromAlbumWithCurrentController:self];
    manager.delegate = self;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    // 栅栏函数
    dispatch_barrier_async(queue, ^{
        BOOL isPHAuthorization = manager.isPHAuthorization;
        if (isPHAuthorization == YES) {
            [self removeScanningView];
        }
    });
}

- (void)setupQRCodeScanning {
    self.manager = [SGQRCodeScanManager sharedManager];
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    [self.manager SG_setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
    self.manager.delegate = self;
}

#pragma mark IBaction
-(void)gotoinputcode:(id)sender
{
    ScanQRInputCodeViewController *scanqrinput = [[ScanQRInputCodeViewController alloc] init];
    [self.navigationController pushViewController:scanqrinput animated:YES];
    
//    ScanQRNoValidCodeViewController *scanvalid = [[ScanQRNoValidCodeViewController alloc] init];
//    [self.navigationController pushViewController:scanvalid animated:YES];
}




#pragma mark - - - SGQRCodeAlbumManagerDelegate
- (void)QRCodeAlbumManagerDidCancelWithImagePickerController:(SGQRCodeAlbumManager *)albumManager {
    [self.view insertSubview:self.scanningView atIndex:0];
}
- (void)QRCodeAlbumManager:(SGQRCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result {
    DLog(@"nsssss===%@",result);
    if ([result hasPrefix:@"http"]) {
        
        
    } else
    {
        
            }
}

#pragma mark - - - SGQRCodeScanManagerDelegate
- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects {
    NSLog(@"metadataObjects - - %@", metadataObjects);
    if (metadataObjects != nil && metadataObjects.count > 0) {
        [scanManager SG_palySoundName:@"SGQRCode.bundle/sound.caf"];
        [scanManager SG_stopRunning];
        //        [scanManager SG_videoPreviewLayerRemoveFromSuperlayer];
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        DLog(@"sdfasdfasfdasf===%@",[obj stringValue]);
        
        if([[obj stringValue] rangeOfString:@"tbscrfl"].location !=NSNotFound)
        {
            [self getscanrebatelist:[obj stringValue]];
        }
        else
        {
            [scanManager SG_startRunning];
            [MBProgressHUD showError:@"不能识别此二维码" toView:app.window];
        }
        
        
        
    } else {
        [scanManager SG_startRunning];
        NSLog(@"暂未识别出扫描的二维码");
    }
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
            [_manager SG_startRunning];
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
