//
//  OnlineOrderListViewController.m
//  TeBian
//
//  Created by xyy520 on 15/12/21.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import "OnlineOrderListViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
#import "OnlineOrderDetailViewController.h"
@interface OnlineOrderListViewController ()

@end

@implementation OnlineOrderListViewController
-(void)returnback:(id)sender
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	JQIndicatorView *indicator = [app.window viewWithTag:IndicatorTag];
	[indicator stopAnimating];
	[self.navigationController popViewControllerAnimated:YES];
}

//删除订单
-(void) requestDeleteOrder:(NSString *)orderid
{
	
	NSDictionary *parameters = @{@"OrderId":orderid};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA07030200" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 if([[responseObject objectForKey:@"RspCode"] isEqualToString:@"RC00000"])
		 {
			 [self requestJXOrderlist:@"1" Pagesize:@"10"];
		 }
		 [MBProgressHUD showError:[responseObject objectForKey:@"RspDesc"] toView:self.view];

	 }];
	
}

//提交订单
-(void) requestCommitOrder:(NSString *)orderid
{
	
	NSDictionary *parameters = @{@"OrderId":orderid};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA07030300" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 if([[responseObject objectForKey:@"RspCode"] isEqualToString:@"RC00000"])
		 {
			 [self requestJXOrderlist:@"1" Pagesize:@"10"];
		 }
		 [MBProgressHUD showError:[responseObject objectForKey:@"RspDesc"] toView:self.view];

	 }];
	
}


-(void) requestJXOrderlist:(NSString *)page Pagesize:(NSString *)pagesize
{
	
	NSDictionary *parameters = @{@"Page": page,@"PageSize":pagesize};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA07030100" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 arraydata = [responseObject objectForKey:@"PreOrderList"];
		 self.tableview.delegate = self;
		 self.tableview.dataSource = self;
		 [self.tableview reloadData];
         [self.tableview.mj_header endRefreshing];
         [self.tableview.mj_footer endRefreshing];
	 }];
}

-(void)footview:(id)sender
{
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-80, SCREEN_WIDTH, 80)];
	viewheader.backgroundColor = [UIColor whiteColor];

	UIButton *buttoncommit = [UIButton buttonWithType:UIButtonTypeCustom];
	buttoncommit.frame = CGRectMake(20,22, SCREEN_WIDTH-40, 35);
	buttoncommit.tag = 555;
	buttoncommit.titleLabel.font = FONTN(13.0f);
	buttoncommit.layer.cornerRadius = 4.0f;
	buttoncommit.clipsToBounds = YES;
	[buttoncommit setTitle:@"添加新订单" forState:UIControlStateNormal];
	buttoncommit.backgroundColor = COLORNOW(30, 122, 199);
	[buttoncommit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[buttoncommit addTarget:self action:@selector(addneworder:) forControlEvents:UIControlEventTouchUpInside];
	[viewheader addSubview:buttoncommit];
	
	[self.view addSubview:viewheader];
//	self.tableview.tableFooterView = viewheader;
}

-(void)addneworder:(id)sender
{
    OnlineOrderDetailViewController *orderdetail = [[OnlineOrderDetailViewController alloc] init];
	orderdetail.delegate1 = self;
	orderdetail.addproductflag = @"1";
	orderdetail.strorderid = @"";
	[self.navigationController pushViewController:orderdetail animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self requestJXOrderlist:@"1" Pagesize:@"10"];
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
	
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-40)];
    self.tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableview];
    [self setExtraCellLineHidden:self.tableview];
    
    
	
	[self footview:nil];
    
    __weak __typeof(self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
            [weakSelf requestJXOrderlist:@"1" Pagesize:@"10"];
    }];
    
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
            [weakSelf requestJXOrderlist:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10]];
    }];

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
	return 125;
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
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 115)];
	imageview.backgroundColor = COLORNOW(252, 252, 252);
	imageview.layer.cornerRadius = 2.0f;
	imageview.clipsToBounds = YES;
	imageview.layer.shadowColor = COLORNOW(42, 42, 42).CGColor;
	imageview.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
	imageview.layer.shadowOpacity = 1.0;//不透明度
	imageview.layer.shadowRadius = 5.0;//半径
	[cell.contentView addSubview:imageview];
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+5, 15, 105, 20)];
	labeltitle.font = FONTN(12.0f);
	labeltitle.text = [dictemp objectForKey:@"Id"];
	labeltitle.textColor = COLORNOW(51, 51, 51);
	[cell.contentView addSubview:labeltitle];
	
	UILabel *labelID = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-115,15, 110, 20)];
	labelID.font = FONTN(10.0f);
	labelID.text =  [dictemp objectForKey:@"OrderStatus"];
	labelID.textAlignment = NSTextAlignmentRight;
	labelID.textColor = COLORNOW(204, 153, 0);
	[cell.contentView addSubview:labelID];
	
	UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x, labeltitle.frame.origin.y+labeltitle.frame.size.height, 45, 15)];
	labelprice.font = FONTN(10.0f);
	labelprice.text = @"价格总计";
	labelprice.textColor = COLORNOW(72, 72, 72);
	[cell.contentView addSubview:labelprice];
	
	UILabel *labelpricevalue = [[UILabel alloc] initWithFrame:CGRectMake(labelprice.frame.origin.x+labelprice.frame.size.width+5, labelprice.frame.origin.y, 155, 15)];
	labelpricevalue.font = FONTN(10.0f);
	labelpricevalue.text = [NSString stringWithFormat:@"￥%@",[dictemp objectForKey:@"OrderTotleMoney"]];
	labelpricevalue.textColor = COLORNOW(255, 102, 0);
	[cell.contentView addSubview:labelpricevalue];
	
	UILabel *labeldate = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-130, labelprice.frame.origin.y, 125, 15)];
	labeldate.font = FONTN(10.0f);
	labeldate.text = [NSString stringWithFormat:@"登记日期 %@",[dictemp objectForKey:@"OrderDate"]];
	labeldate.textAlignment = NSTextAlignmentRight;
	labeldate.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labeldate];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(labelprice.frame.origin.x, labelprice.frame.origin.y+labelprice.frame.size.height+2, 45, 15)];
	labelname.font = FONTN(10.0f);
	labelname.text = @"客户名称:";
	labelname.textColor = COLORNOW(72, 72, 72);
	[cell.contentView addSubview:labelname];
	
	UILabel *labelnamevalue = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x+labelname.frame.size.width+5, labelname.frame.origin.y, 255, 15)];
	labelnamevalue.font = FONTN(10.0f);
	labelnamevalue.text = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"CustomerName"]];
	labelnamevalue.textColor = COLORNOW(102, 102, 102);
	[cell.contentView addSubview:labelnamevalue];
	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x, 75, imageview.frame.size.width, 0.5)];
	imageviewline.backgroundColor = COLORNOW(211, 211, 211);
	[cell.contentView addSubview:imageviewline];
	
	UIButton *buttondetail = [UIButton buttonWithType:UIButtonTypeCustom];
	buttondetail.frame = CGRectMake(labeltitle.frame.origin.x,imageviewline.frame.origin.y+10, 130, 30);
	buttondetail.tag = 230+3*indexPath.row;
	buttondetail.titleLabel.font = FONTN(13.0f);
	buttondetail.layer.borderColor = COLORNOW(200, 200, 200).CGColor;
	buttondetail.layer.borderWidth = 1;
	buttondetail.layer.cornerRadius = 2.0f;
	buttondetail.clipsToBounds = YES;
	[buttondetail setTitle:@"查看详细" forState:UIControlStateNormal];
	[buttondetail setTitleColor:COLORNOW(51, 51, 51) forState:UIControlStateNormal];
	[buttondetail addTarget:self action:@selector(gotodetail:) forControlEvents:UIControlEventTouchUpInside];
	[cell.contentView addSubview:buttondetail];
	
	UIButton *buttondelete = [UIButton buttonWithType:UIButtonTypeCustom];
	buttondelete.frame = CGRectMake(buttondetail.frame.origin.x+buttondetail.frame.size.width+10,imageviewline.frame.origin.y+10, (imageview.frame.size.width-160)/2, 30);
	buttondelete.tag = 231+3*indexPath.row;
	buttondelete.titleLabel.font = FONTN(13.0f);
	buttondelete.layer.cornerRadius = 2.0f;
	buttondelete.clipsToBounds = YES;
	[buttondelete setTitle:@"删除" forState:UIControlStateNormal];
	buttondelete.backgroundColor = COLORNOW(230, 0, 18);
	[buttondelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[buttondelete addTarget:self action:@selector(gotodelete:) forControlEvents:UIControlEventTouchUpInside];
	[cell.contentView addSubview:buttondelete];
	
	UIButton *buttoncommit = [UIButton buttonWithType:UIButtonTypeCustom];
	buttoncommit.frame = CGRectMake(buttondelete.frame.origin.x+buttondelete.frame.size.width+10,imageviewline.frame.origin.y+10, (imageview.frame.size.width-160)/2, 30);
	buttoncommit.tag = 232+3*indexPath.row;
	buttoncommit.titleLabel.font = FONTN(13.0f);
	buttoncommit.layer.cornerRadius = 2.0f;
	buttoncommit.clipsToBounds = YES;
	[buttoncommit setTitle:@"提交" forState:UIControlStateNormal];
	buttoncommit.backgroundColor = COLORNOW(30, 122, 199);
	[buttoncommit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[buttoncommit addTarget:self action:@selector(gotocommit:) forControlEvents:UIControlEventTouchUpInside];
	[cell.contentView addSubview:buttoncommit];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//	OnlineOrderDetailViewController *orderdetail = [storyboard instantiateViewControllerWithIdentifier:@"OnlineOrderDetailViewController"];
//	[self.navigationController pushViewController:orderdetail animated:YES];
	NSDictionary *dictemp  = [arraydata objectAtIndex:indexPath.row];
    OnlineOrderDetailViewController *orderdetail = [[OnlineOrderDetailViewController alloc] init];
	orderdetail.delegate1 = self;
	orderdetail.addproductflag = @"2";
	orderdetail.strorderid = [dictemp objectForKey:@"Id"];
	[self.navigationController pushViewController:orderdetail animated:YES];
	
}

-(void)gotodetail:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = ((int)[button tag]-230)/3;
	NSDictionary *dictemp  = [arraydata objectAtIndex:tagnow];
    OnlineOrderDetailViewController *orderdetail = [[OnlineOrderDetailViewController alloc] init];
	orderdetail.delegate1 = self;
	orderdetail.addproductflag = @"2";
	orderdetail.strorderid = [dictemp objectForKey:@"Id"];
	[self.navigationController pushViewController:orderdetail animated:YES];
}

-(void)gotodelete:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = ((int)[button tag]-231)/3;
	UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"是否需要删除" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
	alertview.tag = 800+tagnow;
	[alertview show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView.tag <1000)
	{
		if(buttonIndex == 1)
		{
			int tagnow = (int)[alertView tag]-800;
			NSDictionary *dictemp  = [arraydata objectAtIndex:tagnow];
			[self requestDeleteOrder:[dictemp objectForKey:@"Id"]];
		}
	}
	else if(alertView.tag > 2000)
	{
		if(buttonIndex == 2)
		{
			int tagnow = (int)[alertView tag]-2000;
			NSDictionary *dictemp  = [arraydata objectAtIndex:tagnow];
			[self requestCommitOrder:[dictemp objectForKey:@"Id"]];
		}
	}
}

-(void)gotocommit:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = ((int)[button tag]-231)/3;
	UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"是否需要删除" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
	alertview.tag = 2000+tagnow;
	[alertview show];
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
