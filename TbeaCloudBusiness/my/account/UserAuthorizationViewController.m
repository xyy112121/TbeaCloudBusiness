//
//  UserAuthorizationViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/12.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "UserAuthorizationViewController.h"

@interface UserAuthorizationViewController ()

@end

@implementation UserAuthorizationViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initview];
	[self initfootview];
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
-(void)initfootview
{
	UIView *viewfoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
	viewfoot.backgroundColor = [UIColor whiteColor];
	[tableview setTableFooterView:viewfoot];
	
	UIButton *buttonnext = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonnext.frame = CGRectMake(20, 40, SCREEN_WIDTH-40, 40);
	[buttonnext setTitle:@"提交审核" forState:UIControlStateNormal];
	buttonnext.layer.cornerRadius = 3.0f;
	buttonnext.clipsToBounds = YES;
	[buttonnext addTarget:self action:@selector(commitauth:) forControlEvents:UIControlEventTouchUpInside];
	[buttonnext setBackgroundColor:COLORNOW(0, 170, 238)];
	[viewfoot addSubview:buttonnext];
}


-(void)initview
{
	self.title = @"实名认证";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    
    
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
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

#pragma mark UITextfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == EnUserAuthorizaTextfield3)
    {
        AddressSelectInputViewController *addressselect = [[AddressSelectInputViewController alloc] init];
        addressselect.delegate1 = self;
        [self.navigationController pushViewController:addressselect animated:YES];
        return NO;
    }
	return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UITextField *textfield1 = [tableview viewWithTag:EnUserAuthorizaTextfield1];
    UITextField *textfield2 = [tableview viewWithTag:EnUserAuthorizaTextfield2];
 //   UITextField *textfield3 = [tableview viewWithTag:EnUserAuthorizaTextfield3];
    UITextField *textfield4 = [tableview viewWithTag:EnUserAuthorizaTextfield4];
    UITextField *textfield5 = [tableview viewWithTag:EnUserAuthorizaTextfield5];
    UITextField *textfield6 = [tableview viewWithTag:EnUserAuthorizaTextfield6];
    FCcompanyname = textfield1.text;
    FClisencecode = textfield2.text;
    FCbusinesscope = textfield4.text;
    FCmasterperson = textfield5.text;
    FCmasterpersonid = textfield6.text;
    FCstraddress = [NSString stringWithFormat:@"%@%@%@%@",FCprovice?FCprovice:@"",FCcity?FCcity:@"",FCarea?FCarea:@"",FCaddress?FCaddress:@""];
}

#pragma mark ActionDelegate
-(void)DGSelectAreaAddress:(NSString *)pstr City:(NSString *)city Area:(NSString *)area Address:(NSString *)address
{
    FCprovice = pstr;
    FCcity = city;
    FCarea = area;
    FCaddress = address;
    
    
    FCstraddress = [NSString stringWithFormat:@"%@%@%@%@",pstr,city,area,address];
    
    UILabel *labelvalue = [tableview viewWithTag:EnUserAuthorizaTextfield3];
    labelvalue.text = FCstraddress;
}

#pragma mark IBaction

-(void)photoTappedAd:(UIGestureRecognizer *)sender
{
	UIImageView *imageview = (UIImageView *)sender.view;
	int tagnow = (int)imageview.tag;
	
    __weak __typeof(self) weakSelf = self;
	[JPhotoMagenage getOneImageInController:self finish:^(UIImage *images) {
		NSLog(@"%@",images);
		UIImage *image = [AddInterface scaleToSize:images size:CGSizeMake(800, 800)];
		imageview.image = image;
        NSMutableArray *arrayimage = [[NSMutableArray alloc] init];
        [arrayimage addObject:image];
        [weakSelf uploadcustompic:arrayimage FromFlag:tagnow];
        if(tagnow == EnUserAuthorizaImageview1)//营业执照
        {
            FCompanylisenceimage = image;
        }
        else if(tagnow == EnUserAuthorizaImageview2)//个人信息面
        {
            FCpersoncard1image = image;
        }
        else if(tagnow == EnUserAuthorizaImageview3)//国徽面
        {
            FCpersoncard2image = image;
        }
        else if(tagnow == EnUserAuthorizaImageview4)//实景照片1
        {
            FCcompanyphoto1image = image;
        }
        else if(tagnow == EnUserAuthorizaImageview5)//实景照片2
        {
            FCcompanyphoto2image = image;
        }
        
        
	} cancel:^{
		
	}];
	
	
}

-(void)commitauth:(id)sender
{
    UITextField *textfield1 = [tableview viewWithTag:EnUserAuthorizaTextfield1];
    UITextField *textfield2 = [tableview viewWithTag:EnUserAuthorizaTextfield2];
    UITextField *textfield3 = [tableview viewWithTag:EnUserAuthorizaTextfield3];
    UITextField *textfield4 = [tableview viewWithTag:EnUserAuthorizaTextfield4];
    UITextField *textfield5 = [tableview viewWithTag:EnUserAuthorizaTextfield5];
    UITextField *textfield6 = [tableview viewWithTag:EnUserAuthorizaTextfield6];
    FCcompanyname = textfield1.text;
    FClisencecode = textfield2.text;
    FCbusinesscope = textfield4.text;
    FCmasterperson = textfield5.text;
    FCmasterpersonid = textfield6.text;
    if(([FCcompanyname length]==0)||([FClisencecode length]==0)||([FCbusinesscope length]==0)
       ||([FCmasterperson length]==0)||([FCmasterpersonid length]==0)||([FCprovice length]==0)
       ||([FCcompanylisencepicture length]==0)||([FCpersoncard1 length]==0)||([FCpersoncard2 length]==0)||([FCcompanyphoto length]==0))
    {
        
    }
    else
    {
        [self uploadpicpath];
    }
    
    
    
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
		if(indexPath.row ==4)
		{
			return 100;
		}
	}
	else if(indexPath.section == 1)
	{
		if((indexPath.row ==2)||(indexPath.row ==3))
		{
			return 100;
		}
	}
	else if(indexPath.section == 2)
	{
		
		return 100;
	}
	return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(section == 0)
		return 5;
	else if(section == 1)
		return 4;
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if(section == 0)
		return 40.0f;
	return 50;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if(section == 0)
	{
		UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
		viewheader.backgroundColor = [UIColor whiteColor];
		
		UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 0.7)];
		imageline.backgroundColor = COLORNOW(220, 220, 220);
		[viewheader addSubview:imageline];
		
		UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
		labeltitle.backgroundColor = [UIColor clearColor];
		labeltitle.font = FONTMEDIUM(15.0f);
		labeltitle.textColor = [UIColor blackColor];
		[viewheader addSubview:labeltitle];
		labeltitle.text = @"企业信息";
		return viewheader;
	}
	else
	{
		UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
		viewheader.backgroundColor = COLORNOW(235, 235, 235);
		
		UIImageView *imageviewback = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 40)];
		imageviewback.backgroundColor = [UIColor whiteColor];
		[viewheader addSubview:imageviewback];
		
		UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 0.7)];
		imageline.backgroundColor = COLORNOW(220, 220, 220);
		[viewheader addSubview:imageline];
		
		UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 20)];
		labeltitle.backgroundColor = [UIColor clearColor];
		labeltitle.font = FONTMEDIUM(15.0f);
		labeltitle.textColor = [UIColor blackColor];
		[viewheader addSubview:labeltitle];
		if(section == 1)
			labeltitle.text = @"法人信息";
		else if(section == 2)
			labeltitle.text = @"实景信息";
		
		return viewheader;
	}
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
	labelname.textColor = COLORNOW(117, 117, 117);
	labelname.font = FONTN(15.0f);
	
	UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, SCREEN_WIDTH-110, 30)];
	textfield.textColor = [UIColor blackColor];
	textfield.backgroundColor = [UIColor clearColor];
	textfield.font = FONTN(15.0f);
	textfield.delegate = self;
	
	
	UIImageView *imageadd,*imageadd2;
	UITapGestureRecognizer *singleTap;
	if(indexPath.section == 0)
	{
		switch (indexPath.row)
		{
				
			case 0:
				labelname.text = @"名称";
				[cell.contentView addSubview:labelname];
				
				textfield.placeholder = @"请填写营业执照上的企业名称";
				textfield.textColor = COLORNOW(117, 117, 117);
				textfield.tag = EnUserAuthorizaTextfield1;
                textfield.text = FCcompanyname;
				[cell.contentView addSubview:textfield];
				break;
			case 1:
				labelname.text = @"注册号";
				[cell.contentView addSubview:labelname];
				
				textfield.placeholder = @"请填写营业执照上的注册号";
				textfield.textColor = COLORNOW(117, 117, 117);
				textfield.tag = EnUserAuthorizaTextfield2;
                textfield.text = FClisencecode;
				[cell.contentView addSubview:textfield];
				break;
			case 2:
				labelname.text = @"所在地";
				[cell.contentView addSubview:labelname];
				
				textfield.placeholder = @"请填写营业执照上的注册所在详细地址";
				textfield.textColor = COLORNOW(117, 117, 117);
				textfield.tag = EnUserAuthorizaTextfield3;
                textfield.text = FCstraddress;
				[cell.contentView addSubview:textfield];
				break;
			case 3:
				labelname.text = @"经营范围";
				[cell.contentView addSubview:labelname];
				
				textfield.placeholder = @"请填写营业执照上的经营范围";
				textfield.textColor = COLORNOW(117, 117, 117);
				textfield.tag = EnUserAuthorizaTextfield4;
                textfield.text = FCbusinesscope;
				[cell.contentView addSubview:textfield];
				break;
			case 4:
				labelname.text = @"营业执照";
				labelname.frame = CGRectMake(10, 40, XYViewWidth(labelname), 20);
				[cell.contentView addSubview:labelname];
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				
				imageadd = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, 80, 80)];
                imageadd.image = FCompanylisenceimage==nil?LOADIMAGE(@"useraddpic", @"png"):FCompanylisenceimage;
				imageadd.userInteractionEnabled = YES;
				imageadd.tag = EnUserAuthorizaImageview1;
				singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedAd:)];
				[imageadd addGestureRecognizer:singleTap];
				[cell.contentView addSubview:imageadd];
		}
	}
	else if(indexPath.section == 1)
	{
		switch (indexPath.row)
		{
			case 0:
				labelname.text = @"法人姓名";
				[cell.contentView addSubview:labelname];
				
				textfield.placeholder = @"请输入与营业执照一致的姓名";
				textfield.tag = EnUserAuthorizaTextfield5;
				[cell.contentView addSubview:textfield];
				break;
			case 1:
				labelname.text = @"身份证号";
				[cell.contentView addSubview:labelname];
				
				textfield.placeholder = @"请输入与营业执照一致的号码";
				textfield.textColor = COLORNOW(117, 117, 117);
				textfield.tag = EnUserAuthorizaTextfield6;
				[cell.contentView addSubview:textfield];
				break;
			case 2:
				labelname.text = @"个人信息面";
				labelname.frame = CGRectMake(10, 40, XYViewWidth(labelname), 20);
				[cell.contentView addSubview:labelname];
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				
				imageadd = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, 80, 80)];
                imageadd.image = FCpersoncard1image==nil?LOADIMAGE(@"useraddpic", @"png"):FCpersoncard1image;
				imageadd.userInteractionEnabled = YES;
				singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedAd:)];
				[imageadd addGestureRecognizer:singleTap];
				imageadd.tag = EnUserAuthorizaImageview2;
				[cell.contentView addSubview:imageadd];
				break;
			case 3:
				labelname.text = @"国徽面";
				labelname.frame = CGRectMake(10, 40, XYViewWidth(labelname), 20);
				[cell.contentView addSubview:labelname];
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				
				imageadd = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, 80, 80)];
                imageadd.image = FCpersoncard2image==nil?LOADIMAGE(@"useraddpic", @"png"):FCpersoncard2image;
				imageadd.userInteractionEnabled = YES;
				singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedAd:)];
				[imageadd addGestureRecognizer:singleTap];
				imageadd.tag = EnUserAuthorizaImageview3;
				[cell.contentView addSubview:imageadd];
				
				break;
		}
	}
	else if(indexPath.section == 2)
	{
		labelname.text = @"实景照片";
		labelname.frame = CGRectMake(10, 40, XYViewWidth(labelname), 20);
		[cell.contentView addSubview:labelname];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		imageadd = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, 80, 80)];
        imageadd.image = FCcompanyphoto1image==nil?LOADIMAGE(@"useraddpic", @"png"):FCcompanyphoto1image;
		imageadd.userInteractionEnabled = YES;
		singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedAd:)];
		[imageadd addGestureRecognizer:singleTap];
		imageadd.tag = EnUserAuthorizaImageview4;
		[cell.contentView addSubview:imageadd];

		
		imageadd2 = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(imageadd)+10, 10, 80, 80)];
        imageadd2.image = FCcompanyphoto2image==nil?LOADIMAGE(@"useraddpic", @"png"):FCcompanyphoto2image;
		imageadd2.userInteractionEnabled = YES;
		singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedAd:)];
		[imageadd2 addGestureRecognizer:singleTap];
		imageadd2.tag = EnUserAuthorizaImageview5;
		[cell.contentView addSubview:imageadd2];
	}
	
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

#pragma mark 接口
-(void)uploadcustompic:(NSArray *)arrayimage FromFlag:(int)tagnow
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //    params[@"meetingcontent"] = @"测试内容。。。。。。。";
    
//    NSMutableArray *arrayimage = [[NSMutableArray alloc] init];
//    [arrayimage addObject:FCimage];
    
    
    [RequestInterface doGetJsonWithArraypic:arrayimage Parameter:params App:app RequestCode:RQUploadCustomPicCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            NSString *strpath = [[[dic objectForKey:@"data"] objectForKey:@"pictureinfo"] objectForKey:@"picturesavenames"];
            if(tagnow == EnUserAuthorizaImageview1)//营业执照
            {
                FCcompanylisencepicture = strpath;
            }
            else if(tagnow == EnUserAuthorizaImageview2)//个人信息面
            {
                FCpersoncard1 = strpath;
            }
            else if(tagnow == EnUserAuthorizaImageview3)//国徽面
            {
                FCpersoncard2 = strpath;
            }
            else if(tagnow == EnUserAuthorizaImageview4)//实景照片1
            {
                FCcompanyphoto = [FCcompanyphoto length]==0?strpath:[NSString stringWithFormat:@"%@,%@",FCcompanyphoto,strpath];
            }
            else if(tagnow == EnUserAuthorizaImageview5)//实景照片2
            {
                FCcompanyphoto = [FCcompanyphoto length]==0?strpath:[NSString stringWithFormat:@"%@,%@",FCcompanyphoto,strpath];
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

-(void)uploadpicpath
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"companyname"] = FCcompanyname;
    params[@"companylisencecode"] = FClisencecode;
    params[@"province"] = FCprovice;
    params[@"city"] = FCcity;
    params[@"zone"] = FCarea;
    params[@"address"] = FCaddress;
    params[@"businessscope"] = FCbusinesscope;
    params[@"companylisencepicture"] = FCcompanylisencepicture;
    params[@"masterperson"] = FCmasterperson;
    params[@"masterpersonid"] = FCmasterpersonid;
    params[@"masterpersonidcard1"] = FCpersoncard1;
    params[@"picMasterpersonidcard2"] = FCpersoncard2;
    params[@"companyphoto"] = FCcompanyphoto;
    
    DLog(@"params===%@",params);
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQUserInfoAuthorRealNameCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
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
