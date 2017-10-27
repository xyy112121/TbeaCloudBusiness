//
//  JXGuidePriceViewController.m
//  TeBian
//
//  Created by xyy520 on 15/12/16.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import "JXGuidePriceViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
#import "YTextField.h"
@interface JXGuidePriceViewController ()

@end

@implementation JXGuidePriceViewController

-(void)returnback:(id)sender
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	JQIndicatorView *indicator = [app.window viewWithTag:IndicatorTag];
	[indicator stopAnimating];
	[self.navigationController popViewControllerAnimated:YES];
}


-(void) requestJXguidepricelist:(NSString *)comname Page:(NSString *)page Pagesize:(NSString *)pagesize
{

	
	NSDictionary *parameters = @{@"CommodityName":comname,@"Page": page,@"PageSize":pagesize};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA09020000" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 arraydata = [responseObject objectForKey:@"ReferencePriceList"];
		 self.tableview.delegate = self;
		 self.tableview.dataSource = self;
		 [self.tableview reloadData];
         [self.tableview.mj_header endRefreshing];
         [self.tableview.mj_footer endRefreshing];
	 }];
	
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
	[textField resignFirstResponder];
	strsearchname = @"";
	[self requestJXguidepricelist:strsearchname Page:@"1" Pagesize:@"10"];
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	strsearchname = textField.text;
	[self requestJXguidepricelist:strsearchname Page:@"1" Pagesize:@"10"];
	return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	UITextField *textfield = (UITextField *)[self.tableview.tableHeaderView viewWithTag:101];
	[textfield resignFirstResponder];
}

-(void)headerview:(id)sender
{
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
	viewheader.backgroundColor = [UIColor whiteColor];
	
	UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(3, 11, 13, 13)];
	img.image = LOADIMAGE(@"zoomicon", @"png");
	YTextField *textfieldusername = [[YTextField alloc] initWithFrame:CGRectMake(30, 8, SCREEN_WIDTH-60, 35) Icon:img];
	textfieldusername.leftView = img;
	textfieldusername.placeholder = @"产品名称";
	textfieldusername.font = FONTLIGHT(14.0f);
	textfieldusername.tag = 101;
	textfieldusername.returnKeyType = UIReturnKeySearch;
	textfieldusername.delegate = self;
	textfieldusername.backgroundColor = [UIColor clearColor];
	textfieldusername.clearButtonMode = UITextFieldViewModeAlways;
	textfieldusername.leftViewMode = UITextFieldViewModeAlways;
	textfieldusername.borderStyle = UITextBorderStyleLine;
	textfieldusername.textAlignment = NSTextAlignmentLeft;//  = UIControlContentVerticalAlignmentCenter;
	textfieldusername.layer.borderColor = COLORNOW(220, 220, 220).CGColor;
	textfieldusername.layer.borderWidth = 1.0f;
	[viewheader addSubview:textfieldusername];
	
	self.tableview.tableHeaderView = viewheader;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"指导价查询";
	
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
    
	[self headerview:nil];
	strsearchname = @"";
	[self requestJXguidepricelist:strsearchname Page:@"1" Pagesize:@"10"];

    __weak __typeof(self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestJXguidepricelist:strsearchname Page:@"1" Pagesize:@"10"];
    }];
    
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestJXguidepricelist:strsearchname Page:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10]];
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
	return 70;
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
	NSDictionary *dicmtep = [arraydata objectAtIndex:indexPath.row];
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 60)];
	imageview.backgroundColor = COLORNOW(252, 252, 252);
	imageview.layer.cornerRadius = 2.0f;
	imageview.clipsToBounds = YES;
	imageview.layer.shadowColor = COLORNOW(42, 42, 42).CGColor;
	imageview.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
	imageview.layer.shadowOpacity = 1.0;//不透明度
	imageview.layer.shadowRadius = 5.0;//半径
	[cell.contentView addSubview:imageview];
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+5, 15, 55, 20)];
	labeltitle.font = FONTN(12.0f);
	labeltitle.text = @"产品名称:";
	labeltitle.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labeltitle];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x+labeltitle.frame.size.width+5, 15, 260, 20)];
	labelname.font = FONTN(12.0f);
	labelname.text = [dicmtep objectForKey:@"CommodityName"];
	labelname.textColor = COLORNOW(51, 51, 51);
	[cell.contentView addSubview:labelname];
	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x, 40, imageview.frame.size.width, 0.5)];
	imageviewline.backgroundColor = COLORNOW(211, 211, 211);
	[cell.contentView addSubview:imageviewline];
	
	UILabel *labelunit = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x,imageviewline.frame.origin.y+5, 120, 20)];
	labelunit.font = FONTN(12.0f);
	labelunit.text = [NSString stringWithFormat:@"单位:%@",[dicmtep objectForKey:@"UnitofMeasurement"]];
	labelunit.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelunit];
	
	NSString *strprice = [NSString stringWithFormat:@"￥%@",[dicmtep objectForKey:@"ReferencePrice"]];
	NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0f],NSFontAttributeName, nil];
	CGSize size = [strprice boundingRectWithSize:CGSizeMake(200, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
	
	UILabel *labelstocknum = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-size.width-5,imageviewline.frame.origin.y+5, size.width, 20)];
	labelstocknum.font = FONTN(12.0f);
	labelstocknum.text = strprice;
	labelstocknum.textAlignment = NSTextAlignmentRight;
	labelstocknum.textColor = COLORNOW(255, 102, 0);
	[cell.contentView addSubview:labelstocknum];
	
	UILabel *labelstock = [[UILabel alloc] initWithFrame:CGRectMake(labelstocknum.frame.origin.x-45,imageviewline.frame.origin.y+5, 40, 20)];
	labelstock.font = FONTN(12.0f);
	labelstock.text = @"指导价:";
	labelstock.textAlignment = NSTextAlignmentRight;
	labelstock.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelstock];
	

	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//	NSDictionary *dicmessage = [self.arraymessage objectAtIndex:indexPath.row];
	//	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	//	MessageDetailViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"MessageDetailViewController"];
	//	detail.hidesBottomBarWhenPushed = YES;
	//	detail.strmessgeid = [dicmessage objectForKey:@"Id"];
	//	[self.navigationController pushViewController:detail animated:YES];
	
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
