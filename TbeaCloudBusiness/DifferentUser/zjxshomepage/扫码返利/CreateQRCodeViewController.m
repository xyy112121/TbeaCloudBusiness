//
//  CreateQRCodeViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/23.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "CreateQRCodeViewController.h"

@interface CreateQRCodeViewController ()

@end

@implementation CreateQRCodeViewController

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
	
	UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
	UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
	buttonright.titleLabel.font = FONTN(14.0f);
	[buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[buttonright setTitle:@"历史记录" forState:UIControlStateNormal];
	[buttonright addTarget:self action: @selector(createhistory:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewright addSubview:buttonright];
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
	
	// Do any additional setup after loading the view.
}

#pragma mark 页面布局
-(void)initview
{
	self.title = @"生成返利二维码";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
	
	UIButton *buttondone = [UIButton buttonWithType:UIButtonTypeCustom];
	buttondone.frame = CGRectMake(30, 250, SCREEN_WIDTH-60, 40);
	buttondone.layer.cornerRadius = 3.0f;
	buttondone.backgroundColor = COLORNOW(0, 170, 238);
	buttondone.clipsToBounds = YES;
	[buttondone setTitle:@"确认" forState:UIControlStateNormal];
	[buttondone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	buttondone.titleLabel.font = FONTN(15.0f);
	[buttondone addTarget:self action:@selector(clickdone:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttondone];
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

#pragma mark otherdelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if(textField.tag == EnCreateCodeModelSpeTextfield)
	{
		[textField resignFirstResponder];
		ModelSpecificationViewController *modelspecification = [[ModelSpecificationViewController alloc] init];
		modelspecification.delegate1 = self;
		[self.navigationController pushViewController:modelspecification animated:YES];
		return NO;
	}
    else if(textField.tag == EnCreateCodeNameSpeTextfield)
    {
        [textField resignFirstResponder];
        ScanSelectCommityViewController *nameselect = [[ScanSelectCommityViewController alloc] init];
        nameselect.delegate1 = self;
        [self.navigationController pushViewController:nameselect animated:YES];
        return NO;
        
    }
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

#pragma mark IBaction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)createhistory:(id)sender
{
	HistoryRecordViewController *historyrecord = [[HistoryRecordViewController alloc] init];
	[self.navigationController pushViewController:historyrecord animated:YES];
}

-(void)clickdone:(id)sender
{
	//CreateQrCodeDoneViewController
	UITextField *textfield2 = [self.view viewWithTag:EnCreateCodeMoneyTextfield];
	UITextField *textfield3 = [self.view viewWithTag:EnCreateCodeNumberTextfield];
	UITextField *textfield4 = [self.view viewWithTag:EnCreateCodeModelSpeTextfield];
    UITextField *textfield5 = [self.view viewWithTag:EnCreateCodeNameSpeTextfield];
	if([textfield2.text length]==0)
	{
		[MBProgressHUD showError:@"请填写金额" toView:app.window];
	}
	else if([textfield3.text length]==0)
	{
		[MBProgressHUD showError:@"请填写数量" toView:app.window];
	}
	else if([textfield4.text length]==0)
	{
		[MBProgressHUD showError:@"请选择规格型号" toView:app.window];
	}
    else if([textfield5.text length] == 0)
    {
        [MBProgressHUD showError:@"请选择产品名称" toView:app.window];
    }
    else if(![AddInterface isValidatenumber:textfield2.text])
    {
        [MBProgressHUD showError:@"金额只能填写数字" toView:app.window];
    }
    else if(![AddInterface isValidatenumber:textfield3.text])
    {
        [MBProgressHUD showError:@"数量只能填写数字" toView:app.window];
    }
	else
	{
        [self getcreateqrcode:textfield2.text Number:textfield3.text ModelId:strspecificationid SpeId:strmodelid NameId:FCcommityNameId];
	}
}

#pragma mark Actiondelegate
-(void)DGProductSpecification:(NSString *)sender Speid:(NSString *)speid Modelid:(NSString *)modelid
{
	strspecificationid = modelid;
	strmodelid = speid;
	UITextField *textfield = [self.view viewWithTag:EnCreateCodeModelSpeTextfield];
	textfield.text = sender;
}

-(void)DGProductSelectCommity:(NSDictionary *)sender
{
    FCcommityName = [sender objectForKey:@"name"];
    FCcommityNameId = [sender objectForKey:@"id"];
    UITextField *textfield = [self.view viewWithTag:EnCreateCodeNameSpeTextfield];
    textfield.text = FCcommityName;
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
	
	return 4;
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
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(18, 5, 70, 30)];
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textColor = [UIColor blackColor];
	labelname.text = @"参数设置";
	labelname.font = FONTMEDIUM(16.0f);
	[viewheader addSubview:labelname];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(SCREEN_WIDTH-50, 5, 40, 30);
	button.backgroundColor = [UIColor clearColor];
	[button setTitle:@"预览" forState:UIControlStateNormal];
	button.titleLabel.font = FONTN(15.0f);
	[button setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
//	[viewheader addSubview:button];
	
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
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, 20)];
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textColor = COLORNOW(117, 117, 117);
	

	UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, SCREEN_WIDTH-120, 30)];
	textfield.backgroundColor = [UIColor clearColor];
	textfield.font = FONTN(14.0f);
	textfield.textColor = [UIColor blackColor];
	textfield.delegate = self;
	
	switch (indexPath.row)
	{
		case 0:
			labelname.text = @"金额";
			labelname.font = FONTN(15.0f);
			labelname.textColor = [UIColor blackColor];
			[cell.contentView addSubview:labelname];
			
			textfield.placeholder = @"请输入本次单张返利二维码的金额";
			textfield.tag = EnCreateCodeMoneyTextfield;
			[cell.contentView addSubview:textfield];
			break;
		case 1:
			labelname.text = @"数量";
			labelname.font = FONTN(15.0f);
			labelname.textColor = [UIColor blackColor];
			[cell.contentView addSubview:labelname];
			
			textfield.placeholder = @"请输入本次单张返利二维码的金额";
			textfield.tag = EnCreateCodeNumberTextfield;
			[cell.contentView addSubview:textfield];
			break;
        case 2:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            labelname.text = @"产品名称";
            labelname.font = FONTN(15.0f);
            labelname.textColor = [UIColor blackColor];
            [cell.contentView addSubview:labelname];
            
            textfield.placeholder = @"请选择产品名称";
            textfield.tag = EnCreateCodeNameSpeTextfield;
            [cell.contentView addSubview:textfield];
            break;
		case 3:
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			labelname.text = @"产品规格";
			labelname.font = FONTN(15.0f);
			labelname.textColor = [UIColor blackColor];
			[cell.contentView addSubview:labelname];
			
			textfield.placeholder = @"请选择";
			textfield.tag = EnCreateCodeModelSpeTextfield;
			[cell.contentView addSubview:textfield];
			break;
	}
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark 接口
//生成二维码成功
-(void)getcreateqrcode:(NSString *)money Number:(NSString *)number ModelId:(NSString *)modelid SpeId:(NSString *)speid NameId:(NSString *)nameid
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"money"] = money;
	params[@"number"] = number;
	params[@"commoditymodelid"] = modelid;
	params[@"commodityspecificationid"] = speid;
    params[@"commoditycategoryid"] = nameid;
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQCreateRebateDoneCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			CreateQrCodeDoneViewController *createdone = [[CreateQrCodeDoneViewController alloc] init];
			createdone.FCcreateid = [[[dic objectForKey:@"data"] objectForKey:@"generateinfo"] objectForKey:@"id"];
			[self.navigationController pushViewController:createdone animated:YES];
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
