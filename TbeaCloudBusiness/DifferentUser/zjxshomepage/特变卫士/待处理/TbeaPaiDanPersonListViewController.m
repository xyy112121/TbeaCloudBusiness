//
//  TbeaPaiDanPersonListViewController.m
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/10/24.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "TbeaPaiDanPersonListViewController.h"

@interface TbeaPaiDanPersonListViewController ()

@end

@implementation TbeaPaiDanPersonListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
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
    
    UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
    UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
    [buttonright setTitle:@"派单" forState:UIControlStateNormal];
    buttonright.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
    [buttonright addTarget:self action: @selector(clickpaidandone:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright addSubview:buttonright];
    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    self.navigationItem.rightBarButtonItem = barButtonItemright;
    // Do any additional setup after loading the view.
}

#pragma mark 页面布局

-(void)initview
{
    self.title = @"检测人员选择";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    FCdicselectdata = nil;
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    [self getpaidanpersonlist];
}


-(void)viewcell1:(NSDictionary *)dicfrom FromCell:(UITableViewCell *)fromcell IndexTag:(int)indextag
{
    
    UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
    NSString *strpic = [dicfrom objectForKey:@"thumbpicture"];//[InterfaceResource stringByAppendingString:[[dicfrom objectForKey:@"thumbpicture"] length]>0?[dicfrom objectForKey:@"thumbpicture"]:@"noimage.png"];
    [imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
    imageheader.layer.cornerRadius = 15.0f;
    imageheader.clipsToBounds = YES;
    [fromcell.contentView addSubview:imageheader];
    
    CGSize sizeuser = [AddInterface getlablesize:[dicfrom objectForKey:@"name"] Fwidth:200 Fheight:20 Sfont:FONTMEDIUM(16.0f)];
    UILabel *labelusername = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, 7, sizeuser.width, 20)];
    labelusername.backgroundColor = [UIColor clearColor];
    labelusername.textColor = [UIColor blackColor];
    labelusername.font = FONTMEDIUM(16.0f);
    labelusername.text = [dicfrom objectForKey:@"name"];
    [fromcell.contentView addSubview:labelusername];
    
    UILabel *straddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewBottom(labelusername), SCREEN_WIDTH-100, 18)];
    straddr.backgroundColor = [UIColor clearColor];
    straddr.textColor = COLORNOW(117, 117, 117);
    straddr.font = FONTN(13.0f);
    straddr.text = [dicfrom objectForKey:@"info"];
    [fromcell.contentView addSubview:straddr];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_WIDTH-50, 5, 40, 40);
    button.tag = EnComWaterJXSSelectCellTag;
    int flag = [self judgearraycontaindic:FCdicselectdata DicSrc:dicfrom];
    if(flag == 1)
    {
        [button setImage:LOADIMAGE(@"me默认收货地址", @"png") forState:UIControlStateNormal];
    }
    else
    {
        [button setImage:nil forState:UIControlStateNormal];
    }
    [fromcell.contentView addSubview:button];
    
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

#pragma mark ActionDelegate
-(void)DGTbeaSelectPersonPaiDanDone:(id)senders
{
    if([self.delegate1 respondsToSelector:@selector(DGTbeaSelectPaiDanPersonInfo:)])
    {
        [self.delegate1 DGTbeaSelectPaiDanPersonInfo:FCdicselectdata];
    }
    [self returnback];
}

#pragma mark IBaction
-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(int)judgearraycontaindic:(NSDictionary *)dicselect DicSrc:(NSDictionary *)dicsrc
{
    if(dicselect == nil)
        return 0;
    int flag = 0;
    if([[dicselect objectForKey:@"electricianid"] isEqualToString:[dicsrc objectForKey:@"electricianid"]])
    {
        flag = 1;
    }
    return flag;
}

-(void)clickpaidandone:(id)sender
{
    if(FCdicselectdata !=nil)
    {
        PopCustomDoneView *alert =[[PopCustomDoneView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, SCREEN_HEIGHT) strFrom:[NSString stringWithFormat:@"你派单的人员为 %@ ,请确认!",[FCdicselectdata objectForKey:@"name"]] BtTitle:@"派单"];
        alert.delegate1=self;
        [self.view addSubview:alert];
    }
    else
    {
        [MBProgressHUD showError:@"请选择派单对象" toView:app.window];
    }
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
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [FCarraydata count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    return nil;
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
    
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    [self viewcell1:dictemp FromCell:cell IndexTag:(int)indexPath.row];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIButton *button = [cell.contentView viewWithTag:EnComWaterJXSSelectCellTag];
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    
    int flag = [self judgearraycontaindic:FCdicselectdata DicSrc:dictemp];
    
    if(flag == 0)
    {
        [button setImage:LOADIMAGE(@"me默认收货地址", @"png") forState:UIControlStateNormal];
        FCdicselectdata = dictemp;
    }
    else
    {
        [button setImage:nil forState:UIControlStateNormal];
        FCdicselectdata = nil;
    }
    
    
}

#pragma mark 接口

-(void)getpaidanpersonlist
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQTbeaDaiChuLiPaiDanPersonListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraydata  = [[dic objectForKey:@"data"] objectForKey:@"electricianlist"];
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
