//
//  ShangJiaZiLiaoViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/12/19.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ShangJiaZiLiaoViewController.h"

@interface ShangJiaZiLiaoViewController ()

@end

@implementation ShangJiaZiLiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initview];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, StatusBarHeight+2, 40, 40)];
    [button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
    [button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // Do any additional setup after loading the view.
}

#pragma mark 页面布局

-(void)initview
{
    self.title = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.estimatedRowHeight = 0;
    tableview.estimatedSectionHeaderHeight = 0;
    tableview.estimatedSectionFooterHeight = 0;
    if (@available(iOS 11.0, *)) {
        tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
    }
    
    [self.view insertSubview:tableview atIndex:0];
    
    [self setExtraCellLineHidden:tableview];
    [self getshangjiainfo];
}

-(void)viewheader
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    view.backgroundColor = COLORNOW(0, 170, 238);
    
    UILabel *lable = [AddCustomView CusViewLabelForStyle:CGRectMake(20, XYViewHeight(view)-40, 100, 25) BGColor:[UIColor clearColor] Title:@"商家资料" TColor:[UIColor whiteColor] Font:FONTMEDIUM(22.0f) LineNumber:1];
    [view addSubview:lable];
    
    tableview.tableHeaderView = view;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
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
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *reuseIdetify = @"cell";
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 90, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = COLORNOW(117, 117, 117);
    labelname.font = FONTN(15.0f);
    
    UITextField *labelvalue = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-120, 20)];
    labelvalue.backgroundColor = [UIColor clearColor];
    labelvalue.textColor = [UIColor blackColor];
    labelvalue.font = FONTN(15.0f);
    labelvalue.delegate = self;
    labelvalue.enabled = NO;
    
    switch (indexPath.row)
    {
        case 0:
            labelname.text = @"商铺名称";
            [cell.contentView addSubview:labelname];
            
            labelvalue.text = [FCdistributorinfo objectForKey:@"companyname"];
            [cell.contentView addSubview:labelvalue];
            
            break;
        case 1:
            labelname.text = @"法人";
            [cell.contentView addSubview:labelname];
            
            labelvalue.text = [FCdistributorinfo objectForKey:@"mastername"];
            [cell.contentView addSubview:labelvalue];
            break;
        case 2:
            labelname.text = @"性别";
            [cell.contentView addSubview:labelname];
            
            labelvalue.text = [FCdistributorinfo objectForKey:@"mastersex"];
            [cell.contentView addSubview:labelvalue];
            break;
        case 3:
            labelname.text = @"年龄";
            [cell.contentView addSubview:labelname];
            
            labelvalue.text = [FCdistributorinfo objectForKey:@"masterage"];
            [cell.contentView addSubview:labelvalue];
            
            break;
        case 4:
            labelname.text = @"电话";
            [cell.contentView addSubview:labelname];
            
            labelvalue.text = [FCdistributorinfo objectForKey:@"mobilenumber"];
            [cell.contentView addSubview:labelvalue];
            break;
        case 5:
            labelname.text = @"认证状态";
            [cell.contentView addSubview:labelname];
            
            labelvalue.text = [FCdistributorinfo objectForKey:@"identifystatus"];
            [cell.contentView addSubview:labelvalue];
            break;
        case 6:
            labelname.text = @"隶属";
            [cell.contentView addSubview:labelname];
            
 //           labelvalue.text = [FCdistributorinfo objectForKey:@"identifystatus"];
            [cell.contentView addSubview:labelvalue];
            break;
        case 7:
            labelname.text = @"旗下水电工";
            [cell.contentView addSubview:labelname];
            
//            labelvalue.text = [FCdistributorinfo objectForKey:@"identifystatus"];
            [cell.contentView addSubview:labelvalue];
            break;
        case 8:
            labelname.text = @"扫码返利";
            [cell.contentView addSubview:labelname];
            
//            labelvalue.text = [FCdistributorinfo objectForKey:@"identifystatus"];
            [cell.contentView addSubview:labelvalue];
            break;
        case 9:
            labelname.text = @"举办的会议";
            [cell.contentView addSubview:labelname];
            
 //           labelvalue.text = [FCdistributorinfo objectForKey:@"identifystatus"];
            [cell.contentView addSubview:labelvalue];
            break;
        case 10:
            labelname.text = @"线上店铺";
            [cell.contentView addSubview:labelname];
            
            labelvalue.text = [FCdistributorinfo objectForKey:@"onlineshop"];
            [cell.contentView addSubview:labelvalue];
            break;
        case 11:
            labelname.text = @"商家介绍";
            [cell.contentView addSubview:labelname];
            
 //           labelvalue.text = [FCdistributorinfo objectForKey:@"identifystatus"];
            [cell.contentView addSubview:labelvalue];
            break;
            
    }
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark 接口
-(void)getshangjiainfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"distributorid"]= _FCdistributorid;
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQShangJiaZiLiaoInfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCdistributorinfo = [[dic objectForKey:@"data"] objectForKey:@"distributorinfo"];
            tableview.delegate = self;
            tableview.dataSource = self;
            [self viewheader];
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
