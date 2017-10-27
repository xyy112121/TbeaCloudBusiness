//
//  SettingNewAddressViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/19.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "SettingNewAddressViewController.h"

@interface SettingNewAddressViewController ()

@end

@implementation SettingNewAddressViewController



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

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = COLORNOW(240, 240, 240);
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
	
	UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
	UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
	buttonright.titleLabel.font = FONTN(14.0f);
	[buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[buttonright setTitle:@"保存" forState:UIControlStateNormal];
	buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
	[buttonright addTarget:self action: @selector(saveaddr:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewright addSubview:buttonright];
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
}

-(void)initview
{
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"收货地址管理";
	isselect = EnNotSelect;
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	
	
	
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
	tableview.delegate = self;
	tableview.dataSource = self;
}

#pragma mark tableview delegate
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
	return 5;
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
	
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 70, 20)];
	labeltitle.textColor = ColorBlackdeep;
	labeltitle.font = FONTN(14.0f);
	[cell.contentView addSubview:labeltitle];
	
	
	UITextField *textfield1 = [[UITextField alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x+labeltitle.frame.size.width+10, 7, 200, 26)];
	textfield1.layer.cornerRadius = 2.0f;
	textfield1.clipsToBounds = YES;
	textfield1.delegate = self;
	textfield1.backgroundColor = [UIColor clearColor];
	textfield1.font = FONTN(14.0f);
	
	UIButton *buttonselect = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonselect.frame = CGRectMake(SCREEN_WIDTH-50, 0, 40, 40);
	buttonselect.backgroundColor = [UIColor clearColor];
	[buttonselect setImage:LOADIMAGE(@"me默认收货地址", @"png") forState:UIControlStateNormal];
	[buttonselect addTarget:self action:@selector(clickdefaultaddr:) forControlEvents:UIControlEventTouchUpInside];
	
	switch (indexPath.row)
	{
		case 0:
			labeltitle.text = @"收货人";
			textfield1.textColor = [UIColor blackColor];
			textfield1.placeholder = @"请输入收货人姓名";
			textfield1.tag = EnAddAddressTextfieldTag1;
			[cell.contentView addSubview:textfield1];
			break;
		case 1:
			labeltitle.text = @"手机号码";
			textfield1.textColor = [UIColor blackColor];
			textfield1.placeholder = @"请输入收货人手机号码";
			textfield1.tag = EnAddAddressTextfieldTag2;
			[cell.contentView addSubview:textfield1];
			break;
		case 2:
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			labeltitle.text = @"所在地区";
			textfield1.textColor = [UIColor blackColor];
			textfield1.tag = EnAddAddressTextfieldTag3;
			[cell.contentView addSubview:textfield1];
			break;
		case 3:
			labeltitle.text = @"详细地址";
			textfield1.textColor = [UIColor blackColor];
			textfield1.placeholder = @"点击设置详细地址";
			textfield1.tag = EnAddAddressTextfieldTag4;
			[cell.contentView addSubview:textfield1];
			break;
		case 4:
			labeltitle.text = @"默认地址";
			textfield1.textColor = COLORNOW(117, 117, 117);
			textfield1.placeholder = @"每次下单时会使用该地址";
			[cell.contentView addSubview:textfield1];
			textfield1.enabled = NO;
			[buttonselect setImage:LOADIMAGE(@"menotselectgray", @"png") forState:UIControlStateNormal];
			[cell.contentView addSubview:buttonselect];
			break;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

#pragma mark actiondelegate


#pragma mark UItextfieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if(textField.tag ==EnAddAddressTextfieldTag3)
	{
		[self clickselectcity];
		return NO;
	}
	
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

#pragma mark IBAction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)clickdefaultaddr:(id)sender
{
	UIButton *button = (UIButton *)sender;
	if(isselect==EnNotSelect)
	{
		isselect = EnSelectd;
		[button setImage:LOADIMAGE(@"me默认收货地址", @"png") forState:UIControlStateNormal];
		
	}
	else
	{
		isselect = EnNotSelect;
		[button setImage:LOADIMAGE(@"menotselectgray", @"png") forState:UIControlStateNormal];
	}
}

//地址选择
- (void)clickselectcity{
	FDCityPicker *city = [[FDCityPicker alloc] initWithDelegate:self];
	[city show];
}
- (void)pickerAreaer:(FDCityPicker *)pickerAreaer province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
	NSString *text = [NSString stringWithFormat:@"%@ %@ %@",province,city,area];
    FCprovice = province;
    FCcity = city;
    FCarea = area;
	UITextField *textfield = [tableview viewWithTag:EnAddAddressTextfieldTag3];
	textfield.text = text;
}

-(void)returnkeytextfield
{
	UITextField *textfield1 = [self.view viewWithTag:EnAddAddressTextfieldTag1];
	UITextField *textfield2 = [self.view viewWithTag:EnAddAddressTextfieldTag2];
	UITextField *textfield3 = [self.view viewWithTag:EnAddAddressTextfieldTag3];
	UITextField *textfield4 = [self.view viewWithTag:EnAddAddressTextfieldTag4];
	[textfield1 resignFirstResponder];
	[textfield2 resignFirstResponder];
	[textfield3 resignFirstResponder];
	[textfield4 resignFirstResponder];

}

-(void)saveaddr:(id)sender
{
	[self returnkeytextfield];
    UITextField *textfield1 = [self.view viewWithTag:EnAddAddressTextfieldTag1];
    UITextField *textfield2 = [self.view viewWithTag:EnAddAddressTextfieldTag2];
    UITextField *textfield3 = [self.view viewWithTag:EnAddAddressTextfieldTag3];
    UITextField *textfield4 = [self.view viewWithTag:EnAddAddressTextfieldTag4];
	if([textfield1.text length]==0||[textfield2.text length]==0||[textfield3.text length]==0||[textfield4.text length]==0)
	{
		[MBProgressHUD showError:@"请填写完整的地址信息" toView:app.window];
	}
	else if(![AddInterface isValidateMobile:textfield2.text])
	{
		[MBProgressHUD showError:@"请填写正确的电话号码" toView:app.window];
	}
	else
	{
        FCname = textfield1.text;
        FCtel = textfield2.text;
        FCaddress = textfield4.text;
        if(isselect==EnNotSelect)
        {
            FCisdefault = @"0";
        }
        else
        {
            FCisdefault = @"1";
        }
        [self addnewsaddress];
	}
}



//-(void)gotosave:(id)sender
//{
//	[self returnback];
////	ModifyPwdDoneViewController *modifydone = [[ModifyPwdDoneViewController alloc] init];
////	[self.navigationController pushViewController:modifydone animated:YES];
//}


#pragma mark 接口
-(void)addnewsaddress
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"recvaddrid"] = self.FCaddressid;
    params[@"contactperson"] = FCname;
    params[@"contactmobile"] = FCtel;;
    params[@"province"] = FCprovice;
    params[@"city"] = FCcity;
    params[@"zone"] = FCarea;
    params[@"address"] = FCaddress;
    params[@"isdefault"] = FCisdefault;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQUserCenterReceiveNewAddressCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
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
