//
//  MallStoreCycleAdDetailViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MallStoreCycleAdDetailViewController.h"

@interface MallStoreCycleAdDetailViewController ()

@end

@implementation MallStoreCycleAdDetailViewController

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
    [buttonright setTitle:@"保存" forState:UIControlStateNormal];
    buttonright.titleLabel.font = FONTN(15.0f);
    [buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonright addTarget:self action: @selector(ClickSave:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright addSubview:buttonright];
    buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    self.navigationItem.rightBarButtonItem = barButtonItemright;
    
    // Do any additional setup after loading the view.
}

-(void)initview
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"轮换广告详情";
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, SCREEN_HEIGHT-StatusBarAndNavigationHeight-80, SCREEN_WIDTH-40, 40);
    [button setTitle:@"删除" forState:UIControlStateNormal];
    button.titleLabel.font = FONTN(15.0f);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = COLORNOW(238, 89, 83);
    [button addTarget:self action:@selector(clickremove:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [self getcycleaddetail];
    
}

-(void)keyboardHide:(id)sender
{
    UITextField *textfield1 = [tableview viewWithTag:EnMallStoreAddNewCycleAdNameTextfield];
    
    [textfield1 resignFirstResponder];
    
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

-(UIView *)viewcellcommdity:(NSDictionary *)sender Frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 100, 100)];
    [imageview setImageWithURL:[NSURL URLWithString:[sender objectForKey:@"thumbpicture"]] placeholderImage:LOADIMAGE(@"testpic", @"png")];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    [view addSubview:imageview];
    
    CGSize size = [AddInterface getlablesize:[sender objectForKey:@"commodityname"] Fwidth:SCREEN_WIDTH-230 Fheight:45 Sfont:FONTN(15.0f)];
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10,XYViewTop(imageview),size.width,size.height)];
    labeltitle.backgroundColor = [UIColor clearColor];
    labeltitle.textColor = [UIColor blackColor];
    labeltitle.font = FONTN(15.0f);
    labeltitle.numberOfLines=2;
    labeltitle.text = [sender objectForKey:@"commodityname"];
    [view addSubview:labeltitle];
    
    UILabel *lablemoneyflag = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labeltitle), XYViewBottom(imageview)-16, 10,10)];
    lablemoneyflag.text = @"￥";
    lablemoneyflag.font = FONTMEDIUM(12.0f);
    lablemoneyflag.textColor = [UIColor redColor];
    lablemoneyflag.backgroundColor = [UIColor clearColor];
    [view addSubview:lablemoneyflag];
    
    size = [AddInterface getlablesize:[NSString stringWithFormat:@"%@",[sender objectForKey:@"price"]] Fwidth:150 Fheight:20 Sfont:FONTMEDIUM(17.0f)];
    UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(lablemoneyflag)+1, XYViewBottom(imageview)-20, size.width, 20)];
    lablemoneyvalue.text = [NSString stringWithFormat:@"%@",[sender objectForKey:@"price"]];
    lablemoneyvalue.font = FONTMEDIUM(17.0f);
    lablemoneyvalue.textColor = [UIColor redColor];
    lablemoneyvalue.backgroundColor = [UIColor clearColor];
    [view addSubview:lablemoneyvalue];
    
    UILabel *labelpingjia = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10,XYViewTop(lablemoneyvalue)-20,120,20)];
    labelpingjia.backgroundColor = [UIColor clearColor];
    labelpingjia.textColor = COLORNOW(117, 117, 117);
    labelpingjia.font = FONTN(13.0f);
    labelpingjia.text = [NSString stringWithFormat:@"%@评价",[sender objectForKey:@"evaluatenumber"]];
    [view addSubview:labelpingjia];
    
    return view;
}

-(UIView *)viewcellactivity:(NSDictionary *)sender Frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 120, 80)];
    [imageview setImageWithURL:[NSURL URLWithString:[sender objectForKey:@"thumbpicture"]] placeholderImage:LOADIMAGE(@"testpic", @"png")];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    [view addSubview:imageview];
    
    CGSize size = [AddInterface getlablesize:[sender objectForKey:@"name"] Fwidth:SCREEN_WIDTH-230 Fheight:60 Sfont:FONTN(15.0f)];
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10,XYViewTop(imageview),size.width,size.height)];
    labeltitle.backgroundColor = [UIColor clearColor];
    labeltitle.textColor = [UIColor blackColor];
    labeltitle.font = FONTN(15.0f);
    labeltitle.text = [sender objectForKey:@"name"];
    labeltitle.numberOfLines = 3;
    [view addSubview:labeltitle];
    
    UILabel *labelpingjia = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labeltitle),XYViewBottom(imageview)-20,140,20)];
    labelpingjia.backgroundColor = [UIColor clearColor];
    labelpingjia.textColor = COLORNOW(117, 117, 117);
    labelpingjia.font = FONTN(13.0f);
    labelpingjia.text = [sender objectForKey:@"time"];
    [view addSubview:labelpingjia];
    
    return view;
}

#pragma mark ActionDelegate
-(void)DGSlectLinkSelectItemDong:(EnMallStoreLinkSelecttype)selectype SelectItem:(NSDictionary *)selectitem
{
    FCselectdic = selectitem;
    if(selectype == EnMallStoreLinkSelectCommodity)
    {
        FCurltype = @"commodity";
        FCurl = [selectitem objectForKey:@"commodityid"];
    }
    else
    {
        FCurltype = @"news";
        FCurl = [selectitem objectForKey:@"newsid"];
    }
    [tableview reloadData];
}

#pragma mark UItextfielddelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark IBAction
-(void)clickselectadpic
{
    [JPhotoMagenage getTakeLibryImageInController:self finish:^(UIImage *images) {
        NSLog(@"%@",images);
        UIImage *image = [AddInterface scaleToSize:images size:CGSizeMake(800, 800)];
        FCadimageview.image = image;
        FCimage = image;
        [self uploadcustompic];
    } cancel:^{
        
    }];
    
}

-(void)ClickSave:(id)sender
{
    UITextField *textfield1 = [tableview viewWithTag:EnMallStoreAddNewCycleAdNameTextfield];
    FCtitle = textfield1.text;
    
    if(([FCurl length]==0)||([FCurltype length]==0))
    {
        [MBProgressHUD showError:@"请填写内容" toView:app.window];
    }
    else if([FCtitle length]==0)
    {
        [MBProgressHUD showError:@"请填写主题" toView:app.window];
    }
    else if([FCuploadstrpic length]==0)
    {
        [MBProgressHUD showError:@"请选择图片" toView:app.window];
    }
    else
        [self uploadcyclead];
}

-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickremove:(id)sender
{
    [self deletecyclead];
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
    {
        return 40;
    }
    else if(indexPath.row == 1)
    {
        return 160;
    }
    else
    {
        return 100;
    }
    
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
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 70, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = COLORNOW(117, 117, 117);
    labelname.font = FONTN(15.0f);
    [cell.contentView addSubview:labelname];
    
    
    UIImageView *imagearraw = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30, 14, 7, 12)];
    imagearraw.image = LOADIMAGE(@"tbeaarrowright", @"png");
    
    
    UITextField *labelvalue = [[UITextField alloc] initWithFrame:CGRectMake(100,10,SCREEN_WIDTH-120,20)];
    labelvalue.backgroundColor = [UIColor clearColor];
    labelvalue.textColor = [UIColor blackColor];
    labelvalue.font = FONTN(15.0f);
    labelvalue.enabled = NO;
    labelvalue.delegate = self;
    
    
    switch (indexPath.row)
    {
        case 0:
            labelname.text = @"标题";
            labelvalue.enabled = YES;
            labelvalue.tag = EnMallStoreAddNewCycleAdNameTextfield;
            labelvalue.text = FCtitle;
            [cell.contentView addSubview:labelvalue];
            break;
        case 1:
            labelname.text = @"链接页面";
            labelvalue.placeholder = @"点击选择";
            if([FCurltype isEqualToString:@"commodity"])
            {
                labelvalue.text = @"店铺商品";
                [cell.contentView addSubview:[self viewcellcommdity:FCselectdic Frame:CGRectMake(80, 40, SCREEN_WIDTH-100, 90)]];
                [cell.contentView addSubview:labelvalue];
            }
            else if([FCurltype isEqualToString:@"news"])
            {
                labelvalue.text = @"店铺动态";
                [cell.contentView addSubview:[self viewcellactivity:FCselectdic Frame:CGRectMake(80, 40, SCREEN_WIDTH-100, 90)]];
                [cell.contentView addSubview:labelvalue];
            }
            [cell.contentView addSubview:imagearraw];
            
            
            break;
        case 2:
            labelname.text = @"图片";
            labelvalue.frame = CGRectMake(SCREEN_WIDTH-40, 30, 40, 40);
            labelvalue.text = @"修改";
            [cell.contentView addSubview:labelvalue];
            
            FCadimageview  = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-190, 80)];
            if(FCimage !=nil)
                FCadimageview.image = FCimage;
            else
                [FCadimageview setImageWithURL:[NSURL URLWithString:FCuploadstrpic] placeholderImage:LOADIMAGE(@"testpic", @"png")];
            FCadimageview.contentMode = UIViewContentModeScaleAspectFill;
            FCadimageview.clipsToBounds = YES;
            [cell.contentView addSubview:FCadimageview];
            
            break;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //   MallStoreLinkSelectItemViewController *linkselect;
    
    UITextField *textfield1 = [tableview viewWithTag:EnMallStoreAddNewCycleAdNameTextfield];
    FCtitle = textfield1.text;
    
    MallStoreLinkSelectItemPageViewController *linkselectpage;
    switch (indexPath.row)
    {
        case 1:
            linkselectpage = [[MallStoreLinkSelectItemPageViewController alloc] init];
            linkselectpage.delegate1 = self;
            [self.navigationController pushViewController:linkselectpage animated:YES];
            break;
        case 2:
            [self clickselectadpic];
            break;
        default:
            break;
    }
}


#pragma mark 接口
-(void)uploadcustompic
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //    params[@"meetingcontent"] = @"测试内容。。。。。。。";
    
    NSMutableArray *arrayimage = [[NSMutableArray alloc] init];
    [arrayimage addObject:FCimage];
    
    
    [RequestInterface doGetJsonWithArraypic:arrayimage Parameter:params App:app RequestCode:RQUploadCustomPicCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCuploadstrpic = [[[dic objectForKey:@"data"] objectForKey:@"pictureinfo"] objectForKey:@"picturesavenames"];
            
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
        
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
    }];
}

-(void)uploadcyclead
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"advertiseid"] = _FCadvertiseid;
    params[@"title"] = FCtitle;
    params[@"urltype"] = FCurltype;
    params[@"url"] = FCurl;
    params[@"picture"] = FCuploadstrpic;
    
    
    DLog(@"params===%@",params);
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQStoreAddNewsGoodsInfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:app.window];
            [self returnback];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}

-(void)getcycleaddetail
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"advertiseid"] = _FCadvertiseid;
    
    
    DLog(@"params===%@",params);
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQStoreGetCycleAdDetailInfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCtitle = [[[dic objectForKey:@"data"] objectForKey:@"shopadvertiseinfo"] objectForKey:@"title"];
            FCurltype = [[[dic objectForKey:@"data"] objectForKey:@"shopadvertiseinfo"] objectForKey:@"urltype"];
            if([FCurltype isEqualToString:@"commodity"])
            {
                FCselectdic = [[dic objectForKey:@"data"] objectForKey:@"commodityinfo"];
                FCurl = [FCselectdic objectForKey:@"commodityid"];
            }
            else if([FCurltype isEqualToString:@"news"])
            {
                FCselectdic = [[dic objectForKey:@"data"] objectForKey:@"newsinfo"];
                FCurl = [FCselectdic objectForKey:@"newsid"];
            }
            
            FCuploadstrpic = [[[FCselectdic objectForKey:@"data"] objectForKey:@"shopadvertiseinfo"] objectForKey:@"picture"];
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

-(void)deletecyclead
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"advertiseid"] = _FCadvertiseid;
    
    
    DLog(@"params===%@",params);
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQStoreCycleAdDeleteListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:app.window];
            [self returnback];
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
