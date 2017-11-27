//
//  AuthNotPassReasonViewController.m
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/11/1.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "AuthNotPassReasonViewController.h"

@interface AuthNotPassReasonViewController ()

@end

@implementation AuthNotPassReasonViewController

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
    self.title = @"审核拒绝";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    
    UIButton *buttonnext = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonnext.frame = CGRectMake(20, SCREEN_HEIGHT-70-StatusBarAndNavigationHeight, SCREEN_WIDTH-40, 40);
    [buttonnext setTitle:@"重新认证" forState:UIControlStateNormal];
    buttonnext.layer.cornerRadius = 3.0f;
    buttonnext.clipsToBounds = YES;
    [buttonnext addTarget:self action:@selector(gotonext:) forControlEvents:UIControlEventTouchUpInside];
    [buttonnext setBackgroundColor:COLORNOW(0, 170, 238)];
    [self.view addSubview:buttonnext];
    
    [self getauthbusinessreason];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
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

-(void)gotonext:(id)sender
{
    UserAuthorizationViewController *userauth = [[UserAuthorizationViewController alloc] init];
    [self.navigationController pushViewController:userauth animated:YES];
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
    return [FCarraydata count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    viewheader.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39.3, SCREEN_WIDTH, 0.7)];
    imageline.backgroundColor = COLORNOW(220, 220, 220);
    [viewheader addSubview:imageline];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = [UIColor blackColor];
    labelname.font = FONTB(15.0f);
    labelname.text = @"系统拒绝理由";
    [viewheader addSubview:labelname];
    
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
    
    NSDictionary *dictemp  = [FCarraydata objectAtIndex:indexPath.row];
    
    UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(20, 8, 24, 24)];
    imageheader.backgroundColor = COLORNOW(0, 170, 238);
    imageheader.layer.cornerRadius = 12.0f;
    imageheader.clipsToBounds = YES;
    [cell.contentView addSubview:imageheader];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(imageheader), XYViewTop(imageheader), 24, 24)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textAlignment = NSTextAlignmentCenter;
    labelname.textColor = [UIColor whiteColor];
    labelname.font = FONTN(13.0f);
    labelname.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    [cell.contentView addSubview:labelname];
    
    UILabel *labeldes = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, 10, SCREEN_WIDTH-60, 20)];
    labeldes.backgroundColor = [UIColor clearColor];
    labeldes.text = [dictemp objectForKey:@"reason"];
    labeldes.textColor = [UIColor blackColor];
    labeldes.font = FONTN(15.0f);
    [cell.contentView addSubview:labeldes];
    


    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark 接口
-(void)getauthbusinessreason
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQUserAuthBusinessFailReasonCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"failedreasonlist"];
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
