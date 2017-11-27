//
//  TbeaContactViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/15.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "TbeaContactViewController.h"

@interface TbeaContactViewController ()

@end

@implementation TbeaContactViewController

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
    self.title = @"联系方式";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    [self getcontactlist];
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
-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *reuseIdetify = @"cell";
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, SCREEN_WIDTH-70, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = [UIColor blackColor];
    labelname.font = FONTN(15.0f);
    
    
    UIImageView *imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30, 16, 17, 18)];
    imageviewicon.image = LOADIMAGE(@"tbeateliconblue", @"png");
    
    
    if(indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0:
                
                labelname.text = [FCdiccontact objectForKey:@"name"];
                [cell.contentView addSubview:labelname];
                
                break;
            case 1:
                labelname.text = [FCdiccontact objectForKey:@"address"];
                [cell.contentView addSubview:labelname];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 2:
                labelname.text = [NSString stringWithFormat:@"邮编:%@",[FCdiccontact objectForKey:@"zipcode"]];
                [cell.contentView addSubview:labelname];
                break;
            case 3:
                labelname.text = [NSString stringWithFormat:@"平台服务电话:%@",[FCdiccontact objectForKey:@"platformservicetel"]];
                [cell.contentView addSubview:labelname];
                
                [cell.contentView addSubview:imageviewicon];
                break;
            case 4:
                labelname.text =  [NSString stringWithFormat:@"传真:%@",[FCdiccontact objectForKey:@"fax"]];
                [cell.contentView addSubview:labelname];
                break;
            case 5:
                labelname.text = [NSString stringWithFormat:@"德缆公司:%@",[FCdiccontact objectForKey:@"delantel"]];//@"德缆公司:400-887-7880";
                [cell.contentView addSubview:labelname];
                [cell.contentView addSubview:imageviewicon];
                break;
            case 6:
                labelname.text = [NSString stringWithFormat:@"集团公司:%@",[FCdiccontact objectForKey:@"tbeatel"]];//@"集团公司:400-687-1000";
                [cell.contentView addSubview:labelname];
                [cell.contentView addSubview:imageviewicon];
                break;
                
        }
    }
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark 接口
//获取联系方式
-(void)getcontactlist
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
//    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQproductTbeaContactCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
//        
//    } Success:^(NSDictionary *dic) {
//        DLog(@"dic====%@",dic);
//        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
//        {
//            FCdiccontact = [[dic objectForKey:@"data"] objectForKey:@"contactinfo"];
//            [tableview reloadData];
//        }
//        else
//        {
//            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
//        }
//    } Failur:^(NSString *strmsg) {
//        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
//        
//    }];
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
