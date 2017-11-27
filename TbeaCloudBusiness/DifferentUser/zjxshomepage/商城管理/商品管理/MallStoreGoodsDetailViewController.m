//
//  MallStoreGoodsDetailViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/30.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MallStoreGoodsDetailViewController.h"

@interface MallStoreGoodsDetailViewController ()

@end

@implementation MallStoreGoodsDetailViewController

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
    
    UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
    [buttonright setTitle:@"保存" forState:UIControlStateNormal];
    buttonright.titleLabel.font = FONTN(15.0f);
    [buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonright addTarget:self action: @selector(Clicksave:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright addSubview:buttonright];
    buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    self.navigationItem.rightBarButtonItem = barButtonItemright;
    
    [self initview];
    // Do any additional setup after loading the view.
}

#pragma mark 页面布局
-(void)initview
{
    self.title = @"商品详细";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    [self getcategorylist];
    
    [self tabviewfootdelete];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [self getgoodsdetail];
    
}

-(void)tabviewfootdelete
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *buttonlogout = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonlogout.frame = CGRectMake(20, 100, SCREEN_WIDTH-40, 40);
    buttonlogout.backgroundColor = COLORNOW(238, 89, 83);
    [buttonlogout setTitle:@"删除" forState:UIControlStateNormal];
    buttonlogout.layer.cornerRadius = 3.0f;
    buttonlogout.clipsToBounds = YES;
    [buttonlogout addTarget:self action:@selector(deletegoods:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:buttonlogout];
    
    tableview.tableFooterView = view;
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

#pragma mark 键盘控制
-(void)keyboardWillShow:(NSNotification *)notification
{
    //这样就拿到了键盘的位置大小信息frame，然后根据frame进行高度处理之类的信息
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = frame.size.height;
    CGFloat height =CGRectGetHeight(self.view.frame)- keyboardHeight;
    
    /* 使用动画效果，过度更加平滑 */
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    {
        CGRect rect =
        tableview.frame;
        rect.size.height = height;
        tableview.frame = rect;
    }
    [UIView commitAnimations];
}

-(void)keyboardWillHidden:(NSNotification *)notification
{
    //    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    tableview.frame = CGRectMake(XYViewL(tableview), XYViewTop(tableview), XYViewWidth(tableview), SCREEN_HEIGHT-64);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    {
        CGRect rect = tableview.frame;
        rect.size.height = CGRectGetHeight(self.view.frame);
        tableview.frame = rect;
    }
    [UIView commitAnimations];
}

-(void)keyboardHide:(id)sender
{
    UITextField *textfield1 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield1];
    UITextField *textfield2 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield2];
    UITextField *textfield3 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield3];
    UITextField *textfield4 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield4];
    UITextField *textfield5 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield5];
    UITextField *textfield6 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield6];
    UITextField *textfield7 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield7];
    UITextField *textfield8 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield8];
    FCName = textfield1.text;
    FCPrice = textfield4.text;
    FCDiscountMoney = textfield5.text;
    FCUnit = textfield6.text;
    FCStockNumber = textfield7.text;
    FCDescription = FCtextviewdes.text;
    [textfield1 resignFirstResponder];
    [textfield2 resignFirstResponder];
    [textfield3 resignFirstResponder];
    [textfield4 resignFirstResponder];
    [textfield5 resignFirstResponder];
    [textfield6 resignFirstResponder];
    [textfield7 resignFirstResponder];
    [textfield8 resignFirstResponder];
    [FCtextviewdes resignFirstResponder];
}

#pragma mark UITextfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == EnMallStoreAddNewGoodsTextfield2)
    {
        [self clickgoodscategry];
        return NO;
    }
    else if(textField.tag == EnMallStoreAddNewGoodsTextfield3)
    {
        [self clickgoodsspecial];
        return NO;
    }
    return YES;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UITextField *textfield1 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield1];
    //    UITextField *textfield2 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield2];
    //    UITextField *textfield3 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield3];
    UITextField *textfield4 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield4];
    UITextField *textfield5 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield5];
    UITextField *textfield6 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield6];
    UITextField *textfield7 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield7];
    //    UITextField *textfield8 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield8];
    
    FCName = [textfield1.text length]>0?textfield1.text:FCName;
    FCPrice = [textfield4.text length]>0?textfield4.text:FCPrice;
    FCDiscountMoney = [textfield5.text length]>0?textfield5.text:FCUnit;
    FCUnit = [textfield6.text length]>0?textfield6.text:FCUnit;
    FCStockNumber = [textfield7.text length]>0?textfield7.text:FCStockNumber;
    FCDescription = [FCtextviewdes.text length]>0?FCtextviewdes.text:FCDescription;
    DLog(@"FCName===%@,%@,%@,%@,%@,%@",FCName,FCPrice,FCDiscountMoney,FCUnit,FCStockNumber,FCDescription);
}

#pragma mark 弹窗求
-(void)clickgoodscategry  // 选择商品分类
{
    NSMutableArray *arraytemp = [[NSMutableArray alloc] init];
    for(int i=0;i<[FCarraycategory count];i++)
    {
        NSDictionary *dictemp  = [FCarraycategory objectAtIndex:i];
        [arraytemp addObject:[dictemp objectForKey:@"name"]];
    }
    
    [ZJBLStoreShopTypeAlert showWithTitle:@"商品分类" titles:arraytemp deleGate1:self selectIndex:^(NSInteger selectIndex) {
    } selectValue:^(NSString *selectValue) {
        DLog(@"selectvalue====%@",selectValue);
        UITextField *textfield = [self.view viewWithTag:EnMallStoreAddNewGoodsTextfield2];
        textfield.text = selectValue;
        FCCategoryId = [AddInterface returnselectid:FCarraycategory SelectValue:selectValue];
        FCCategoryName = selectValue;
    } showCloseButton:YES];
}

-(void)clickgoodsspecial  //选择规格型号
{
    ModelSpecificationViewController *modelspecification = [[ModelSpecificationViewController alloc] init];
    modelspecification.delegate1 = self;
    [self.navigationController pushViewController:modelspecification animated:YES];
}

#pragma mark Actiondelegate
-(void)DGProductSpecification:(NSString *)sender Speid:(NSString *)speid Modelid:(NSString *)modelid
{
    FCspecialid = [modelid length]>0?modelid:FCspecialid;
    FCModelId = [speid length]>0?speid:FCModelId;
    FCspecialmodelname = [sender length]>0?sender:FCspecialmodelname;
    UITextField *textfield = [self.view viewWithTag:EnMallStoreAddNewGoodsTextfield3];
    textfield.text = sender;
}

#pragma mark IBaction
-(void)clicksettuijian:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if([FCRecommended isEqualToString:@"0"])
    {
        FCRecommended = @"1";
        [button setImage:LOADIMAGE(@"me默认收货地址", @"png") forState:UIControlStateNormal];
    }
    else
    {
        FCRecommended = @"0";
        [button setImage:LOADIMAGE(@"menotselectgray", @"png") forState:UIControlStateNormal];
    }
}

-(void)Clicksave:(id)sender
{
    UITextField *textfield1 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield1];
    
    UITextField *textfield4 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield4];
    UITextField *textfield5 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield5];
    UITextField *textfield6 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield6];
    UITextField *textfield7 = [tableview viewWithTag:EnMallStoreAddNewGoodsTextfield7];
    FCName = textfield1.text;
    FCPrice = textfield4.text;
    FCDiscountMoney = textfield5.text;
    FCUnit = textfield6.text;
    FCStockNumber = textfield7.text;
    FCDescription = FCtextviewdes.text;
    if(([FCName length]==0)||([FCPrice length]==0)||([FCDiscountMoney length]==0)||([FCUnit length]==0)||([FCDescription length]==0)||([FCCategoryId length]==0)||([FCspecialid length]==0)||([FCModelId length]==0)||([FCThumbList length]==0)||([FCPictureList length]==0))
    {
        [MBProgressHUD showError:@"请填写商品数据 " toView:app.window];
    }
    else
    {
        [self uploadgoodsinfo];
    }
}

-(void)photoTappedAd:(UIGestureRecognizer *)sender
{
    __weak __typeof(self) weakSelf = self;
    
    [JPhotoMagenage JphotoGetFromLibrayInController:self finish:^(NSArray<UIImage *> *images)
     {
         FCarraythumbimage = images;
         int num = [images count]>5?6:(int)[images count];
         for(int i=0;i<num;i++)
         {
             UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0+70*i, 10, 60, 60)];
             imageview.image = [images objectAtIndex:i];
             [FCthumbscrollview addSubview:imageview];
         }
         [FCthumbscrollview setContentSize:CGSizeMake(60*num+10*5, 60)];
         [weakSelf uploadcustompic:images FromFlag:@"1"];
     } cancel:^{
         
     }];
    
}

-(void)photoTappeddetail:(UIGestureRecognizer *)sender
{
    __weak __typeof(self) weakSelf = self;
    
    [JPhotoMagenage JphotoGetFromLibrayInController:self finish:^(NSArray<UIImage *> *images)
     {
         FCarraypictureimage = images;
         int num = [images count]>19?20:(int)[images count];
         for(int i=0;i<num;i++)
         {
             UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0+70*i, 10, 60, 60)];
             imageview.image = [images objectAtIndex:i];
             [FCdetailscrollview addSubview:imageview];
         }
         [FCdetailscrollview setContentSize:CGSizeMake(60*num+10*5, 60)];
         [weakSelf uploadcustompic:images FromFlag:@"2"];
     } cancel:^{
         
     }];
    
}

-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)removekeyboard
{
    UITextField *textfield = [tableview viewWithTag:EnUserMakeUpTextfield5];
    [textfield resignFirstResponder];
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
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.row ==7)
        {
            return 100;
        }
    }
    else if(indexPath.section == 1)
    {
        return 100;
    }
    else if(indexPath.section == 2)
    {
        
        return 40;
    }
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 8;
    else if(section == 1)
        return 2;
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,10)];
    view.backgroundColor = COLORNOW(235,235, 235);
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 0.01;
    return 10;
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
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = [UIColor blackColor];
    labelname.font = FONTN(15.0f);
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, SCREEN_WIDTH-110, 30)];
    textfield.textColor = [UIColor blackColor];
    textfield.backgroundColor = [UIColor clearColor];
    textfield.font = FONTN(15.0f);
    textfield.delegate = self;
    
    
    UIImageView *imageadd;
    UITapGestureRecognizer *singleTap;
    if(indexPath.section == 0)
    {
        switch (indexPath.row)
        {
                
            case 0:
                labelname.text = @"商品名称";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"请输入商品的名称";
                textfield.textColor = COLORNOW(117, 117, 117);
                textfield.tag = EnMallStoreAddNewGoodsTextfield1;
                textfield.text = FCName;
                [cell.contentView addSubview:textfield];
                break;
            case 1:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                labelname.text = @"商品分类";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"请选择商品分类";
                textfield.textColor = COLORNOW(117, 117, 117);
                textfield.tag = EnMallStoreAddNewGoodsTextfield2;
                textfield.text = FCCategoryName;
                [cell.contentView addSubview:textfield];
                break;
            case 2:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                labelname.text = @"规格型号";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"请选择商品规格型号";
                textfield.textColor = COLORNOW(117, 117, 117);
                textfield.tag = EnMallStoreAddNewGoodsTextfield3;
                textfield.text = [NSString stringWithFormat:@"%@ %@",FCModelName,FCspecialname];
                [cell.contentView addSubview:textfield];
                break;
            case 3:
                labelname.text = @"商品价格";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"请输入商品的价格";
                textfield.textColor = COLORNOW(117, 117, 117);
                textfield.tag = EnMallStoreAddNewGoodsTextfield4;
                textfield.text = FCPrice;
                [cell.contentView addSubview:textfield];
                break;
            case 4:
                labelname.text = @"优惠金额";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"请输入下单优惠的金额";
                textfield.textColor = COLORNOW(117, 117, 117);
                textfield.tag = EnMallStoreAddNewGoodsTextfield5;
                textfield.text = FCDiscountMoney;
                [cell.contentView addSubview:textfield];
                break;
            case 5:
                labelname.text = @"商品单位";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"请输入计价单位，如个，件等";
                textfield.textColor = COLORNOW(117, 117, 117);
                textfield.tag = EnMallStoreAddNewGoodsTextfield6;
                textfield.text = FCUnit;
                [cell.contentView addSubview:textfield];
                break;
            case 6:
                labelname.text = @"库存数量";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"不输入为无限制";
                textfield.textColor = COLORNOW(117, 117, 117);
                textfield.tag = EnMallStoreAddNewGoodsTextfield7;
                textfield.text = FCStockNumber;
                [cell.contentView addSubview:textfield];
                break;
                
            case 7:
                labelname.text = @"商品缩略图";
                [cell.contentView addSubview:labelname];
                
                FCthumbscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-110, 80)];
                FCthumbscrollview.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:FCthumbscrollview];
                
                if([FCThumbList length]==0)
                {
                    imageadd = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 60, 60)];
                    imageadd.image = LOADIMAGE(@"useraddpic", @"png");
                    imageadd.userInteractionEnabled = YES;
                    imageadd.tag = EnUserAuthorizaImageview1;
                    singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedAd:)];
                    [imageadd addGestureRecognizer:singleTap];
                    [FCthumbscrollview addSubview:imageadd];
                }
                else
                {
                    NSArray *arraythumb = [FCThumbList componentsSeparatedByString:@","];
                    for(int i=0;i<[arraythumb count];i++)
                    {
                        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0+70*i, 10, 60, 60)];
                        NSString *strpic = [arraythumb objectAtIndex:i];
                        [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"testpic", @"png")];
                        imageview.contentMode = UIViewContentModeScaleAspectFill;
                        imageview.clipsToBounds = YES;

                        [FCthumbscrollview addSubview:imageview];
                    }
                }
                break;
        }
    }
    else if(indexPath.section == 1)
    {
        switch (indexPath.row)
        {
            case 0:
                labelname.text = @"商品描述";
                [cell.contentView addSubview:labelname];
                
                FCtextviewdes = [[VBTextView alloc] initWithFrame:CGRectMake(100, 5, SCREEN_WIDTH-100, 90) placeHolder:@"请输入商品描述或者介绍"];
                FCtextviewdes.delegate = self;
                FCtextviewdes.font = FONTN(15.0f);
                FCtextviewdes.text = FCDescription;
                [cell.contentView addSubview:FCtextviewdes];
                break;
            case 1:
                labelname.text = @"详情图片";
                [cell.contentView addSubview:labelname];
                
                FCdetailscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-110, 80)];
                FCdetailscrollview.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:FCdetailscrollview];
                
                if([FCPictureList length]==0)
                {
                    imageadd = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 60, 60)];
                    imageadd.image = LOADIMAGE(@"useraddpic", @"png");
                    imageadd.userInteractionEnabled = YES;
                    imageadd.tag = EnUserAuthorizaImageview1;
                    singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappeddetail:)];
                    [imageadd addGestureRecognizer:singleTap];
                    [FCdetailscrollview addSubview:imageadd];
                }
                else
                {
                    NSArray *arraythumb = [FCPictureList componentsSeparatedByString:@","];
                    for(int i=0;i<[arraythumb count];i++)
                    {
                        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0+70*i, 10, 60, 60)];
                        NSString *strpic = [arraythumb objectAtIndex:i];
                        [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"testpic", @"png")];
                        imageview.contentMode = UIViewContentModeScaleAspectFill;
                        imageview.clipsToBounds = YES;
                        [FCdetailscrollview addSubview:imageview];
                    }
                }
                break;
                
        }
    }
    else if(indexPath.section == 2)
    {
        labelname.text = @"推荐商品";
        [cell.contentView addSubview:labelname];
        
        textfield.placeholder = @"选中即显示在店铺首页推荐模块";
        textfield.textColor = COLORNOW(117, 117, 117);
        textfield.enabled = NO;
        [cell.contentView addSubview:textfield];
        
        FCtuijianBT = [UIButton buttonWithType:UIButtonTypeCustom];
        FCtuijianBT.frame = CGRectMake(SCREEN_WIDTH-60, 0, 50, 50);
        if([FCRecommended isEqualToString:@"1"])
            [FCtuijianBT setImage:LOADIMAGE(@"me默认收货地址", @"png") forState:UIControlStateNormal];
        else
            [FCtuijianBT setImage:LOADIMAGE(@"menotselectgray", @"png") forState:UIControlStateNormal];
        [FCtuijianBT addTarget:self action:@selector(clicksettuijian:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:FCtuijianBT];
        
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark 接口
//获取商品分类
-(void)getcategorylist
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"parentcategoryid"] = @"";
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQProductCategoryCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraycategory = [[dic objectForKey:@"data"] objectForKey:@"commoditycategorylist"];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}

-(void)uploadcustompic:(NSArray *)arrayimage FromFlag:(NSString *)fromflag
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithArraypic:arrayimage Parameter:params App:app RequestCode:RQUploadCustomPicCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            NSString *strpath = [[[dic objectForKey:@"data"] objectForKey:@"pictureinfo"] objectForKey:@"picturesavenames"];
            if([fromflag isEqualToString:@"1"])
            {
                FCThumbList = strpath;
            }
            else if([fromflag isEqualToString:@"2"])
            {
                FCPictureList = strpath;
            }
            
            
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
        
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
    }];
}

-(void)uploadgoodsinfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"commodityid"] = _FCCommodityId;
    params[@"name"] = FCName;
    params[@"categoryid"] = FCCategoryId;
    params[@"moditymodelid"] = FCModelId;
    params[@"modityspecid"] = FCspecialid;
    params[@"price"] = FCPrice;
    params[@"discountmoney"] = FCDiscountMoney;
    params[@"unit"] = FCUnit;
    params[@"stocknumber"] = FCStockNumber;
    params[@"description"] = FCDescription;
    params[@"thumblist"] = FCThumbList;
    params[@"picturelist"] = FCPictureList;
    params[@"recommended"] = FCRecommended;
    
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

-(void)getgoodsdetail
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"commodityid"] = _FCCommodityId;
    
    DLog(@"params===%@",params);
    
     [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQStoreGoodsDetailInfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            NSDictionary *dictemp = [[dic objectForKey:@"data"] objectForKey:@"commodityinfo"];
            FCName = [dictemp objectForKey:@"name"];
            FCCategoryId = [dictemp objectForKey:@"categoryid"];
            FCCategoryName = [dictemp objectForKey:@"categoryname"];
            FCModelId = [dictemp objectForKey:@"moditymodelid"];
            FCModelName = [dictemp objectForKey:@"moditymodelname"];
            FCspecialid = [dictemp objectForKey:@"modityspecid"];
            FCspecialname = [dictemp objectForKey:@"modityspecname"];
            FCspecialmodelname = [NSString stringWithFormat:@"%@ %@",FCModelName,FCspecialname];
            FCPrice = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"price"]];
            FCDiscountMoney = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"discountmoney"]];
            FCUnit = [dictemp objectForKey:@"unit"];
            FCStockNumber = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"stocknumber"]];
            FCDescription = [dictemp objectForKey:@"description"];
            FCThumbList = [dictemp objectForKey:@"thumblist"];
            FCPictureList = [dictemp objectForKey:@"picturelist"];
            FCRecommended = [dictemp objectForKey:@"recommended"];
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

-(void)deletegoods:(id)sender
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"commodityid"] = _FCCommodityId;
    
    DLog(@"params===%@",params);
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQStoreDeleteGoodsInfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
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
