//
//  TbeaPageViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/18.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "TbeaPageViewController.h"

@interface TbeaPageViewController ()

@end

@implementation TbeaPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	[self initview];
    // Do any additional setup after loading the view.
}

-(void)initview
{
    self.view.backgroundColor = [UIColor whiteColor];//COLORNOW(235, 235, 235);
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
    
    if (@available(iOS 11.0, *)) {
        tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
    }
    
    [self gethppage];
}

-(void)viewheader
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 255)];
	
	FocusNewsView *focusnews = [[FocusNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 255) Focus:FCarrayfocus];
	focusnews.delegate1 = self;
	[view addSubview:focusnews];
	
	//四个按钮
	tableview.tableHeaderView = view;
}

-(void)viewWillAppear:(BOOL)animated
{
	[[self.navigationController.navigationBar viewWithTag:EnNctlSearchViewTag] removeFromSuperview];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
//	self.navigationController.navigationBar.translucent = NO;
//	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
//	[self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];

//	self.navigationController.navigationBar.translucent = NO;
//	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
//	[self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
}



#pragma mark ActionDelegate
-(void)DGFocusClickNumberPic:(id)sender
{
	
}

-(void)DGClickTbeaHpProduct:(NSDictionary *)sender
{
	TbeaProductDetailViewController *productdetail = [[TbeaProductDetailViewController alloc] init];
    productdetail.hidesBottomBarWhenPushed = YES;
    productdetail.FCdicproduct = sender;
	[self.navigationController pushViewController:productdetail animated:YES];
}

-(void)DGClickTopFunction:(int)sender
{
	TbeaCompanyIntroductionViewController *tbeacompanyintroduce;
	TbeaNewsListViewController *newslist;
	TbeaProductInstroduceViewController *tbeaproduct;
	TbeaContactViewController *contactviw;
	switch (sender)
	{
		case 0:
			tbeacompanyintroduce = [[TbeaCompanyIntroductionViewController alloc] init];
			tbeacompanyintroduce.hidesBottomBarWhenPushed = YES;
			[self.navigationController pushViewController:tbeacompanyintroduce animated:YES];
			break;
		case 1:
			newslist = [[TbeaNewsListViewController alloc] init];
			newslist.hidesBottomBarWhenPushed = YES;
			[self.navigationController pushViewController:newslist animated:YES];
			break;
		case 2:
			tbeaproduct = [[TbeaProductInstroduceViewController alloc] init];
			tbeaproduct.hidesBottomBarWhenPushed = YES;
			[self.navigationController pushViewController:tbeaproduct animated:YES];
			break;
		case 3:
			contactviw = [[TbeaContactViewController alloc] init];
			contactviw.hidesBottomBarWhenPushed = YES;
			[self.navigationController pushViewController:contactviw animated:YES];
			break;

	}
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
    if([FCarraymessage count]>0)
        return 2;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([FCarraymessage count]>0)
    {
        if(indexPath.section == 0)
            return 60;
        return (SCREEN_WIDTH-40-20)/2+70;
    }
    return (SCREEN_WIDTH-40-20)/2+70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([FCarraymessage count]>0)
    {
        if(section == 0)
            return 1;
        return ([FCarrayproduct count]+1)/2;
    }
    return ([FCarrayproduct count]+1)/2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if(section == 0)
		return 0.001;
	return 40;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if(section == 0)
		return nil;
	else if(section == 1)
	{
		UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
		viewheader.backgroundColor = [UIColor whiteColor];
		
		UILabel *labtitle = [[UILabel alloc] initWithFrame:CGRectMake(20,10, 100, 20)];
		labtitle.text = @"最新产品";
		labtitle.font = FONTMEDIUM(15.0f);
		labtitle.textColor = [UIColor blackColor];
		[viewheader addSubview:labtitle];
		
		UIImageView *imageright = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-27, 16, 7, 12)];
		imageright.image = LOADIMAGE(@"tbeaarrowright", @"png");
		[viewheader addSubview:imageright];

		UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 0.7)];
		imageline.backgroundColor = COLORNOW(210, 210, 210);
		[viewheader addSubview:imageline];
		
		return viewheader;
	}
	return nil;
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
    if([FCarraymessage count]>0)
    {
        if(indexPath.section == 0)
        {
            TbeaHpCellView *hpcell = [[TbeaHpCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60) ArrayFrom:FCarraymessage];
            [cell.contentView addSubview:hpcell];
        }
        else
        {
            float widthnow = (SCREEN_WIDTH-40-20)/2;
            NSDictionary *dictemp = [FCarrayproduct objectAtIndex:indexPath.row*2];
            TbeaHpCellView *hpcell = [[TbeaHpCellView alloc] initWithFrameProduct:CGRectMake(20, 5, widthnow, widthnow+70) DicFrom:dictemp];
            hpcell.delegate1 = self;
            [cell.contentView addSubview:hpcell];
            
            NSDictionary *dictemp1 = [FCarrayproduct objectAtIndex:indexPath.row*2+1];
            TbeaHpCellView *hpcell1 = [[TbeaHpCellView alloc] initWithFrameProduct:CGRectMake(20+widthnow+20, 5, widthnow, widthnow+70) DicFrom:dictemp1];
            hpcell.delegate1 = self;
            [cell.contentView addSubview:hpcell1];
        }
    }
    else
    {
        float widthnow = (SCREEN_WIDTH-40-20)/2;
        NSDictionary *dictemp = [FCarrayproduct objectAtIndex:indexPath.row*2];
        TbeaHpCellView *hpcell = [[TbeaHpCellView alloc] initWithFrameProduct:CGRectMake(20, 5, widthnow, widthnow+70) DicFrom:dictemp];
        hpcell.delegate1 = self;
        [cell.contentView addSubview:hpcell];
        
        NSDictionary *dictemp1 = [FCarrayproduct objectAtIndex:indexPath.row*2+1];
        TbeaHpCellView *hpcell1 = [[TbeaHpCellView alloc] initWithFrameProduct:CGRectMake(20+widthnow+20, 5, widthnow, widthnow+70) DicFrom:dictemp1];
        hpcell.delegate1 = self;
        [cell.contentView addSubview:hpcell1];
    }
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark 接口
-(void)gethppage
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQTbeaHpPageViewCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarrayfocus = [[dic objectForKey:@"data"] objectForKey:@"advpicturelist"];
            FCarrayproduct = [[dic objectForKey:@"data"] objectForKey:@"productlist"];
            FCarraymessage = [[dic objectForKey:@"data"] objectForKey:@"messagelist"];
            tableview.delegate = self;
            tableview.dataSource = self;
            [tableview reloadData];
            [self viewheader];
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
