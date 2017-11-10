//
//  ComMettingCreateSignInViewController.m
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/11/9.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ComMettingCreateSignInViewController.h"

@interface ComMettingCreateSignInViewController ()

@end

@implementation ComMettingCreateSignInViewController

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
    [buttonright setTitle:@"下载" forState:UIControlStateNormal];
    buttonright.titleLabel.font = FONTN(15.0f);
    [buttonright addTarget:self action: @selector(clickdownpic:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright addSubview:buttonright];
    buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    self.navigationItem.rightBarButtonItem = barButtonItemright;
    
    // Do any additional setup after loading the view.
}

#pragma mark 页面布局

-(void)initview
{
    self.title = @"签到码";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
    [self getSignInCode];
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

-(void)viewfooter
{
    UIView *viewfoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400)];
    viewfoot.backgroundColor = [UIColor whiteColor];
    tableview.tableFooterView = viewfoot;
    
    imageqrcode = [[UIImageView alloc] initWithFrame:CGRectMake(40, 30, SCREEN_WIDTH-80, SCREEN_WIDTH-80)];
    NSString *strpic;
    strpic = [FCdicdata objectForKey:@"meetingqrcodepicture"];
    [imageqrcode setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:nil];
    imageqrcode.contentMode = UIViewContentModeScaleAspectFill;
    imageqrcode.layer.cornerRadius = 15.0f;
    imageqrcode.clipsToBounds = YES;
    [viewfoot addSubview:imageqrcode];
    
    
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(40, XYViewBottom(imageqrcode)+20, SCREEN_WIDTH-40, 60)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = COLORNOW(117, 117, 117);
    labelname.font = FONTN(15.0f);
    labelname.text = @"1.请使用电工惠app扫码签到 \n2.会议签到仅限水电工程师使用\n3.签到码有效果期为会议开始前两小时到会议结束";
    labelname.numberOfLines = 3;
    [viewfoot addSubview:labelname];



}

#pragma mark IBaction
-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickdownpic:(id)sender
{
    UIImageWriteToSavedPhotosAlbum(imageqrcode.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

//回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    
    [MBProgressHUD showSuccess:msg toView:app.window];
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
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 1;
    return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    viewheader.backgroundColor = COLORNOW(235, 235, 235);
    
    return viewheader;
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
    
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 70, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = COLORNOW(117, 117, 117);
    labelname.font = FONTN(15.0f);
    
    
    UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(labelname)+10, 10, SCREEN_WIDTH-100, 20)];
    labelvalue.backgroundColor = [UIColor clearColor];
    labelvalue.textColor = [UIColor blackColor];
    labelvalue.font = FONTN(15.0f);
    

    switch (indexPath.row)
    {
        case 0:
            labelname.text = @"会议编号";
            [cell.contentView addSubview:labelname];
            
            labelvalue.text = [FCdicdata objectForKey:@"meetingcode"];
            [cell.contentView addSubview:labelvalue];
            break;
        case 1:
            labelname.text = @"举办时间";
            [cell.contentView addSubview:labelname];
            
            labelvalue.text =  [FCdicdata objectForKey:@"meetingtime"];
            [cell.contentView addSubview:labelvalue];
            break;
        case 2:
            labelname.text = @"举办地点";
            [cell.contentView addSubview:labelname];
            
            labelvalue.text = [FCdicdata objectForKey:@"meetingplace"];
            [cell.contentView addSubview:labelvalue];
            break;
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark 接口
-(void)getSignInCode
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"meetingid"] = self.FCmettingid;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQGetComettingCreateSignInCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCdicdata = [[dic objectForKey:@"data"] objectForKey:@"meetinginfo"];
            [self viewfooter];
            tableview.delegate = self;
            tableview.dataSource = self;
            [tableview reloadData];
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
