//
//  MallStoreGoodsSalesDetailViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/9/3.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MallStoreGoodsSalesDetailViewController.h"

@interface MallStoreGoodsSalesDetailViewController ()

@end

@implementation MallStoreGoodsSalesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self initview];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    button.layer.borderColor = [UIColor clearColor].CGColor;
    [button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 44)];
    UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
    [buttonright setTitle:@"商品编辑" forState:UIControlStateNormal];
    buttonright.titleLabel.font = FONTN(15.0f);
    [buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonright addTarget:self action: @selector(clickgoodsedit:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright addSubview:buttonright];
    buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    self.navigationItem.rightBarButtonItem = barButtonItemright;
    
    // Do any additional setup after loading the view.
}

#pragma mark 页面布局
-(void)initview
{
    self.title = @"销量详情";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
    //    _FCcommodityid = @"yzmrcy1438659649msvtod";
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getgoodssaledetail];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
}

-(UIButton *)initbutton:(NSString *)title Frame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    button.titleLabel.font = FONTN(15.0f);
    
    return button;
}

-(void)initheaderview:(NSDictionary *)sender Frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    tableview.tableHeaderView = view;
    
    UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height-1, SCREEN_WIDTH, 1)];
    imageviewline.backgroundColor = COLORNOW(230, 230, 230);
    [view addSubview:imageviewline];
    
    UIImageView *imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 100, 100)];
    NSString *strpic = [sender objectForKey:@"thumbpicture"];
    [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"testpic", @"png")];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    [view addSubview:imageview];
    
    CGSize size = [AddInterface getlablesize:[sender objectForKey:@"commodityname"] Fwidth:SCREEN_WIDTH-140 Fheight:40 Sfont:FONTN(15.0f)];
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10,XYViewTop(imageview),size.width,size.height)];
    labeltitle.backgroundColor = [UIColor clearColor];
    labeltitle.textColor = [UIColor blackColor];
    labeltitle.font = FONTN(15.0f);
    labeltitle.text = [sender objectForKey:@"commodityname"];
    labeltitle.numberOfLines = 2;
    [view addSubview:labeltitle];
    
    UILabel *lablemoneyflag = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labeltitle), XYViewBottom(imageview)-20, 63,20)];
    lablemoneyflag.text = @"商品价格:";
    lablemoneyflag.font = FONTN(14.0f);
    lablemoneyflag.textColor = COLORNOW(117, 117, 117);
    lablemoneyflag.backgroundColor = [UIColor clearColor];
    [view addSubview:lablemoneyflag];
    
    
    UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(lablemoneyflag), XYViewTop(lablemoneyflag), 150, 20)];
    lablemoneyvalue.text = [NSString stringWithFormat:@"￥%@",[sender objectForKey:@"price"]];
    lablemoneyvalue.font = FONTMEDIUM(14.0f);
    lablemoneyvalue.textColor = [UIColor redColor];
    lablemoneyvalue.backgroundColor = [UIColor clearColor];
    [view addSubview:lablemoneyvalue];
    
    UILabel *labelpingjia = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labeltitle),XYViewTop(lablemoneyvalue)-20,200,20)];
    labelpingjia.backgroundColor = [UIColor clearColor];
    labelpingjia.textColor = COLORNOW(117, 117, 117);
    labelpingjia.font = FONTN(14.0f);
    labelpingjia.text = [NSString stringWithFormat:@"发布时间:%@",[sender objectForKey:@"publishtime"]];
    [view addSubview:labelpingjia];
    
}

#pragma mark IBAction
-(void)clickgoodsedit:(id)sender
{
    
}

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
    return 2;
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
    
    //   NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = COLORNOW(117, 117, 117);
    labelname.font = FONTN(15.0f);
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40-100, 5,100, 30)];
    textfield.textColor = [UIColor blackColor];
    textfield.backgroundColor = [UIColor clearColor];
    textfield.font = FONTN(16.0f);
    textfield.enabled = NO;
    textfield.textAlignment = NSTextAlignmentRight;
    
    if(indexPath.section == 0)
    {
        switch (indexPath.row)
        {
                
            case 0:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                labelname.text = @"已出售";
                [cell.contentView addSubview:labelname];
                
                
                textfield.text = [NSString stringWithFormat:@"%@",[FCsaleinfo objectForKey:@"salenumber"]];
                [cell.contentView addSubview:textfield];
                break;
            case 1:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                labelname.text = @"已评价";
                [cell.contentView addSubview:labelname];
                
                textfield.text = [NSString stringWithFormat:@"%@",[FCsaleinfo objectForKey:@"evaluatenumber"]];
                [cell.contentView addSubview:textfield];
                break;
        }
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        MallStoreHasBeenSoldDetailViewController *hasbeensold = [[MallStoreHasBeenSoldDetailViewController alloc] init];
        hasbeensold.FCcommodityid = _FCcommodityid;
        [self.navigationController pushViewController:hasbeensold animated:YES];
    }
    else if(indexPath.row == 1)
    {
        MallStoreHasBeenEvaluatenViewController *hasbeensold = [[MallStoreHasBeenEvaluatenViewController alloc] init];
        hasbeensold.FCcommodityid = _FCcommodityid;
        [self.navigationController pushViewController:hasbeensold animated:YES];
    }
    
}

#pragma mark 接口
-(void)getgoodssaledetail
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"commodityid"] = _FCcommodityid;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQStoreGoodsSalesDetailINfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCcommdityinfo = [[dic objectForKey:@"data"] objectForKey:@"commodityinfo"];
            FCsaleinfo = [[dic objectForKey:@"data"] objectForKey:@"saleinfo"];
            [self initheaderview:FCcommdityinfo Frame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
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
