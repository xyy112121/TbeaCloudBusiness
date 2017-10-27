//
//  SonAccountAuthorizeViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "SonAccountAuthorizeViewController.h"

@interface SonAccountAuthorizeViewController ()

@end

@implementation SonAccountAuthorizeViewController

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
    
    [self initview];
    // Do any additional setup after loading the view.
}

-(void)initview
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [self viewheader];
    [self setExtraCellLineHidden:tableview];
    
    UIButton *buttonnext = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonnext.frame = CGRectMake(20, SCREEN_HEIGHT-70-64, SCREEN_WIDTH-40, 40);
    [buttonnext setTitle:@"保存" forState:UIControlStateNormal];
    buttonnext.layer.cornerRadius = 3.0f;
    buttonnext.clipsToBounds = YES;
    [buttonnext addTarget:self action:@selector(savesonaccount:) forControlEvents:UIControlEventTouchUpInside];
    [buttonnext setBackgroundColor:COLORNOW(0, 170, 238)];
    [self.view addSubview:buttonnext];
    [self getsonaccountlist];
}

-(void)viewheader
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    
    UILabel *labelfunction = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 100, 20)];
    labelfunction.backgroundColor = [UIColor clearColor];
    labelfunction.textColor = [UIColor blackColor];
    labelfunction.text = @"功能";
    labelfunction.clipsToBounds = YES;
    labelfunction.font = FONTB(16.0f);
    [view addSubview:labelfunction];
    
    UILabel *labelevent = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-100, 15, 100, 20)];
    labelevent.backgroundColor = [UIColor clearColor];
    labelevent.textColor = [UIColor blackColor];
    labelevent.text = @"事件";
    labelevent.clipsToBounds = YES;
    labelevent.textAlignment = NSTextAlignmentRight;
    labelevent.font = FONTB(16.0f);
    [view addSubview:labelevent];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0,49, SCREEN_WIDTH, 1.0)];
    imageline.backgroundColor = COLORNOW(230, 230, 230);
    [view addSubview:imageline];
    
    //四个按钮
    tableview.tableHeaderView = view;
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

#pragma mark IBaction
-(void)clickbtoption:(id)sender
{
    UIButton *buttonoption = (id)sender;
    UIButton *buttonlook = [tableview viewWithTag:buttonoption.tag+1];
    int tagnow = (int)(buttonoption.tag - EnSonAccountFunctionAuthorBtTag)/2;
    [buttonoption setImage:LOADIMAGE(@"me默认收货地址", @"png") forState:UIControlStateNormal];
    [buttonlook setImage:LOADIMAGE(@"menotselectgray", @"png") forState:UIControlStateNormal];
    NSDictionary *diclook = [FCarrayitemlist objectAtIndex:tagnow];
    for(int i=0;i<[_FCarrayauthor count];i++)
    {
        NSDictionary *dictemp = [_FCarrayauthor objectAtIndex:i];
        if([[dictemp objectForKey:@"moduleid"] isEqualToString:[diclook objectForKey:@"moduleid"]])
        {
            [_FCarrayauthor removeObject:dictemp];
        }
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"moduleid"] = [diclook objectForKey:@"moduleid"];
    params[@"canoperation"] = @"yes";
    params[@"canview"] = @"no";
    [_FCarrayauthor addObject:params];
}

-(void)clickbtlook:(id)sender
{
    UIButton *buttonlook = (UIButton *)sender;
    UIButton *buttonoption = [tableview viewWithTag:(int)buttonlook.tag-1];
    int tagnow = (int)(buttonlook.tag - EnSonAccountFunctionAuthorBtTag)/2;
    [buttonlook setImage:LOADIMAGE(@"me默认收货地址", @"png") forState:UIControlStateNormal];
    [buttonoption setImage:LOADIMAGE(@"menotselectgray", @"png") forState:UIControlStateNormal];
    
    NSDictionary *diclook = [FCarrayitemlist objectAtIndex:tagnow];
    for(int i=0;i<[_FCarrayauthor count];i++)
    {
        NSDictionary *dictemp = [_FCarrayauthor objectAtIndex:i];
        if([[dictemp objectForKey:@"moduleid"] isEqualToString:[diclook objectForKey:@"moduleid"]])
        {
            [_FCarrayauthor removeObject:dictemp];
        }
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"moduleid"] = [diclook objectForKey:@"moduleid"];
    params[@"canoperation"] = @"no";
    params[@"canview"] = @"yes";
    [_FCarrayauthor addObject:params];
}

-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)savesonaccount:(id)sender
{
    if([self.delegate1 respondsToSelector:@selector(DGSaveSonAccountFunctionAuthorList:)])
    {
        [self.delegate1 DGSaveSonAccountFunctionAuthorList:_FCarrayauthor];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ActionDelegate


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
    
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [FCarrayitemlist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *reuseIdetify = @"cell";
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *dictemp = [FCarrayitemlist objectAtIndex:indexPath.row];
    
    UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 16, 18, 18)];
    NSString *strpic = [dictemp objectForKey:@"moduleicon"];//[NSString stringWithFormat:@"%@%@",InterfaceResource,[dictemp objectForKey:@"moduleicon"]];
    [imageicon setImageWithURL:[NSURL URLWithString:strpic]];
    [cell.contentView addSubview:imageicon];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageicon)+10, 15, 150, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = [UIColor blackColor];
    labelname.text = [dictemp objectForKey:@"modulename"];
    labelname.font = FONTN(15.0f);
    [cell.contentView addSubview:labelname];
    
    UIButton *buttonopation = [UIButton buttonWithType:UIButtonTypeCustom];
    if([[dictemp objectForKey:@"canoperation"] isEqualToString:@"no"])
        [buttonopation setImage:LOADIMAGE(@"menotselectgray", @"png") forState:UIControlStateNormal];
    else
        [buttonopation setImage:LOADIMAGE(@"me默认收货地址", @"png") forState:UIControlStateNormal];
    buttonopation.frame = CGRectMake(SCREEN_WIDTH-20-70, 10, 70, 30);
    [buttonopation setTitle:@"操作" forState:UIControlStateNormal];
    [buttonopation setImageEdgeInsets:UIEdgeInsetsMake(0, 45, 0, 0)];
    [buttonopation setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [buttonopation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    buttonopation.titleLabel.font = FONTN(15.0f);
    buttonopation.tag = EnSonAccountFunctionAuthorBtTag+(indexPath.row*2);
    [buttonopation addTarget:self action:@selector(clickbtoption:) forControlEvents:UIControlEventTouchUpInside];
    [buttonopation setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:buttonopation];
    
    UIButton *buttonlook = [UIButton buttonWithType:UIButtonTypeCustom];
    if([[dictemp objectForKey:@"canview"] isEqualToString:@"YES"])
        [buttonlook setImage:LOADIMAGE(@"me默认收货地址", @"png") forState:UIControlStateNormal];
    else
        [buttonlook setImage:LOADIMAGE(@"menotselectgray", @"png") forState:UIControlStateNormal];
    buttonlook.frame = CGRectMake(SCREEN_WIDTH-20-70-80, 10, 70, 30);
    [buttonlook setTitle:@"查看" forState:UIControlStateNormal];
    [buttonlook setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonlook setImageEdgeInsets:UIEdgeInsetsMake(0, 45, 0, 0)];
    [buttonlook setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    buttonlook.tag = EnSonAccountFunctionAuthorBtTag+(indexPath.row*2)+1;
    [buttonlook addTarget:self action:@selector(clickbtlook:) forControlEvents:UIControlEventTouchUpInside];
    buttonlook.titleLabel.font = FONTN(15.0f);
    [cell.contentView addSubview:buttonlook];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark 接口
-(void)getsonaccountlist
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQUserCenterSonAccountFunctionCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarrayitemlist = [[dic objectForKey:@"data"] objectForKey:@"modulelist"];
            if([_FCarrayauthor count]>0)
            {
                
            }
            else
            {
                _FCarrayauthor = [[NSMutableArray alloc] init];
                for(int i=0;i<[_FCarrayauthor count];i++)
                {
                    NSDictionary *dictemp = [_FCarrayauthor objectAtIndex:i];
                    NSMutableDictionary *params = [NSMutableDictionary dictionary];
                    params[@"moduleid"] = [dictemp objectForKey:@"moduleid"];
                    params[@"canview"] = [dictemp objectForKey:@"canview"];
                    params[@"canoperation"] = [dictemp objectForKey:@"canoperation"];
                    [_FCarrayauthor addObject:params];
                }
            }
            
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
