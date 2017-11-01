//
//  JXOrderListViewController.m
//  TeBian
//
//  Created by xyy520 on 15/12/14.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import "JXOrderListViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
#import "JXOrderSearchViewController.h"
#import "PellTableViewSelect.h"
#import "JXProductDetailViewController.h"
#import "JXFaHuoDetailViewController.h"
#import "JXOrderProductDetailViewController.h"
@interface JXOrderListViewController ()

@end

@implementation JXOrderListViewController

-(void)returnback:(id)sender
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	JQIndicatorView *indicator = [app.window viewWithTag:IndicatorTag];
	[indicator stopAnimating];
	[self.navigationController popViewControllerAnimated:YES];
}

//订单列表
-(void) requestJXOrderlist:(NSString *)code Page:(NSString *)page Pagesize:(NSString *)pagesize Sdate:(NSString *)sdate Edate:(NSString *)edate Ostatusid:(NSString *)ostatusid
{

	NSDictionary *parameters = @{@"OrderCode":code,@"Page": page,@"PageSize":pagesize,@"StartDate":sdate,@"EndDate":edate,@"OrderStatusId":ostatusid};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA07020000" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 arraydata = [responseObject objectForKey:@"OrderList"];
		 self.tableview.delegate = self;
		 self.tableview.dataSource = self;
		 [self.tableview reloadData];
         [self.tableview.mj_header endRefreshing];
         [self.tableview.mj_footer endRefreshing];
	 }];
	
}

//订单状态
-(void) requestJXOrderstatus
{
	
	NSDictionary *parameters = nil;//@{@"ReadStatusId":statusid,@"Page": page,@"PageSize":pagesize};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA07010100" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 arrayatt = [responseObject objectForKey:@"OrderStatusList"];
		 [self clickstatus:arrayatt];
	 }];
}



-(void)headerview:(id)sender
{
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 85)];
	viewheader.backgroundColor = [UIColor whiteColor];
	
	UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 55, 20)];
	label1.textColor = COLORNOW(72, 72, 72);
	label1.text = @"签订日期";
	label1.font = FONTN(13.0f);
	[viewheader addSubview:label1];
	
	UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(label1.frame.origin.x+label1.frame.size.width+3, 5, 70, 30)];
	textfield.layer.cornerRadius = 2;
	textfield.backgroundColor = [UIColor whiteColor];
	textfield.layer.borderWidth =1.0;
	textfield.tag = 621;
	textfield.textAlignment = NSTextAlignmentCenter;
	textfield.delegate = self;
	textfield.placeholder = @"开始日期";
	textfield.font = FONTN(12.0f);
	textfield.layer.borderColor = COLORNOW(220, 220, 220).CGColor;
	[viewheader addSubview:textfield];
	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(textfield.frame.origin.x+textfield.frame.size.width+5, textfield.frame.origin.y+15, 10, 1)];
	imageviewline.backgroundColor = COLORNOW(200, 200, 200);
	[viewheader addSubview:imageviewline];
	
	UITextField *textfield1 = [[UITextField alloc] initWithFrame:CGRectMake(textfield.frame.origin.x+textfield.frame.size.width+20, 5, 70, 30)];
	textfield1.layer.cornerRadius = 2;
	textfield1.backgroundColor = [UIColor whiteColor];
	textfield1.layer.borderWidth =1.0;
	textfield1.tag = 622;
	textfield1.textAlignment = NSTextAlignmentCenter;
	textfield1.delegate = self;
	textfield1.placeholder = @"结束日期";
	textfield1.font = FONTN(12.0f);
	textfield1.layer.borderColor = COLORNOW(220, 220, 220).CGColor;
	[viewheader addSubview:textfield1];

	
	UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 55, 20)];
	label2.textColor = COLORNOW(72, 72, 72);
	label2.text = @"订单状态";
	label2.font = FONTN(13.0f);
	[viewheader addSubview:label2];
	
	UITextField *textfield3 = [[UITextField alloc] initWithFrame:CGRectMake(textfield.frame.origin.x, 45, 160, 30)];
	textfield3.layer.cornerRadius = 2;
	textfield3.backgroundColor = [UIColor whiteColor];
	textfield3.layer.borderWidth =1.0;
	textfield3.tag = 623;
	textfield3.textAlignment = NSTextAlignmentCenter;
	textfield3.delegate = self;
	textfield3.placeholder = @"选择订单状态";
	textfield3.font = FONTN(12.0f);
	textfield3.layer.borderColor = COLORNOW(220, 220, 220).CGColor;
	[viewheader addSubview:textfield3];
	
	UIButton *buttonorder = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonorder.frame = CGRectMake(textfield3.frame.origin.x+textfield3.frame.size.width+10,textfield3.frame.origin.y,SCREEN_WIDTH-(textfield3.frame.origin.x+textfield3.frame.size.width)-20, 30);
	buttonorder.titleLabel.font = FONTN(13.0f);
	buttonorder.layer.cornerRadius = 3.0f;
	buttonorder.clipsToBounds = YES;
	buttonorder.backgroundColor = COLORNOW(23, 69, 146);
	[buttonorder setTitleColor:COLORNOW(240, 240, 240) forState:UIControlStateNormal];
	[buttonorder addTarget:self action:@selector(gotoshaixuan:) forControlEvents:UIControlEventTouchUpInside];
	[buttonorder setTitle:@"筛选" forState:UIControlStateNormal];
	[viewheader addSubview:buttonorder];
	
	self.tableview.tableHeaderView = viewheader;
}

-(void)clickstatus:(NSArray *)arraystatus
{
	UITextField *textfield = (UITextField *)[self.tableview.tableHeaderView viewWithTag:623];
	NSMutableArray *menuItems = [[NSMutableArray alloc] init];
	for(int i=0;i<[arraystatus count];i++)
	{
		NSDictionary *dictemp = [arraystatus objectAtIndex:i];
		[menuItems addObject:[dictemp objectForKey:@"Name"]];
	}

	[PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(textfield.frame.origin.x, textfield.frame.origin.y+textfield.frame.size.height+70, textfield.frame.size.width, 100) selectData:menuItems action:^(NSInteger index)
	 {
		 textfield.text = [menuItems objectAtIndex:index];

		 for(int i=0;i<[arraystatus count];i++)
		 {
			 NSDictionary *dictemp = [arraystatus objectAtIndex:i];
			 if([[dictemp objectForKey:@"Name"] isEqualToString:textfield.text])
			 {
				 strstatusid = [dictemp objectForKey:@"Id"];
				 break;
			 }
		 }
	 }
	animated:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if(textField.tag == 621)
	{
		selectmodel = 1;
		[self showpickview:nil];
		return NO;
	}
	else if(textField.tag == 622)
	{
		selectmodel = 2;
		[self showpickview:nil];
		return NO;
	}
	else if(textField.tag == 623)
	{
		[self requestJXOrderstatus];
		return NO;
	}
	return YES;
}

-(void)gotoshaixuan:(id)sender
{
	UITextField *textfield1 = [self.tableview.tableHeaderView viewWithTag:621];
	UITextField *textfield2 = [self.tableview.tableHeaderView viewWithTag:622];
	if([textfield1.text length]==0 || [textfield2.text length]==0)
	{
        [MBProgressHUD showError:@"日期选择不能为空" toView:self.view];


	}
	else if ([textfield1.text compare:textfield2.text] == NSOrderedDescending)
	{
        [MBProgressHUD showError:@"开始日期不能早于结束日期" toView:self.view];

	}
	else
	{
		strstartdate = [textfield1.text length]>0?textfield1.text:@"";
		strenddate = [textfield2.text length]>0?textfield2.text:@"";
		[self requestJXOrderlist:strcode Page:@"1" Pagesize:@"10" Sdate:strstartdate Edate:strenddate Ostatusid:strstatusid];
	}
}

-(void)gotosearch:(id)sender
{
    JXOrderSearchViewController *searchlist = [[JXOrderSearchViewController alloc] init];
	searchlist.delegate1 = self;
	[self.navigationController pushViewController:searchlist animated:YES];
}

-(void)clicksearchcode:(NSString *)sender
{
	strcode = sender;
	[self requestJXOrderlist:strcode Page:@"1" Pagesize:@"10" Sdate:strstartdate Edate:strenddate Ostatusid:strstatusid];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"订单";
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	[button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
	
	button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
	[button addTarget:self action: @selector(returnback:) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	
	UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
	UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
	[buttonright setImage:LOADIMAGE(@"jxsearchicon", @"png") forState:UIControlStateNormal];
	buttonright.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
	[buttonright addTarget:self action: @selector(gotosearch:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewright addSubview:buttonright];
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
	
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-40)];
    self.tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableview];
    [self setExtraCellLineHidden:self.tableview];
    
	[self headerview:nil];
	
    __weak __typeof(self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestJXOrderlist:strcode Page:@"1" Pagesize:@"10" Sdate:strstartdate Edate:strenddate Ostatusid:strstatusid];
    }];
    
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestJXOrderlist:strcode Page:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10] Sdate:strstartdate Edate:strenddate Ostatusid:strstatusid];
    }];
	
	result = @" ";
	result1 = @" ";
	result2 = @" ";
	strstatusid = @"";
	strcode = @"";
	strstartdate = @"";
	strenddate = @"";
	content1 = [[NSMutableArray alloc] init];
	content2 = [[NSMutableArray alloc] init];
	content3 = [[NSMutableArray alloc] init];
	maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];;
	maskView.backgroundColor = [UIColor blackColor];
	maskView.alpha = 0;
	maskView.tag = 801;
	[maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
	selectmodel = 0;
    // Do any additional setup after loading the view.
}

#pragma mark tableviewdelegate
//隐藏那些没有cell的线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
-(void)viewDidLayoutSubviews
{
	if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
		[self.tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
	}
	
	if ([self.tableview respondsToSelector:@selector(setLayoutMargins:)]) {
		[self.tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
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
	return 170;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	return [arraydata count];
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
	
	cell.backgroundColor = [UIColor clearColor];
	
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 160)];
	imageview.backgroundColor = COLORNOW(252, 252, 252);
	imageview.layer.cornerRadius = 2.0f;
	imageview.clipsToBounds = YES;
	imageview.layer.shadowColor = COLORNOW(42, 42, 42).CGColor;
	imageview.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
	imageview.layer.shadowOpacity = 1.0;//不透明度
	imageview.layer.shadowRadius = 5.0;//半径
	[cell.contentView addSubview:imageview];
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+10, 15, 155, 20)];
	labeltitle.font = FONTN(12.0f);
	labeltitle.text = [dictemp objectForKey:@"Id"];
	labeltitle.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labeltitle];
	
	UILabel *labeljobtitle = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+10, 33, 205, 20)];
	labeljobtitle.font = FONTN(12.0f);
	labeljobtitle.text = [dictemp objectForKey:@"CustomerName"];
	labeljobtitle.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labeljobtitle];
	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x, labeljobtitle.frame.origin.y+labeljobtitle.frame.size.height+5, imageview.frame.size.width, 0.5)];
	imageviewline.backgroundColor = COLORNOW(211, 211, 211);
	[cell.contentView addSubview:imageviewline];
	
	UILabel *labelsign = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x,imageviewline.frame.origin.y+10, 50, 15)];
	labelsign.font = FONTN(12.0f);
	labelsign.text =@"签定日期";
	labelsign.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelsign];
	
	UILabel *labelsignvalue = [[UILabel alloc] initWithFrame:CGRectMake(85,labelsign.frame.origin.y, 100, 15)];
	labelsignvalue.font = FONTN(12.0f);
	labelsignvalue.text =[dictemp objectForKey:@"OrderDate"];
	labelsignvalue.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelsignvalue];
	
	UILabel *labelreview = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-145,labelsign.frame.origin.y, 60, 15)];
	labelreview.font = FONTN(12.0f);
	labelreview.text =@"评审交货期";
	labelreview.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelreview];
	
	UILabel *labelreviewvalue = [[UILabel alloc] initWithFrame:CGRectMake(labelreview.frame.origin.x+labelreview.frame.size.width+5,labelreview.frame.origin.y, 100, 15)];
	labelreviewvalue.font = FONTN(12.0f);
	labelreviewvalue.text =[dictemp objectForKey:@"AllDeliveryDate"];
	labelreviewvalue.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelreviewvalue];
	
	//
	UILabel *labelordertotal = [[UILabel alloc] initWithFrame:CGRectMake(labelsign.frame.origin.x,labelsign.frame.origin.y+labelsign.frame.size.height+10, 60, 15)];
	labelordertotal.font = FONTN(12.0f);
	labelordertotal.text =@"订单总金额";
	labelordertotal.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelordertotal];
	
	UILabel *labelordertotalvalue = [[UILabel alloc] initWithFrame:CGRectMake(85,labelordertotal.frame.origin.y, 100, 15)];
	labelordertotalvalue.font = FONTN(12.0f);
	labelordertotalvalue.text =[NSString stringWithFormat:@"￥%@",[dictemp objectForKey:@"OrderMoney"]];
	labelordertotalvalue.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelordertotalvalue];
	
	UILabel *labelshop = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-145,labelordertotal.frame.origin.y, 60, 15)];
	labelshop.font = FONTN(12.0f);
	labelshop.text =@"发货总金额";
	labelshop.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelshop];
	
	UILabel *labelshopvalue = [[UILabel alloc] initWithFrame:CGRectMake(labelshop.frame.origin.x+labelshop.frame.size.width+5,labelshop.frame.origin.y, 100, 15)];
	labelshopvalue.font = FONTN(12.0f);
	labelshopvalue.text =[NSString stringWithFormat:@"￥%@",[dictemp objectForKey:@"DeliveryMoney"]];
	labelshopvalue.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelshopvalue];
	
	UIImageView *imageviewline1 = [[UIImageView alloc] initWithFrame:CGRectMake(imageviewline.frame.origin.x, imageviewline.frame.origin.y+imageviewline.frame.size.height+60, imageviewline.frame.size.width, 0.5)];
	imageviewline1.backgroundColor = COLORNOW(211, 211, 211);
	[cell.contentView addSubview:imageviewline1];
	
	UIButton *buttondetail1 = [UIButton buttonWithType:UIButtonTypeCustom];
	buttondetail1.frame = CGRectMake(imageview.frame.origin.x+10,imageviewline1.frame.origin.y+10,(SCREEN_WIDTH-20-20-20)/2, 30);
	buttondetail1.titleLabel.font = FONTN(13.0f);
	buttondetail1.layer.borderColor = COLORNOW(151, 151, 151).CGColor;
	buttondetail1.layer.borderWidth = 1.0f;
	buttondetail1.layer.cornerRadius = 3.0f;
	buttondetail1.clipsToBounds = YES;
	buttondetail1.tag = 800+indexPath.row;
	[buttondetail1 setTitleColor:COLORNOW(151, 151, 151) forState:UIControlStateNormal];
	[buttondetail1 addTarget:self action:@selector(gotodetail1:) forControlEvents:UIControlEventTouchUpInside];
	[buttondetail1 setTitle:@"发运明细" forState:UIControlStateNormal];
	[cell.contentView addSubview:buttondetail1];
	
	UIButton *buttondetail2 = [UIButton buttonWithType:UIButtonTypeCustom];
	buttondetail2.frame = CGRectMake(buttondetail1.frame.origin.x+buttondetail1.frame.size.width+10,buttondetail1.frame.origin.y,(SCREEN_WIDTH-20-20)/2, 30);
	buttondetail2.titleLabel.font = FONTN(13.0f);
	buttondetail2.layer.cornerRadius = 3.0f;
	buttondetail2.clipsToBounds = YES;
	buttondetail2.tag = 900+indexPath.row;
	buttondetail2.backgroundColor = COLORNOW(23, 69, 146);
	[buttondetail2 setTitleColor:COLORNOW(240, 240, 240) forState:UIControlStateNormal];
	[buttondetail2 addTarget:self action:@selector(gotodetail2:) forControlEvents:UIControlEventTouchUpInside];
	[buttondetail2 setTitle:@"订货产品明细" forState:UIControlStateNormal];
	[cell.contentView addSubview:buttondetail2];
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *dicmessage = [arraydata objectAtIndex:indexPath.row];
//	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//	JXProductDetailViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"JXProductDetailViewController"];
//	detail.strorderid = [dicmessage objectForKey:@"Id"];
//	[self.navigationController pushViewController:detail animated:YES];
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    JXOrderProductDetailViewController *detail = [[JXOrderProductDetailViewController alloc] init];
	detail.strorderid = [dicmessage objectForKey:@"Id"];
	[self.navigationController pushViewController:detail animated:YES];
	
}

//发运明细
-(void)gotodetail1:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]- 800;
	NSDictionary *dicmessage = [arraydata objectAtIndex:tagnow];
    JXFaHuoDetailViewController *detail = [[JXFaHuoDetailViewController alloc] init];
	detail.strorderid = [dicmessage objectForKey:@"Id"];
	[self.navigationController pushViewController:detail animated:YES];
}

-(void)gotodetail2:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]- 900;
	NSDictionary *dicmessage = [arraydata objectAtIndex:tagnow];
    JXOrderProductDetailViewController *detail = [[JXOrderProductDetailViewController alloc] init];
	detail.strorderid = [dicmessage objectForKey:@"Id"];
	[self.navigationController pushViewController:detail animated:YES];
	
}

#pragma mark - 滚轮选择

-(void)gotofuxing:(id)sender
{
	[self showpickview:nil];
}



-(UIView *)initviewsheet:(CGRect)frameview
{
	UIView *viewsheet = [[UIView alloc] initWithFrame:frameview];
	viewsheet.backgroundColor = [UIColor whiteColor];
	
	UIPickerView *picview = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 216)];
	picview.delegate = self;
	picview.tag = 201;
	[viewsheet addSubview:picview];
	
	UIButton *buttoncancel = [UIButton buttonWithType:UIButtonTypeCustom];
	buttoncancel.frame = CGRectMake(0, 0, 80, 40);
	buttoncancel.titleLabel.font = FONTMEDIUM(15.0f);
	[buttoncancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[buttoncancel addTarget:self action:@selector(cancelbt:) forControlEvents:UIControlEventTouchUpInside];
	[buttoncancel setTitle:@"取消" forState:UIControlStateNormal];
	[viewsheet addSubview:buttoncancel];
	
	UIButton *buttondone = [UIButton buttonWithType:UIButtonTypeCustom];
	buttondone.frame = CGRectMake(SCREEN_WIDTH-80, 0, 80, 40);
	buttondone.titleLabel.font = FONTMEDIUM(15.0f);
	[buttondone addTarget:self action:@selector(ensurebt:) forControlEvents:UIControlEventTouchUpInside];
	[buttondone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[buttondone setTitle:@"确定" forState:UIControlStateNormal];
	[viewsheet addSubview:buttondone];
	
	return viewsheet;
}

- (void)showpickview:(NSArray *)sender
{
	[content1 removeAllObjects];
	[content2 removeAllObjects];
	[content3 removeAllObjects];
	content1 = [NSMutableArray arrayWithObjects:@"2014",@"2015",@"2016",@"2017",@"2018",@"2019",@"2020",nil];
	content2 = [NSMutableArray arrayWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",nil];
	content3 = [NSMutableArray arrayWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",nil];
	
	result  = [content1 objectAtIndex:0];
	result1 = [content2 objectAtIndex:0];
	result2 = [content3 objectAtIndex:0];
	
	[[self.view viewWithTag:800] removeFromSuperview];
	[maskView removeFromSuperview];
	
	[self.view addSubview:maskView];
	maskView.alpha = 0;
	UIView *viewsheet = [self initviewsheet:CGRectMake(0, SCREEN_HEIGHT-255, SCREEN_WIDTH, 255)];
	viewsheet.tag = 800;
	[self.view addSubview:viewsheet];
	
	NSString *strmonth = [AddInterface returnnowdatefromstr:@"M"];
	NSString *strday = [AddInterface returnnowdatefromstr:@"dd"];
	UIPickerView *picview = (UIPickerView *)[viewsheet viewWithTag:201];
	[picview selectRow:2 inComponent:0 animated:YES];
	[picview selectRow:[strmonth intValue]-1 inComponent:1 animated:YES];
	[picview selectRow:[strday intValue]-1 inComponent:2 animated:YES];
	
	result  = @"2016";
	result1 = strmonth;
	result2 = strday;
	
	[UIView animateWithDuration:0.3 animations:^{
		maskView.alpha = 0.3;
		viewsheet.frame = CGRectMake(viewsheet.frame.origin.x, SCREEN_HEIGHT-viewsheet.frame.size.height, viewsheet.frame.size.width, viewsheet.frame.size.height);
	}];
	
}

- (void)hideMyPicker {
	UIView *viewsheet = (UIView *)[self.view viewWithTag:800];
	[UIView animateWithDuration:0.3 animations:^{
		viewsheet.frame = CGRectMake(viewsheet.frame.origin.x,SCREEN_HEIGHT, viewsheet.frame.size.width, viewsheet.frame.size.height);
		maskView.alpha = 0;
	} completion:^(BOOL finished) {
		[viewsheet removeFromSuperview];
		[maskView removeFromSuperview];
	}];
}



- (void)cancelbt:(id)sender {
	[self hideMyPicker];
}

- (void)ensurebt:(id)sender {
	
	[self hideMyPicker];
	
	UITextField *textfield;
	if(selectmodel == 1)
		textfield = (UITextField *)[self.tableview.tableHeaderView viewWithTag:621];
	else if(selectmodel == 2)
		textfield = (UITextField *)[self.tableview.tableHeaderView viewWithTag:622];
	
	textfield.text = [[[[result stringByAppendingString:@"-"] stringByAppendingString:result1] stringByAppendingString:@"-"] stringByAppendingString:result2];
}



- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated{
	return ;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
	return 3;
}

// 返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	
	if(component == 0)
		return [content1 count];
	else if(component == 1)
		return [content2 count];
	else if(component == 2)
		return [content3 count];
	return 0;
}

// 设置当前行的内容，若果行没有显示则自动释放
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	
	if(component == 0)
		return [content1 objectAtIndex:row];
	else if(component == 1)
		return [content2 objectAtIndex:row];
	else if(component == 2)
		return [content3 objectAtIndex:row];
	return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	//NSString *result = [pickerView pickerView:pickerView titleForRow:row forComponent:component];
	
	if(component == 0)
		result = [content1 objectAtIndex:row];
	else if(component == 1)
		result1 = [content2 objectAtIndex:row];
	else if(component == 2)
		result2 = [content3 objectAtIndex:row];
	
	NSLog(@"result:%@,%@,%@",result,result1,result2);
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