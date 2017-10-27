//
//  MyPageModifyPhoneViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/19.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyPageModifyPhoneViewController.h"

@interface MyPageModifyPhoneViewController ()

@end

@implementation MyPageModifyPhoneViewController

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
	
	// Do any additional setup after loading the view.
}

#pragma mark 页面布局
-(void)initview
{
	getyanzhengcodeflag = 0;
	self.title = @"验证原来手机号";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	
	[self setExtraCellLineHidden:tableview];
	
	[self initfootview];
}

-(void)initfootview
{
	UIView *viewfoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
	viewfoot.backgroundColor = [UIColor clearColor];
	
	UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.7)];
	imageline.backgroundColor =COLORNOW(220, 220, 220);
	[viewfoot addSubview:imageline];
	
	UIButton *btnext = [UIButton buttonWithType:UIButtonTypeCustom];
	btnext.frame = CGRectMake(20, 30, SCREEN_WIDTH-40, 35);
	btnext.backgroundColor = COLORNOW(0, 170, 238);
	[btnext setTitle:@"下一步" forState:UIControlStateNormal];
	[btnext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	btnext.titleLabel.font = FONTN(15.0f);
	[btnext addTarget:self action:@selector(gotonext:) forControlEvents:UIControlEventTouchUpInside];
	btnext.layer.cornerRadius= 3.0f;
	btnext.clipsToBounds = YES;
	[viewfoot addSubview:btnext];
	
	tableview.tableFooterView = viewfoot;
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

#pragma mark IBAction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)gotonext:(id)sender
{
	MyPageModifyPhoneNewViewController *newphone = [[MyPageModifyPhoneNewViewController alloc] init];
	[self.navigationController pushViewController:newphone animated:YES];
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
	return 2;
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
	
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 55, 20)];
	labeltitle.textColor = ColorBlackdeep;
	labeltitle.font = FONTN(14.0f);
	[cell.contentView addSubview:labeltitle];
	
	
	UITextField *textfield1 = [[UITextField alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x+labeltitle.frame.size.width+10, 7, 120, 26)];
	textfield1.layer.cornerRadius = 2.0f;
	textfield1.clipsToBounds = YES;
	textfield1.delegate = self;
	UIView *leftview1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
	textfield1.leftView = leftview1;
	textfield1.leftViewMode = UITextFieldViewModeAlways;
	textfield1.backgroundColor = [UIColor clearColor];
	textfield1.font = FONTN(14.0f);
	
	UIButton *buttonyanzhengcode = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonyanzhengcode.titleLabel.font = FONTN(13.0f);
	[buttonyanzhengcode setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
	[buttonyanzhengcode setTitle:@"发送" forState:UIControlStateNormal];
	buttonyanzhengcode.tag = EnModifyBindingOldGetCodeBtTag;
	[buttonyanzhengcode addTarget:self action:@selector(getphonecode:) forControlEvents:UIControlEventTouchUpInside];
	buttonyanzhengcode.frame = CGRectMake(SCREEN_WIDTH-100, 5, 90, 30);
	[buttonyanzhengcode setBackgroundColor:[UIColor clearColor]];
	
	
	switch (indexPath.row)
	{
		case 0:
			labeltitle.text = @"手机号";
			textfield1.text =@"13899999999";
			textfield1.textColor = ColorBlackGray;
			textfield1.enabled = NO;
			textfield1.tag = EnModifyBindingOldTelTextfieldTag;
			[cell.contentView addSubview:textfield1];
			
			break;
		case 1:
			labeltitle.text = @"验证码";
			textfield1.textColor = ColorBlackdeep;
			textfield1.enabled = YES;
			textfield1.tag = EnModifyBindingOldCodeTextfieldTag;
			textfield1.placeholder = @"填写验证码";
			[cell.contentView addSubview:textfield1];
			[cell.contentView addSubview:buttonyanzhengcode];
			break;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch (indexPath.row)
	{
			
	}
}

#pragma mark IBAction
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

-(void)returnkeytextfield
{
	UITextField *textfield = (UITextField *)[self.view viewWithTag:EnModifyBindingOldTelTextfieldTag];
	UITextField *textfield1 = (UITextField *)[self.view viewWithTag:EnModifyBindingOldCodeTextfieldTag];
	[textfield resignFirstResponder];
	[textfield1 resignFirstResponder];
}

-(void)getphonecode:(id)sender
{
	if(getyanzhengcodeflag == 0)
	{
		UITextField *textfield1 = [self.view viewWithTag:EnModifyBindingOldTelTextfieldTag];
		
		
		if([[textfield1 text] length]==0)
		{
			[MBProgressHUD showError:@"请填写电话" toView:self.view];
		}
		else if(![AddInterface isValidateMobile:textfield1.text])
		{
			[MBProgressHUD showError:@"请填写正确格式的电话号码" toView:self.view];
		}
		else
		{
			[self returnkeytextfield];
			getyanzhengcodeflag = 1;
//			[self clickgetcode];
			timerone= [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updasecond:) userInfo:nil repeats:YES];
		}
	}
	
}

-(void)updasecond:(id)sender
{
	UIButton *button = (UIButton *)[self.view viewWithTag:EnModifyBindingOldGetCodeBtTag];
	NSString *strtemp = [button currentTitle];
	if([strtemp length]== 5)
	{
		[button setTitle:@"重新获取(60)" forState:UIControlStateNormal];
	}
	else
	{
		NSString *strsecond = [strtemp substringFromIndex:5];
		strsecond = [strsecond substringToIndex:[strsecond length]-1];
		int second = [strsecond intValue];
		[button setTitle:[NSString stringWithFormat:@"重新获取(%d)",second-1] forState:UIControlStateNormal];
		if(second > 1)
		{
			
			button.enabled = NO;
		}
		else
		{
			getyanzhengcodeflag = 0;
			[button setTitle:@"发送" forState:UIControlStateNormal];
			button.enabled = YES;
			[timerone invalidate];
			timerone = nil;
		}
	}
}

#pragma mark 接口
-(void)getmysettinginfo:(NSString *)telold
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobilenumber"] =telold;
    params[@"servicecode"] =telold;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQGetAuthCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            
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
