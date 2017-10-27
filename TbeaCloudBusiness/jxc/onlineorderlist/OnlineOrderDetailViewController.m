//
//  OnlineOrderDetailViewController.m
//  TeBian
//
//  Created by xyy520 on 15/12/22.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import "OnlineOrderDetailViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
#import "AddProductViewController.h"
#import "SearchKeHuViewController.h"
#import "PopoverView.h"
@interface OnlineOrderDetailViewController ()

@end

@implementation OnlineOrderDetailViewController
@synthesize delegate1;
@synthesize addproductflag;

-(void)returnback:(id)sender
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	JQIndicatorView *indicator = [app.window viewWithTag:IndicatorTag];
	[indicator stopAnimating];
	[self.navigationController popViewControllerAnimated:YES];
}

//添加 产品获取刷新列表
-(void) requestonlineorderlist1:(NSString *)orderid Page:(NSString *)page Pagesize:(NSString *)pagesize
{
	
	NSDictionary *parameters = @{@"OrderId":orderid,@"Page": page,@"PageSize":pagesize};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA07030400" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 totalmoney = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"OrderTotleMoney"]];
		 UILabel *labelprice = [self.tableview.tableHeaderView viewWithTag:620];
		 labelprice.text = [NSString stringWithFormat:@"￥%@",totalmoney];

		 arraydata = [responseObject objectForKey:@"PreOrderProductList"];
		 self.tableview.delegate = self;
		 self.tableview.dataSource = self;
		 [self.tableview reloadData];
         [self.tableview.mj_header endRefreshing];
         [self.tableview.mj_footer endRefreshing];
	 }];
	
}


//获取详细
-(void) requestonlineorderlist:(NSString *)orderid Page:(NSString *)page Pagesize:(NSString *)pagesize
{
	
	NSDictionary *parameters = @{@"OrderId":orderid,@"Page": page,@"PageSize":pagesize};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA07030400" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 totalmoney = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"OrderTotleMoney"]];
		 UILabel *labelprice = [self.tableview.tableHeaderView viewWithTag:620];
		 labelprice.text = [NSString stringWithFormat:@"￥%@",totalmoney];
		 dicpreorderinfo = [responseObject objectForKey:@"PreOrderInfo"];
		 UITextField *textfielddate = (UITextField *)[self.view viewWithTag:621];
		 UITextField *textfieldname = (UITextField *)[self.view viewWithTag:622];
		 UITextField *textfieldpricetypename = (UITextField *)[self.view viewWithTag:626];
		 
		 textfielddate.text = [dicpreorderinfo objectForKey:@"DeliverDate"];
		 textfieldname.text = [dicpreorderinfo objectForKey:@"CustomerName"];
		 customid = [dicpreorderinfo objectForKey:@"CustomerId"];
		 textfieldpricetypename.text = [dicpreorderinfo objectForKey:@"PriceTypeName"];
		 pricetypeid = [dicpreorderinfo objectForKey:@"PriceType"];
		 
		 UIButton *button1 = (UIButton *)[self.view viewWithTag:301];
		 UIButton *button2 = (UIButton *)[self.view viewWithTag:302];
		 UIButton *button3 = (UIButton *)[self.navigationController.navigationBar viewWithTag:303];
		 if([[dicpreorderinfo objectForKey:@"CanModify"] isEqualToString:@"NO"])
		 {
			 button1.enabled = NO;
			 button2.enabled = NO;
			 button3.enabled = NO;
			 
			 button1.alpha = 0;
			 button2.alpha = 0;
			 button3.alpha = 0;
		 }
		 
		 arraydata = [responseObject objectForKey:@"PreOrderProductList"];
		 self.tableview.delegate = self;
		 self.tableview.dataSource = self;
		 [self.tableview reloadData];
         [self.tableview.mj_header endRefreshing];
         [self.tableview.mj_footer endRefreshing];
	 }];
}

//删除单个产品
-(void) requestdeleteproduct:(NSString *)orderid
{

	
	NSDictionary *parameters = @{@"Id":orderid};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA07030500" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 if([[responseObject objectForKey:@"RspCode"] isEqualToString:@"RC00000"])
		 {
			 if([self.strorderid length]>0)
				 [self requestonlineorderlist:self.strorderid Page:@"1" Pagesize:@"10"];
		 }
		 
         [MBProgressHUD showError:[responseObject objectForKey:@"RspDesc"] toView:self.view];

	 }];
	
}

-(void)getpricetypelist:(id)sender
{

	
	NSDictionary *parameters = nil;//@{@"Id":orderid};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA07030301" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 [self selectpricetype:[responseObject objectForKey:@"PriceTypeList"]];
	 }];
	
}

//清空商品列表
-(void) requestcleanproduct:(NSString *)orderid
{
	
	NSDictionary *parameters = @{@"OrderId":orderid};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA07030501" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 if([[responseObject objectForKey:@"RspCode"] isEqualToString:@"RC00000"])
		 {
			 if([self.strorderid length]>0)
				 [self requestonlineorderlist:self.strorderid Page:@"1" Pagesize:@"10"];
		 }
		 
         [MBProgressHUD showError:[responseObject objectForKey:@"RspDesc"] toView:self.view];

	 }];
	
}

-(void)requestgenerateorder:(NSString *)delivedate CId:(NSString *)cid Onote:(NSString *)onote Orderid:(NSString *)orderid
{

	
	NSDictionary *parameters = @{@"OrderId":orderid,@"DeliveryDate":delivedate,@"CustomerId": cid,@"OrderNote":onote,@"PriceType":pricetypeid};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA07030000" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 if([[responseObject objectForKey:@"RspCode"] isEqualToString:@"RC00000"])
		 {
			 if([delegate1 respondsToSelector:@selector(addproductsuccess:)])
			 {
				 [delegate1 addproductsuccess:[responseObject objectForKey:@"OrderId"]];
			 }
			 [self returnback:nil];
		 }
		 [MBProgressHUD showError:[responseObject objectForKey:@"RspDesc"] toView:self.view];

         [self.tableview.mj_header endRefreshing];
         [self.tableview.mj_footer endRefreshing];
	 }];
	
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if([[dicpreorderinfo objectForKey:@"CanModify"] isEqualToString:@"NO"])
	{
		return NO;
	}
	if(textField.tag == 621)
	{
		[self showpickview:nil];
		return NO;
	}
	else if(textField.tag == 622)
	{
		[self gotosearchkehu:nil];
		return NO;
	}
	else if(textField.tag == 626)
	{
		[self getpricetypelist:nil];
		return NO;
	}
	return YES;
}

-(void)selectpricetype:(NSArray *)sender
{
	
	NSMutableArray *menuItems = [[NSMutableArray alloc] init];
	for(int i=0;i<[sender count];i++)
	{
		NSDictionary *dictemp = [sender objectAtIndex:i];
		[menuItems addObject:[dictemp objectForKey:@"Name"]];
	}

	
	
	UITextField *textfield = (UITextField *)[self.view viewWithTag:626];
	CGPoint point = CGPointMake(textfield.frame.origin.x + textfield.frame.size.width/2, textfield.frame.origin.y + textfield.frame.size.height+50);
	PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:menuItems images:nil];
	pop.selectRowAtIndex = ^(NSInteger index){
		NSString *selectstr = [menuItems objectAtIndex:index];
		for(int i=0;i<[sender count];i++)
		{
			NSDictionary *dictemp = [sender objectAtIndex:i];
			if([[dictemp objectForKey:@"Name"] isEqualToString:@"selectstr"])
			{
				pricetypeid = [dictemp objectForKey:@"Id"];
			}
		}
		textfield.text = selectstr;
	};
	[pop show];
}

-(void)gotosearchkehu:(id)sender
{
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchKeHuViewController *search = [[SearchKeHuViewController alloc] init];
	search.hidesBottomBarWhenPushed = YES;
	search.delegate1 = self;
	[self.navigationController pushViewController:search animated:YES];
}

-(void)updateselectkehu:(NSDictionary *)kehu
{
	dickehu = kehu;
	UITextField *textfield = (UITextField *)[self.view viewWithTag:622];
	textfield.text = [dickehu objectForKey:@"CustomerName"];
	customid = [dickehu objectForKey:@"CustomerId"];
}

-(void)headerview:(id)sender
{
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 255)];
	viewheader.backgroundColor = [UIColor whiteColor];
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 55, 20)];
	labeltitle.font = FONTN(12.0f);
	labeltitle.text = @"交货日期";
	labeltitle.textColor = COLORNOW(151, 151, 151);
	[viewheader addSubview:labeltitle];
	
	UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x+labeltitle.frame.size.width+5, 15, SCREEN_WIDTH-(labeltitle.frame.origin.x+labeltitle.frame.size.width+5)-10, 30)];
	textfield.layer.cornerRadius = 2;
	textfield.backgroundColor = [UIColor whiteColor];
	textfield.layer.borderWidth =1.0;
	textfield.tag = 621;
	textfield.textAlignment = NSTextAlignmentCenter;
	textfield.delegate = self;
	textfield.placeholder = @"选择交货日期";
	textfield.font = FONTN(12.0f);
	textfield.layer.borderColor = COLORNOW(220, 220, 220).CGColor;
	[viewheader addSubview:textfield];
	
	UIImageView *imageviewrili = [[UIImageView alloc] initWithFrame:CGRectMake(textfield.frame.origin.x+textfield.frame.size.width-18, textfield.frame.origin.y+8, 15, 14)];
	imageviewrili.image = LOADIMAGE(@"riliicon", @"png");
	[viewheader addSubview:imageviewrili];
	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, 0.5)];
	imageviewline.backgroundColor = COLORNOW(211, 211, 211);
	[viewheader addSubview:imageviewline];
	
	//客户
	UILabel *labelcuser = [[UILabel alloc] initWithFrame:CGRectMake(15, imageviewline.frame.origin.y+15, 55, 20)];
	labelcuser.font = FONTN(12.0f);
	labelcuser.text = @"客户";
	labelcuser.textColor = COLORNOW(151, 151, 151);
	[viewheader addSubview:labelcuser];
	
	UITextField *textfieldcuser = [[UITextField alloc] initWithFrame:CGRectMake(labelcuser.frame.origin.x+labelcuser.frame.size.width+5, labelcuser.frame.origin.y-5, SCREEN_WIDTH-(labelcuser.frame.origin.x+labelcuser.frame.size.width+5)-10, 30)];
	textfieldcuser.layer.cornerRadius = 2;
	textfieldcuser.backgroundColor = [UIColor whiteColor];
	textfieldcuser.layer.borderWidth =1.0;
	textfieldcuser.tag = 622;
	textfieldcuser.textAlignment = NSTextAlignmentCenter;
	textfieldcuser.delegate = self;
	textfieldcuser.placeholder = @"填写客户名称";
	textfieldcuser.font = FONTN(12.0f);
	textfieldcuser.layer.borderColor = COLORNOW(220, 220, 220).CGColor;
	[viewheader addSubview:textfieldcuser];
	
//	UIImageView *imageviewsearch = [[UIImageView alloc] initWithFrame:CGRectMake(textfieldcuser.frame.origin.x+textfieldcuser.frame.size.width-18, textfieldcuser.frame.origin.y+8, 15, 14)];
//	imageviewsearch.image = LOADIMAGE(@"Searchblue", @"png");
//	[viewheader addSubview:imageviewsearch];
	
	UIImageView *imageviewline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageviewline.frame.origin.y+50, SCREEN_WIDTH, 0.5)];
	imageviewline1.backgroundColor = COLORNOW(211, 211, 211);
	[viewheader addSubview:imageviewline1];
	
	// 价格类型
	UILabel *labelpricetype = [[UILabel alloc] initWithFrame:CGRectMake(15, imageviewline1.frame.origin.y+15, 55, 20)];
	labelpricetype.font = FONTN(12.0f);
	labelpricetype.text = @"价格类型";
	labelpricetype.textColor = COLORNOW(151, 151, 151);
	[viewheader addSubview:labelpricetype];
	
	UITextField *textfieldpricetype = [[UITextField alloc] initWithFrame:CGRectMake(labelpricetype.frame.origin.x+labelpricetype.frame.size.width+5, labelpricetype.frame.origin.y-5, SCREEN_WIDTH-textfieldcuser.frame.origin.x-10, 30)];
	textfieldpricetype.layer.cornerRadius = 2;
	textfieldpricetype.backgroundColor = COLORNOW(250, 250, 250);
	textfieldpricetype.layer.borderWidth =1.0;
	textfieldpricetype.tag = 626;
	textfieldpricetype.textAlignment = NSTextAlignmentCenter;
	textfieldpricetype.delegate = self;
	textfieldpricetype.placeholder = @"选择价格类型";
	textfieldpricetype.font = FONTN(12.0f);
	textfieldpricetype.layer.borderColor = COLORNOW(220, 220, 220).CGColor;
	[viewheader addSubview:textfieldpricetype];
	
	UIImageView *imageviewline4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageviewline1.frame.origin.y+50, SCREEN_WIDTH, 0.5)];
	imageviewline4.backgroundColor = COLORNOW(211, 211, 211);
	[viewheader addSubview:imageviewline4];
	
	//备注
	UILabel *labelbiezhu = [[UILabel alloc] initWithFrame:CGRectMake(15, imageviewline4.frame.origin.y+15, 55, 20)];
	labelbiezhu.font = FONTN(12.0f);
	labelbiezhu.text = @"备注";
	labelbiezhu.textColor = COLORNOW(151, 151, 151);
	[viewheader addSubview:labelbiezhu];
	
	UITextField *textfieldbank = [[UITextField alloc] initWithFrame:CGRectMake(textfieldcuser.frame.origin.x, labelbiezhu.frame.origin.y-5, SCREEN_WIDTH-textfieldcuser.frame.origin.x-10, 30)];
	textfieldbank.layer.cornerRadius = 2;
	textfieldbank.backgroundColor = COLORNOW(250, 250, 250);
	textfieldbank.layer.borderWidth =1.0;
	textfieldbank.tag = 625;
	textfieldbank.textAlignment = NSTextAlignmentCenter;
	textfieldbank.delegate = self;
	textfieldbank.placeholder = @"填写备注";
	textfieldbank.font = FONTN(12.0f);
	textfieldbank.layer.borderColor = COLORNOW(220, 220, 220).CGColor;
	[viewheader addSubview:textfieldbank];
	
	UIImageView *imageviewline2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageviewline4.frame.origin.y+50, SCREEN_WIDTH, 0.5)];
	imageviewline2.backgroundColor = COLORNOW(211, 211, 211);
	[viewheader addSubview:imageviewline2];
	
	//价格总计
	UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(15, imageviewline2.frame.origin.y+15, 55, 20)];
	labelprice.font = FONTN(12.0f);
	labelprice.text = @"价格总计";
	labelprice.textColor = COLORNOW(151, 151, 151);
	[viewheader addSubview:labelprice];
	
	UILabel *labelpricevalue = [[UILabel alloc] initWithFrame:CGRectMake(labelprice.frame.origin.x+labelprice.frame.size.width, labelprice.frame.origin.y, 75, 20)];
	labelpricevalue.font = FONTN(12.0f);
	labelpricevalue.text = @"";
	labelpricevalue.tag = 620;
	labelpricevalue.textColor = COLORNOW(255, 102, 0);
	[viewheader addSubview:labelpricevalue];
	
	UIButton *buttondelete = [UIButton buttonWithType:UIButtonTypeCustom];
	buttondelete.frame = CGRectMake(SCREEN_WIDTH-180,imageviewline2.frame.origin.y+10, 80, 30);
	buttondelete.tag = 301;
	buttondelete.titleLabel.font = FONTN(13.0f);
	buttondelete.layer.cornerRadius = 2.0f;
	buttondelete.clipsToBounds = YES;
	[buttondelete setTitle:@"清空产品" forState:UIControlStateNormal];
	buttondelete.backgroundColor = COLORNOW(230, 0, 18);
	[buttondelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[buttondelete addTarget:self action:@selector(gotodelete:) forControlEvents:UIControlEventTouchUpInside];
	[viewheader addSubview:buttondelete];
	
	
	UIButton *buttoncommit = [UIButton buttonWithType:UIButtonTypeCustom];
	buttoncommit.frame = CGRectMake(buttondelete.frame.origin.x+buttondelete.frame.size.width+10,buttondelete.frame.origin.y, 80, 30);
	buttoncommit.tag = 302;
	buttoncommit.titleLabel.font = FONTN(13.0f);
	buttoncommit.layer.cornerRadius = 2.0f;
	buttoncommit.clipsToBounds = YES;
	[buttoncommit setTitle:@"添加产品" forState:UIControlStateNormal];
	buttoncommit.backgroundColor = COLORNOW(30, 122, 199);
	[buttoncommit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[buttoncommit addTarget:self action:@selector(addproduct:) forControlEvents:UIControlEventTouchUpInside];
	[viewheader addSubview:buttoncommit];
	
	UIImageView *imageviewline3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageviewline2.frame.origin.y+50, SCREEN_WIDTH, 0.5)];
	imageviewline3.backgroundColor = COLORNOW(211, 211, 211);
	[viewheader addSubview:imageviewline3];
	
	self.tableview.tableHeaderView = viewheader;
}

-(void)gotodelete:(id)sender
{
	[self requestcleanproduct:self.strorderid];
}

-(void)gotodeleteonly:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]-260;
	NSDictionary *dictemp = [arraydata objectAtIndex:tagnow];
	[self requestdeleteproduct:[dictemp objectForKey:@"ProductId"]];
}

-(void)addproductsuccess:(NSString *)strid
{
	self.strorderid = strid;
	[self requestonlineorderlist1:self.strorderid Page:@"1" Pagesize:@"10"];
}

-(void)addproduct:(id)sender
{
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddProductViewController *orderdetail = [[AddProductViewController alloc] init];
	orderdetail.delegate1 = self;
	orderdetail.strorderid = self.strorderid;
	[self.navigationController pushViewController:orderdetail animated:YES];
}

-(void)clickdone:(id)sender
{
	UITextField *textfield1 = (UITextField *)[self.tableview.tableHeaderView viewWithTag:621];
	UITextField *textfield2 = (UITextField *)[self.tableview.tableHeaderView viewWithTag:622];
	UITextField *textfield3 = (UITextField *)[self.tableview.tableHeaderView viewWithTag:625];
	if(([textfield1.text length]==0)||([textfield2.text length]==0))
	{
        [MBProgressHUD showError:@"填写日期和客户名称" toView:self.view];

	}
	else
	{
		[self requestgenerateorder:textfield1.text CId:customid Onote:textfield3.text Orderid:self.strorderid];
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"在线下单";
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
	[buttonright setImage:LOADIMAGE(@"Confirm", @"png") forState:UIControlStateNormal];
	buttonright.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
	buttonright.tag = 303;
	[buttonright addTarget:self action: @selector(clickdone:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewright addSubview:buttonright];
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;

    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-40)];
    self.tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableview];
    [self setExtraCellLineHidden:self.tableview];
    
	customid = @"";
	[self headerview:nil];
	if([self.strorderid length]>0)
	{
        __weak __typeof(self) weakSelf = self;
        self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if([weakSelf.strorderid length]>0)
                [weakSelf requestonlineorderlist:weakSelf.strorderid Page:@"1" Pagesize:@"10"];
        }];
        
        self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            if([weakSelf.strorderid length]>0)
                [weakSelf requestonlineorderlist:weakSelf.strorderid Page:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10]];
        }];
	}
	result = @" ";
	result1 = @" ";
	result2 = @" ";
	pricetypeid = @"";
	content1 = [[NSMutableArray alloc] init];
	content2 = [[NSMutableArray alloc] init];
	content3 = [[NSMutableArray alloc] init];
	maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];;
	maskView.backgroundColor = [UIColor blackColor];
	maskView.alpha = 0;
	maskView.tag = 801;
	[maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
	if([self.strorderid length]>0)
		[self requestonlineorderlist:self.strorderid Page:@"1" Pagesize:@"10"];
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
	return 140;
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
	NSDictionary *dictemp  = [arraydata objectAtIndex:indexPath.row];
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 130)];
	imageview.backgroundColor = COLORNOW(252, 252, 252);
	imageview.layer.cornerRadius = 2.0f;
	imageview.clipsToBounds = YES;
	imageview.layer.shadowColor = COLORNOW(42, 42, 42).CGColor;
	imageview.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
	imageview.layer.shadowOpacity = 1.0;//不透明度
	imageview.layer.shadowRadius = 5.0;//半径
	[cell.contentView addSubview:imageview];
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+5, 15, SCREEN_WIDTH-100, 20)];
	labeltitle.font = FONTN(12.0f);
	labeltitle.text = [dictemp objectForKey:@"ProductName"];
	labeltitle.textColor = COLORNOW(0, 51, 153);
	[cell.contentView addSubview:labeltitle];
	
	if([[dicpreorderinfo objectForKey:@"CanModify"] isEqualToString:@"NO"])
	{
		
	}
	else
	{
		UIButton *buttondelete = [UIButton buttonWithType:UIButtonTypeCustom];
		buttondelete.frame = CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-20,labeltitle.frame.origin.y+3, 15, 15);
		buttondelete.tag = 260+indexPath.row;
		buttondelete.titleLabel.font = FONTN(13.0f);
		buttondelete.layer.cornerRadius = 2.0f;
		buttondelete.clipsToBounds = YES;
		[buttondelete setTitle:@"X" forState:UIControlStateNormal];
		buttondelete.backgroundColor = COLORNOW(230, 0, 18);
		[buttondelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[buttondelete addTarget:self action:@selector(gotodeleteonly:) forControlEvents:UIControlEventTouchUpInside];
		[cell.contentView addSubview:buttondelete];
	}
	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x, 40, imageview.frame.size.width, 0.5)];
	imageviewline.backgroundColor = COLORNOW(211, 211, 211);
	[cell.contentView addSubview:imageviewline];
	
	UILabel *labelID = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+5,imageviewline.frame.origin.y+5, 45, 20)];
	labelID.font = FONTN(10.0f);
	labelID.text =  @"产品编码:";
	labelID.textColor = COLORNOW(152, 152, 152);
	[cell.contentView addSubview:labelID];
	
	UILabel *labelcodevalue = [[UILabel alloc] initWithFrame:CGRectMake(labelID.frame.origin.x+labelID.frame.size.width, labelID.frame.origin.y, 60, 20)];
	labelcodevalue.font = FONTN(10.0f);
	labelcodevalue.text = [dictemp objectForKey:@"ProductCode"];
	labelcodevalue.textColor = COLORNOW(0, 0, 0);
	[cell.contentView addSubview:labelcodevalue];
	
	UILabel *labelguige = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width/3+20, labelcodevalue.frame.origin.y, 30, 20)];
	labelguige.font = FONTN(10.0f);
	labelguige.text = @"规格:";
	labelguige.textColor = COLORNOW(152, 152, 152);
	[cell.contentView addSubview:labelguige];
	
	UILabel *labelguigevalue = [[UILabel alloc] initWithFrame:CGRectMake(labelguige.frame.origin.x+labelguige.frame.size.width, labelguige.frame.origin.y, 95, 20)];
	labelguigevalue.font = FONTN(10.0f);
	labelguigevalue.text = [dictemp objectForKey:@"Specification"];
	labelguigevalue.textColor = COLORNOW(0, 0, 0);
	[cell.contentView addSubview:labelguigevalue];
	
	UILabel *labelunit = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-80, labelguigevalue.frame.origin.y, 45, 20)];
	labelunit.font = FONTN(10.0f);
	labelunit.text =  [NSString stringWithFormat:@"单位:%@",[dictemp objectForKey:@"UnitofMeasurement"]];
	labelunit.textColor = COLORNOW(152, 152, 152);
	[cell.contentView addSubview:labelunit];
	
	UIImageView *imageviewline1 = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x, imageviewline.frame.origin.y+30, imageview.frame.size.width, 0.5)];
	imageviewline1.backgroundColor = COLORNOW(211, 211, 211);
	[cell.contentView addSubview:imageviewline1];
	
	UILabel *labelnum = [[UILabel alloc] initWithFrame:CGRectMake(labelID.frame.origin.x,imageviewline1.frame.origin.y+5, 30, 20)];
	labelnum.font = FONTN(10.0f);
	labelnum.text =  @"数量:";
	labelnum.textColor = COLORNOW(152, 152, 152);
	[cell.contentView addSubview:labelnum];
	
	UILabel *labelnumvalue = [[UILabel alloc] initWithFrame:CGRectMake(labelnum.frame.origin.x+labelnum.frame.size.width+5, labelnum.frame.origin.y, 30, 20)];
	labelnumvalue.font = FONTN(10.0f);
	labelnumvalue.text =[NSString stringWithFormat:@"%@",[dictemp objectForKey:@"Count"]];
	labelnumvalue.textColor = COLORNOW(0, 0, 0);
	[cell.contentView addSubview:labelnumvalue];
	
	UILabel *labeldrift = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width/3+20,labelnum.frame.origin.y, 50, 20)];
	labeldrift.font = FONTN(10.0f);
	labeldrift.text =  @"浮动比例:";
	labeldrift.textColor = COLORNOW(152, 152, 152);
	[cell.contentView addSubview:labeldrift];
	
	UILabel *labeldriftvalue = [[UILabel alloc] initWithFrame:CGRectMake(labeldrift.frame.origin.x+labeldrift.frame.size.width+5, labeldrift.frame.origin.y, 40, 20)];
	labeldriftvalue.font = FONTN(10.0f);
	labeldriftvalue.text = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"FloatRatio"]];
	labeldriftvalue.textColor = COLORNOW(0, 0, 0);
	[cell.contentView addSubview:labeldriftvalue];

	
	UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-80,labelnum.frame.origin.y, 30, 20)];
	labelprice.font = FONTN(10.0f);
	labelprice.text =  @"单价:";
	labelprice.textColor = COLORNOW(152, 152, 152);
	[cell.contentView addSubview:labelprice];
	
	UILabel *labelpricevalue = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-60, labelnum.frame.origin.y, 55, 20)];
	labelpricevalue.font = FONTN(10.0f);
	labelpricevalue.text = [NSString stringWithFormat:@"￥%@",[dictemp objectForKey:@"Price"]];
	labelpricevalue.textColor = COLORNOW(255, 153, 0);
	[cell.contentView addSubview:labelpricevalue];
	
	UIImageView *imageviewline2 = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x, imageviewline1.frame.origin.y+30, imageview.frame.size.width, 0.5)];
	imageviewline2.backgroundColor = COLORNOW(211, 211, 211);
	[cell.contentView addSubview:imageviewline2];
	
	UILabel *labelremark = [[UILabel alloc] initWithFrame:CGRectMake(labelID.frame.origin.x,imageviewline2.frame.origin.y+5, 30, 20)];
	labelremark.font = FONTN(10.0f);
	labelremark.text =  @"备注:";
	labelremark.textColor = COLORNOW(152, 152, 152);
	[cell.contentView addSubview:labelremark];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
	
	UITextField *textfield = (UITextField *)[self.tableview.tableHeaderView viewWithTag:621];
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
