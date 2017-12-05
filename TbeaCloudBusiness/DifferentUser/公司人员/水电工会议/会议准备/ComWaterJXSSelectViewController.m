//
//  ComWaterJXSSelectViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/31.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ComWaterJXSSelectViewController.h"

@interface ComWaterJXSSelectViewController ()

@end

@implementation ComWaterJXSSelectViewController

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
    // Do any additional setup after loading the view.
}

#pragma mark 页面布局

-(void)initview
{
    self.title = @"用户列表";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    FCarrayselectdata = [[NSMutableArray alloc] init];
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    [self getjsxlist];
}


-(void)viewcell1:(NSDictionary *)dicfrom FromCell:(UITableViewCell *)fromcell IndexTag:(int)indextag
{
    
    UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
    NSString *strpic = [dicfrom objectForKey:@"masterthumbpicture"];
    [imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
    imageheader.layer.cornerRadius = 15.0f;
    imageheader.clipsToBounds = YES;
    [fromcell.contentView addSubview:imageheader];
    
    CGSize sizeuser = [AddInterface getlablesize:[dicfrom objectForKey:@"mastername"] Fwidth:200 Fheight:20 Sfont:FONTMEDIUM(16.0f)];
    UILabel *labelusername = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, 7, sizeuser.width, 20)];
    labelusername.backgroundColor = [UIColor clearColor];
    labelusername.textColor = [UIColor blackColor];
    labelusername.font = FONTMEDIUM(16.0f);
    labelusername.text = [dicfrom objectForKey:@"mastername"];
    [fromcell.contentView addSubview:labelusername];
    
    UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelusername)+5, XYViewTop(labelusername)+5, 25, 10)];
    NSString *strpic1 = [dicfrom objectForKey:@"companytypeicon"];
    [imageicon setImageWithURL:[NSURL URLWithString:strpic1] placeholderImage:LOADIMAGE(@"scanrebateheader1", @"png")];
    [fromcell.contentView addSubview:imageicon];
    
    UILabel *straddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewBottom(labelusername), SCREEN_WIDTH-100, 18)];
    straddr.backgroundColor = [UIColor clearColor];
    straddr.textColor = COLORNOW(117, 117, 117);
    straddr.font = FONTN(12.0f);
    straddr.text = [dicfrom objectForKey:@"name"];
    [fromcell.contentView addSubview:straddr];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_WIDTH-50, 5, 40, 40);
    button.tag = EnComWaterJXSSelectCellTag;
    int flag = [self judgearraycontaindic:FCarrayselectdata DicSrc:dicfrom];
    if(flag == 1)
    {
        [button setImage:LOADIMAGE(@"me默认收货地址", @"png") forState:UIControlStateNormal];
    }
    else
    {
        [button setImage:nil forState:UIControlStateNormal];
    }
    [button addTarget:self action:@selector(clickselectbt:) forControlEvents:UIControlEventTouchUpInside];
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



#pragma mark IBaction
-(void)returnback
{
    if([self.delegate1 respondsToSelector:@selector(DGSelectJXSCellView:)])
    {
        [self.delegate1 DGSelectJXSCellView:FCarrayselectdata];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(int)judgearraycontaindic:(NSMutableArray *)arraydata DicSrc:(NSDictionary *)dicsrc
{
    int flag = 0;
    for(int i=0;i<[FCarrayselectdata count];i++)
    {
        NSDictionary *dicselect = [FCarrayselectdata objectAtIndex:i];
        if([[dicselect objectForKey:@"id"] isEqualToString:[dicsrc objectForKey:@"id"]])
        {
            flag = 1;
            break;
        }
    }
    
    return flag;
}

-(void)clickselectbt:(id)sender
{
    
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
    return 40;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    viewheader.backgroundColor = [UIColor whiteColor];
    viewheader.layer.borderColor = COLORNOW(210, 210, 210).CGColor;
    viewheader.layer.borderWidth = 0.7;
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(18, 5, 40, 30)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = [UIColor blackColor];
    labelname.text = @"数量";
    labelname.clipsToBounds = YES;
    labelname.font = FONTMEDIUM(15.0f);
    [viewheader addSubview:labelname];
    
    UILabel *labelnumber = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-120, 5, 100, 30)];
    labelnumber.backgroundColor = [UIColor clearColor];
    labelnumber.textColor = [UIColor blackColor];
    labelnumber.text = [NSString stringWithFormat:@"%d",0];
    labelnumber.clipsToBounds = YES;
    labelnumber.tag = EnComWaterJXSSelectNumberTag;
    labelnumber.text = [NSString stringWithFormat:@"%d",(int)[FCarrayselectdata count]];
    labelnumber.textAlignment = NSTextAlignmentRight;
    labelnumber.font = FONTMEDIUM(15.0f);
    [viewheader addSubview:labelnumber];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.7)];
    imageline.backgroundColor = COLORNOW(220, 220, 220);
    [viewheader addSubview:imageline];
    
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
    
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    [self viewcell1:dictemp FromCell:cell IndexTag:(int)indexPath.row];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIButton *button = [cell.contentView viewWithTag:EnComWaterJXSSelectCellTag];
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    
    int flag = [self judgearraycontaindic:FCarrayselectdata DicSrc:dictemp];
    
    if(flag == 0)
    {
        [button setImage:LOADIMAGE(@"me默认收货地址", @"png") forState:UIControlStateNormal];
        [FCarrayselectdata addObject:dictemp];
    }
    else
    {
        [button setImage:nil forState:UIControlStateNormal];
        [FCarrayselectdata removeObject:dictemp];
    }
    
    UILabel *label = [tableView viewWithTag:EnComWaterJXSSelectNumberTag];
    label.text = [NSString stringWithFormat:@"%d",(int)[FCarrayselectdata count]];
}

#pragma mark 接口

-(void)getjsxlist
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"provinceidwithuser"] = @"1";
    params[@"cityidwithuser"] = @"1";
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQComWaterMettingJSXSelectListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraydata  = [[dic objectForKey:@"data"] objectForKey:@"distributorlist"];
            FCarrayselectdata = [[NSMutableArray alloc] initWithArray:self.FCselectdata];
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
