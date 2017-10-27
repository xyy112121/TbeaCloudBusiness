//
//  ScanQRZhiFuDoneViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ScanQRZhiFuDoneViewController.h"

@interface ScanQRZhiFuDoneViewController ()

@end

@implementation ScanQRZhiFuDoneViewController

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
    self.title = @"支付确认";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    
    UIButton *buttondone = [UIButton buttonWithType:UIButtonTypeCustom];
    buttondone.frame = CGRectMake(20, 240, SCREEN_WIDTH-40, 40);
    buttondone.layer.cornerRadius = 3.0f;
    buttondone.backgroundColor = COLORNOW(0, 170, 238);
    buttondone.clipsToBounds = YES;
    
    [buttondone setTitle:@"确认" forState:UIControlStateNormal];
    [buttondone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttondone.titleLabel.font = FONTN(15.0f);
    [buttondone addTarget:self action:@selector(clickdone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttondone];
    if([[self.FCdicscancodedetail objectForKey:@"takemoneystatusid"] isEqualToString:@"expired"])
    {
        buttondone.enabled = NO;
    }
    
//    [self getjihuodetail];
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

#pragma mark Actiondelegate
-(void)DGScanQRClickPayDone:(id)sender
{
    [self DoneScanQRCode:[self.FCdicscancodedetail objectForKey:@"takemoneyid"]];
}

#pragma mark IBaction
-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickdone:(id)sender
{
    self.view.backgroundColor =[UIColor whiteColor];
    PayPopConfirmView *alert =[[PayPopConfirmView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, SCREEN_HEIGHT) DicFrom:self.FCdicscancodedetail];
    alert.delegate1=self;
    [self.view addSubview:alert];
}

#pragma mark tableview delegate
//隐藏那些没有cell的线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

-(void)viewDidLayoutSubviews
{
    if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 60;
    else if(indexPath.row == 1)
        return 50;
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *reuseIdetify = @"cell";
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    
//    NSDictionary *dicrebateinfo = [FCdicscancodedetail objectForKey:@"rebateqrcodeinfo"];
//   NSDictionary *dicactivityinfo = [FCdicscancodedetail objectForKey:@"rebateqrcodeactivityinfo"];

    if(indexPath.row == 0)
    {
        UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 80, 20)];
        labelname.backgroundColor = [UIColor clearColor];
        labelname.textColor = [UIColor blackColor];
        labelname.font = FONTN(15.0f);
        labelname.text = @"用户";
        [cell.contentView addSubview:labelname];
        
        UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, 40, 40)];
        [imageheader setImageWithURL:[NSURL URLWithString:[self.FCdicscancodedetail objectForKey:@"thumbpicture"]] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
        imageheader.layer.cornerRadius = 15.0f;
        imageheader.clipsToBounds = YES;
        imageheader.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:imageheader];
        
        CGSize sizeuser = [AddInterface getlablesize:[self.FCdicscancodedetail objectForKey:@"personname"] Fwidth:260 Fheight:20 Sfont:FONTN(15.0f)];
        UILabel *labelusername = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, 10, sizeuser.width, 20)];
        labelusername.backgroundColor = [UIColor clearColor];
        labelusername.textColor = [UIColor blackColor];
        labelusername.font = FONTN(15.0f);
        labelusername.text = [self.FCdicscancodedetail objectForKey:@"personname"];
        [cell.contentView addSubview:labelusername];
        
        
        UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelusername)+5, XYViewTop(labelusername)+5, 28, 10)];
        [imageicon setImageWithURL:[NSURL URLWithString:[self.FCdicscancodedetail objectForKey:@"persontypeicon"]]];
        [cell.contentView addSubview:imageicon];
        
        
        UILabel *labeldes = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelusername), XYViewBottom(labelusername), 180, 20)];
        labeldes.backgroundColor = [UIColor clearColor];
        labeldes.textColor =COLORNOW(117, 117, 117);
        labeldes.font = FONTN(15.0f);
        labeldes.text = [self.FCdicscancodedetail objectForKey:@"companyname"];
        [cell.contentView addSubview:labeldes];
        
    }
    else if(indexPath.row == 1)
    {
        UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 80, 20)];
        labelname.backgroundColor = [UIColor clearColor];
        labelname.textColor = [UIColor blackColor];
        labelname.font = FONTN(15.0f);
        labelname.text = @"金额";
        [cell.contentView addSubview:labelname];
        
        UILabel *lablemoneyflag1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 18, 10,10)];
        lablemoneyflag1.text = @"￥";
        lablemoneyflag1.font = FONTMEDIUM(11.0f);
        lablemoneyflag1.textColor = [UIColor blackColor];
        lablemoneyflag1.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:lablemoneyflag1];
        
        UILabel *lableispayvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(lablemoneyflag1)+1, 15, 150, 20)];
        lableispayvalue.text = [NSString stringWithFormat:@"%@",[self.FCdicscancodedetail objectForKey:@"money"]];
        lableispayvalue.font = FONTMEDIUM(18.0f);
        lableispayvalue.textColor = [UIColor blackColor];
        lableispayvalue.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:lableispayvalue];
    }
    else if(indexPath.row == 2)
    {
        UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, 20)];
        labelname.backgroundColor = [UIColor clearColor];
        labelname.textColor = [UIColor blackColor];
        labelname.font = FONTN(15.0f);
        labelname.text = @"验证码";
        [cell.contentView addSubview:labelname];
        
        UILabel *lableispayvalue = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 200, 20)];
        lableispayvalue.text = [NSString stringWithFormat:@"%@",[self.FCdicscancodedetail objectForKey:@"qrcode"]];
        lableispayvalue.font = FONTN(15.0f);
        lableispayvalue.textColor = [UIColor blackColor];
        lableispayvalue.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:lableispayvalue];
        
        UILabel *labelstatus = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelname), XYViewBottom(labelname)+5, 80, 20)];
        labelstatus.backgroundColor = [UIColor clearColor];
        labelstatus.textColor = COLORNOW(117, 117, 117);
        labelstatus.font = FONTN(15.0f);
        labelstatus.text = @"状态";
        [cell.contentView addSubview:labelstatus];
        
        UILabel *labelstatusvalue = [[UILabel alloc] initWithFrame:CGRectMake(100, XYViewTop(labelstatus), 200, 20)];
        labelstatusvalue.text = [NSString stringWithFormat:@"%@",[self.FCdicscancodedetail objectForKey:@"takemoneystatus"]];
        labelstatusvalue.font = FONTN(15.0f);
        labelstatusvalue.textColor = COLORNOW(117, 117, 117);
        labelstatusvalue.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:labelstatusvalue];
        
        UILabel *labelvalid = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelstatus), XYViewBottom(labelstatus)+5, 80, 20)];
        labelvalid.backgroundColor = [UIColor clearColor];
        labelvalid.textColor = COLORNOW(117, 117, 117);
        labelvalid.font = FONTN(15.0f);
        labelvalid.text = @"有效果期";
        [cell.contentView addSubview:labelvalid];
        
        UILabel *labelvalidvalue = [[UILabel alloc] initWithFrame:CGRectMake(100, XYViewTop(labelvalid), 200, 20)];
        labelvalidvalue.text = [NSString stringWithFormat:@"%@",[self.FCdicscancodedetail objectForKey:@"validexpiredtime"]];
        labelvalidvalue.font = FONTN(15.0f);
        labelvalidvalue.textColor = COLORNOW(117, 117, 117);
        labelvalidvalue.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:labelvalidvalue];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}

#pragma mark 接口
-(void)DoneScanQRCode:(NSString *)strtakonid
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"takemoneyid"]= strtakonid;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQScanQRCodeDone ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            ScanQRPayDoneViewController *scanqr = [[ScanQRPayDoneViewController alloc] init];
            [self.navigationController pushViewController:scanqr animated:YES];
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
