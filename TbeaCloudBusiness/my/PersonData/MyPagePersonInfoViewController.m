//
//  MyPagePersonInfoViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/12/4.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyPagePersonInfoViewController.h"

@interface MyPagePersonInfoViewController ()

@end

@implementation MyPagePersonInfoViewController

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
    //    self.view.backgroundColor = COLORNOW(0, 170, 238);
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
    [self getmyselfinfo];
}

-(void)viewheader
{
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    view.backgroundColor = COLORNOW(0, 170, 238);
    
    //    FCimageheader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, XYViewHeight(view))];
    //    [view addSubview:FCimageheader];
    
    UILabel *lable = [AddCustomView CusViewLabelForStyle:CGRectMake(20, XYViewHeight(view)-40, 100, 25) BGColor:[UIColor clearColor] Title:@"个人资料" TColor:[UIColor whiteColor] Font:FONTMEDIUM(22.0f) LineNumber:1];
    [view addSubview:lable];
    
    tableview.tableHeaderView = view;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

#pragma mark UItextfielddelegaet
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == EnMyPersonInfoTextfield3) //修改性别
    {
        [self clickserviceitem];
        return NO;
    }
    return NO;
}
#pragma mark 弹窗求
-(void)clickserviceitem  // 选择服务项目
{
    [self keyboardHide:nil];
    NSMutableArray *arraytemp = [[NSMutableArray alloc] init];
    
    [arraytemp addObject:@"先生"];
    [arraytemp addObject:@"女士"];
    
    [ZJBLStoreShopTypeAlert showWithTitle:@"性别选择" titles:arraytemp deleGate1:self selectIndex:^(NSInteger selectIndex) {
    } selectValue:^(NSString *selectValue) {
        DLog(@"selectvalue====%@",selectValue);
        UITextField *textfield2 = [tableview viewWithTag:EnMyPersonInfoTextfield3];
        textfield2.text = selectValue;
        FCSex = selectValue;
    } showCloseButton:YES];
}


#pragma mark IBaction
-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)keyboardHide:(id)sender
{
    UITextField *textfield1 = [tableview viewWithTag:EnMyPersonInfoTextfield1];
    UITextField *textfield2 = [tableview viewWithTag:EnMyPersonInfoTextfield2];
    UITextField *textfield3 = [tableview viewWithTag:EnMyPersonInfoTextfield3];
    UITextField *textfield4 = [tableview viewWithTag:EnMyPersonInfoTextfield4];
    UITextField *textfield5 = [tableview viewWithTag:EnMyPersonInfoTextfield5];
    UITextField *textfield6 = [tableview viewWithTag:EnMyPersonInfoTextfield6];
    UITextField *textfield7 = [tableview viewWithTag:EnMyPersonInfoTextfield7];
    UITextField *textfield8 = [tableview viewWithTag:EnMyPersonInfoTextfield8];
    
//    FCtaskdescription = textfield2.text;
//    FCserviceusername = textfield3.text;
//    FCcontactmobile = textfield4.text;
//    FCresidencezonename = textfield5.text;
//    FCbudget =textfield8.text;
//    FCnote = textfield9.text;
    
    [textfield1 resignFirstResponder];
    [textfield2 resignFirstResponder];
    [textfield3 resignFirstResponder];
    [textfield4 resignFirstResponder];
    [textfield5 resignFirstResponder];
    [textfield6 resignFirstResponder];
    [textfield7 resignFirstResponder];
    [textfield8 resignFirstResponder];
}

#pragma mark 图片请求
-(void)picupload
{
    UIImageView *imageview = [tableview viewWithTag:EnMyPersonInfoImageView1];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择图片"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [JPhotoMagenage getTakeLibryImageInController:self finish:^(UIImage *images) {
            NSLog(@"%@",images);
            UIImage *image = [AddInterface scaleToSize:images size:CGSizeMake(800, 800)];
            imageview.image = image;
            FCUserImage = image;
            [self uploadcustompic:FCUserImage];
        } cancel:^{
            
        }];
    }];
    
    [alertController addAction:moreAction];
    
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [JPhotoMagenage getOneImageInController:self finish:^(UIImage *images) {
            NSLog(@"%@",images);
            UIImage *image = [AddInterface scaleToSize:images size:CGSizeMake(800, 800)];
            imageview.image = image;
            FCUserImage = image;
            [self uploadcustompic:FCUserImage];
        } cancel:^{
            
        }];
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
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
    if(indexPath.row == 1)
        return 50;
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
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
    
    UIImageView *imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake(100, 5, 40, 40)];
    
    
    
    NSString *strimage;
    switch (indexPath.row)
    {
        case 0:
            labelname.text = @"用户名";
            [cell.contentView addSubview:labelname];
            
            labelvalue.tag = EnMyPersonInfoTextfield1;
            labelvalue.text = [FCdicuserinfo objectForKey:@"username"];
            [cell.contentView addSubview:labelvalue];
            
            break;
        case 1:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            labelname.text = @"头像";
            [cell.contentView addSubview:labelname];
            
            strimage = [FCdicuserinfo objectForKey:@"thumbpicture"];
            imageviewicon.tag = EnMyPersonInfoImageView1;
            [imageviewicon setImageWithURL:[NSURL URLWithString:strimage] placeholderImage:nil];
            imageviewicon.layer.cornerRadius = 20.0f;
            imageviewicon.clipsToBounds = YES;
            
            [cell.contentView addSubview:imageviewicon];
            break;
        case 2:
            labelname.text = @"用户类别";
            [cell.contentView addSubview:labelname];
            
            labelvalue.tag = EnMyPersonInfoTextfield2;
//            labelvalue.text = [FCdicuserinfo objectForKey:@"age"];
//            [cell.contentView addSubview:labelvalue];
            break;
        case 3:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            labelname.text = @"性别";
            [cell.contentView addSubview:labelname];
            
            labelvalue.enabled = YES;
            labelvalue.tag = EnMyPersonInfoTextfield3;
            labelvalue.text = FCSex;
            [cell.contentView addSubview:labelvalue];
            
            break;
        case 4:
            labelname.text = @"年龄";
            [cell.contentView addSubview:labelname];
            
            labelvalue.tag = EnMyPersonInfoTextfield4;
            labelvalue.text = [FCdicuserinfo objectForKey:@"age"];
            [cell.contentView addSubview:labelvalue];
            break;
        case 5:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            labelname.text = @"地址";
            [cell.contentView addSubview:labelname];
            
            labelvalue.tag = EnMyPersonInfoTextfield5;
            labelvalue.text = [NSString stringWithFormat:@"%@%@%@%@",FCProvice,FCCity,FCZone,FCUserAddr];
            [cell.contentView addSubview:labelvalue];
            break;
        case 6:
            labelname.text = @"电话";
            [cell.contentView addSubview:labelname];
            
            labelvalue.tag = EnMyPersonInfoTextfield6;
            labelvalue.text = [FCdicuserinfo objectForKey:@"mobielnumber"];
            [cell.contentView addSubview:labelvalue];
            break;
        case 7:
            labelname.text = @"店铺";
            [cell.contentView addSubview:labelname];
            
            labelvalue.tag = EnMyPersonInfoTextfield7;
            labelvalue.text = [FCdicuserinfo objectForKey:@"companyname"];
            [cell.contentView addSubview:labelvalue];
            break;
        case 8:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            labelname.text = @"认证状态";
            [cell.contentView addSubview:labelname];
            
            labelvalue.tag = EnMyPersonInfoTextfield8;
            labelvalue.text = [FCdicuserinfo objectForKey:@"identifystatus"];
            [cell.contentView addSubview:labelvalue];
            break;
            
    }
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 1)
    {
        [self picupload];
    }
}


#pragma mark 接口
-(void)getmyselfinfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"electricianid"]= _FCelectricianid;
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:REMySelfPersoninfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCdicuserinfo = [[dic objectForKey:@"data"] objectForKey:@"userinfo"];
            FCSex = [FCdicuserinfo objectForKey:@"sex"];
            FCProvice = [FCdicuserinfo objectForKey:@"province"];
            FCCity = [FCdicuserinfo objectForKey:@"city"];
            FCZone = [FCdicuserinfo objectForKey:@"zone"];
            FCUserAddr = [FCdicuserinfo objectForKey:@"addr"];
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

-(void)modifypersoninfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"picture"]= FCUserImagePath;
    params[@"sex"]= FCSex;
    params[@"province"]= FCProvice;;
    params[@"city"]= FCCity;
    params[@"zone"]= FCZone;
    params[@"addr"]=  FCUserAddr;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:REModifyPersonInfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
//            FCdicuserinfo = [[dic objectForKey:@"data"] objectForKey:@"userinfo"];
//
//            tableview.delegate = self;
//            tableview.dataSource = self;
//            [self viewheader];
//            [tableview reloadData];
            
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}

-(void)uploadcustompic:(UIImage *)image
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSMutableArray *arrayimage = [[NSMutableArray alloc] init];
    [arrayimage addObject:image];
    
    
    [RequestInterface doGetJsonWithArraypic:arrayimage Parameter:params App:app RequestCode:RQUploadCustomPicCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCUserImagePath = [[[dic objectForKey:@"data"] objectForKey:@"pictureinfo"] objectForKey:@"picturesavenames"];
            [self modifypersoninfo];
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
