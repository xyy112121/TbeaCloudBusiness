//
//  JXIndexViewController.m
//  TeBian
//
//  Created by xyy520 on 15/12/14.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import "JXIndexViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
#import "JXOrderListViewController.h"
#import "JXStockListViewController.h"
#import "ReturnMoneyListViewController.h"
#import "JXGuidePriceViewController.h"
#import "OnlineComplaintViewController.h"
#import "AnnouncementListViewController.h"
#import "InstitutionViewController.h"
#import "ContactViewController.h"
#import "AnnouncementDetailViewController.h"
#import "OnlineOrderListViewController.h"
#import "PerferentialsSupportViewController.h"
@interface JXIndexViewController ()

@end

@implementation JXIndexViewController

-(void)returnback:(id)sender
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	JQIndicatorView *indicator = [app.window viewWithTag:IndicatorTag];
	[indicator stopAnimating];
	[self.navigationController popViewControllerAnimated:YES];
}

//首页
-(void) requestJXindexlist
{	
	NSDictionary *parameters = nil;//@{@"ReadStatusId":statusid,@"Page": page,@"PageSize":pagesize};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA15000000" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 dicdata = [responseObject objectForKey:@"HomepageInfo"];
		 UILabel *label1 = [self.view viewWithTag:301];
		 UILabel *label2 = [self.view viewWithTag:302];
		 UIImageView *imageheader = [self.view viewWithTag:303];
		 NSString *strshouldmoney = [NSString stringWithFormat:@"￥%@",[dicdata objectForKey:@"ShouldReveivedMoney"]];
		 CGSize size = [AddInterface getlablesize:strshouldmoney Fwidth:200 Fheight:40 Sfont:FONTN(28.0f)];
		 label1.frame = CGRectMake(label1.frame.origin.x, label1.frame.origin.y, size.width+5, size.height);
		 label1.text =  strshouldmoney;
		 label2.text = [dicdata objectForKey:@""];
		 NSArray *annou = [dicdata objectForKey:@"Announcement"];
		 if([annou count]>0)
		 {
			 label2.text = [[annou objectAtIndex:0] objectForKey:@"Name"];
		 }
		 if([label2.text length]==0)
		 {
			 UIImageView *imagenotify = [self.view viewWithTag:999];
			 imagenotify.alpha = 0;
		 }
		 NSURL *urlstr = [NSURL URLWithString:[URLPicHeader stringByAppendingString:[dicdata objectForKey:@"PersonPicture"]]];
		 [imageheader setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"test1", @"png")];
	 }];
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

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	
    self.view.backgroundColor = [UIColor whiteColor];
    
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"特变电工分销系统";
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	[button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
	
	button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
	[button addTarget:self action: @selector(returnback:) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	
	[self initview:nil];
	[self requestJXindexlist];
    // Do any additional setup after loading the view.
}

-(void)initview:(id)sender
{
	scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
	scrollview.backgroundColor = [UIColor clearColor];
	scrollview.showsHorizontalScrollIndicator = NO;
	scrollview.showsVerticalScrollIndicator = NO;
	[self.view addSubview:scrollview];
	
	//上面部分
	UIImageView *imageviewbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
	imageviewbg.image = LOADIMAGE(@"jxtopbg", @"png");
	
	[scrollview addSubview:imageviewbg];
	
	UIImageView *imageviewheader = [[UIImageView alloc] initWithFrame:CGRectMake(30, 20, 70, 70)];
	imageviewheader.image = LOADIMAGE(@"test1", @"png");
	imageviewheader.clipsToBounds = YES;
	imageviewheader.tag = 303;
	imageviewheader.layer.cornerRadius = 35;
	[scrollview addSubview:imageviewheader];
	
	UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(imageviewheader.frame.origin.x+imageviewheader.frame.size.width+20, imageviewheader.frame.origin.y+10, 150, 20)];
	label1.textColor = [UIColor whiteColor];
	label1.text = @"应收帐款余额";
	label1.font = FONTMEDIUM(13.0f);
	[scrollview addSubview:label1];
	
	CGSize size = [AddInterface getlablesize:@"99865.45" Fwidth:200 Fheight:40 Sfont:FONTN(28.0f)];
	UILabel *labelmoney = [[UILabel alloc]initWithFrame:CGRectMake(label1.frame.origin.x, label1.frame.origin.y+label1.frame.size.height, size.width+5, size.height)];
	labelmoney.textColor = [UIColor whiteColor];
	labelmoney.text = @"";
	labelmoney.tag = 301;
	labelmoney.font = FONTN(28.0f);
	[scrollview addSubview:labelmoney];
	
	UIImageView *imageviewunit = [[UIImageView alloc] initWithFrame:CGRectMake(labelmoney.frame.origin.x+labelmoney.frame.size.width, labelmoney.frame.origin.y+labelmoney.frame.size.height-20, 14, 14)];
	imageviewunit.image = LOADIMAGE(@"元icon", @"png");
	[scrollview addSubview:imageviewunit];
	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(17, imageviewheader.frame.origin.y+imageviewheader.frame.size.height+10, SCREEN_WIDTH-17*2, 1)];
	imageviewline.backgroundColor = COLORNOW(240, 240, 240);
	[scrollview addSubview:imageviewline];
	
	UILabel *labelsummary = [[UILabel alloc]initWithFrame:CGRectMake(imageviewheader.frame.origin.x, imageviewline.frame.origin.y+10, SCREEN_WIDTH-50, 20)];
	labelsummary.textColor = [UIColor whiteColor];
	labelsummary.tag = 302;
	labelsummary.text = @"";
	labelsummary.font = FONTMEDIUM(12.0f);
	labelsummary.textColor = COLORNOW(240, 240, 240);
	[scrollview addSubview:labelsummary];
	
	UIButton *buttonclick = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonclick.frame = CGRectMake(imageviewheader.frame.origin.x, imageviewline.frame.origin.y+10, SCREEN_WIDTH-50, 20);
	[buttonclick addTarget:self action:@selector(gotoandetail:) forControlEvents:UIControlEventTouchUpInside];
	[scrollview addSubview:buttonclick];
	
	UIImageView *imageviewnotify = [[UIImageView alloc] initWithFrame:CGRectMake(imageviewheader.frame.origin.x-13, labelsummary.frame.origin.y+5, 10, 10)];
	imageviewnotify.image = LOADIMAGE(@"公告icon", @"png");
	imageviewnotify.tag = 999;
	[scrollview addSubview:imageviewnotify];
	
	
	//中间部分
	UIImageView *imageviewbtbg = [[UIImageView alloc] initWithFrame:CGRectMake(imageviewline.frame.origin.x, 140, imageviewline.frame.size.width, 40)];
	imageviewbtbg.backgroundColor = [UIColor whiteColor];
	imageviewbtbg.layer.shadowColor = COLORNOW(20, 20, 20).CGColor;
	imageviewbtbg.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
	imageviewbtbg.layer.shadowOpacity = 0.5;//不透明度
	imageviewbtbg.layer.shadowRadius = 10.0;//半径
	[scrollview addSubview:imageviewbtbg];
	
	UIImageView *imageviewspe = [[UIImageView alloc] initWithFrame:CGRectMake(imageviewbtbg.frame.origin.x+(imageviewbtbg.frame.size.width/2), imageviewbtbg.frame.origin.y+7, 1, 26)];
	imageviewspe.backgroundColor = COLORNOW(200, 200, 200);
	[scrollview addSubview:imageviewspe];
	
	UIButton *buttonorder = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonorder.frame = CGRectMake(imageviewbtbg.frame.origin.x,imageviewbtbg.frame.origin.y, imageviewbtbg.frame.size.width/2, imageviewbtbg.frame.size.height);
	buttonorder.titleLabel.font = FONTN(13.0f);
	[buttonorder setTitleColor:COLORNOW(23, 69, 146) forState:UIControlStateNormal];
	[buttonorder addTarget:self action:@selector(gotoordersearch:) forControlEvents:UIControlEventTouchUpInside];
	[buttonorder setTitle:@"订单查询" forState:UIControlStateNormal];
	[scrollview addSubview:buttonorder];
	
	UIButton *buttonstock = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonstock.frame = CGRectMake(imageviewspe.frame.origin.x+1,imageviewbtbg.frame.origin.y, (imageviewbtbg.frame.size.width/2)-1, imageviewbtbg.frame.size.height);
	buttonstock.titleLabel.font = FONTN(13.0f);
	[buttonstock setTitleColor:COLORNOW(23, 69, 146) forState:UIControlStateNormal];
	[buttonstock addTarget:self action:@selector(gotostocksearch:) forControlEvents:UIControlEventTouchUpInside];
	[buttonstock setTitle:@"库存查询" forState:UIControlStateNormal];
	[scrollview addSubview:buttonstock];
	
	float nowheight = imageviewbtbg.frame.origin.y+imageviewbtbg.frame.size.height+30;
	float nowwidth = (SCREEN_WIDTH-130)/4;
	for(int i=0;i<8;i++)
	{
		UIButton *buttonstock = [UIButton buttonWithType:UIButtonTypeCustom];
		if(i<4)
			buttonstock.frame = CGRectMake(20+(nowwidth+30)*i,nowheight, nowwidth, nowwidth);
		else
		{
			buttonstock.frame = CGRectMake(20+(nowwidth+30)*(i-4),nowheight+nowwidth+40, nowwidth, nowwidth);
		}
		buttonstock.tag = 230+i;
		buttonstock.titleLabel.font = FONTN(13.0f);
		[buttonstock setTitleColor:COLORNOW(23, 69, 146) forState:UIControlStateNormal];
		[buttonstock addTarget:self action:@selector(gotomenu:) forControlEvents:UIControlEventTouchUpInside];
		
		UILabel *labeltitle = [[UILabel alloc]initWithFrame:CGRectMake(buttonstock.frame.origin.x-5, buttonstock.frame.origin.y+buttonstock.frame.size.height+5, buttonstock.frame.size.width+10, 20)];
		labeltitle.textColor = [UIColor whiteColor];
		labeltitle.textAlignment = NSTextAlignmentCenter;
		labeltitle.font = FONTN(12.0f);
		labeltitle.textColor = COLORNOW(70, 70, 70);
		
		switch (i)
		{
			case 0:
				[buttonstock setImage:LOADIMAGE(@"限时抢购", @"png") forState:UIControlStateNormal];
				labeltitle.text = @"在线下单";
				break;
			case 1:
				[buttonstock setImage:LOADIMAGE(@"中信自营", @"png") forState:UIControlStateNormal];
				labeltitle.text = @"指导价格";
				break;
			case 2:
				[buttonstock setImage:LOADIMAGE(@"生鲜水果", @"png") forState:UIControlStateNormal];
				labeltitle.text = @"回款明细";
				break;
			case 3:
				[buttonstock setImage:LOADIMAGE(@"美食餐饮", @"png") forState:UIControlStateNormal];
				labeltitle.text = @"优惠支持";
				break;
			case 4:
				[buttonstock setImage:LOADIMAGE(@"母婴亲子", @"png") forState:UIControlStateNormal];
				labeltitle.text = @"在线投诉";
				break;
			case 5:
				[buttonstock setImage:LOADIMAGE(@"海淘精品", @"png") forState:UIControlStateNormal];
				labeltitle.text = @"公告查询";
				break;
			case 6:
				[buttonstock setImage:LOADIMAGE(@"休闲娱乐", @"png") forState:UIControlStateNormal];
				labeltitle.text = @"制度查询";
				break;
			case 7:
				[buttonstock setImage:LOADIMAGE(@"生活服务", @"png") forState:UIControlStateNormal];
				labeltitle.text = @"联系我们";
				break;

		}
		[scrollview addSubview:buttonstock];
		[scrollview addSubview:labeltitle];
	}
	
	//底部图
	UIImageView *imageviewbottom = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-256)/2,scrollview.frame.size.height-StatusBarAndNavigationHeight-80, 256, 82)];
	imageviewbottom.image = LOADIMAGE(@"jxlogo", @"png");
	[scrollview insertSubview:imageviewbottom atIndex:0];
}

-(void)gotoandetail:(id)sender
{
	NSArray *annou = [dicdata objectForKey:@"Announcement"];
	NSDictionary *dicmessage = [annou objectAtIndex:0];
    AnnouncementDetailViewController *announcedetail = [[AnnouncementDetailViewController alloc] init];
	announcedetail.stranid = [dicmessage objectForKey:@"Id"];
	[self.navigationController pushViewController:announcedetail animated:YES];
}

-(void)gotoordersearch:(id)sender
{
    JXOrderListViewController *orderlist = [[JXOrderListViewController alloc] init];
	[self.navigationController pushViewController:orderlist animated:YES];
}

-(void)gotostocksearch:(id)sender
{
    JXStockListViewController *stocklist = [[JXStockListViewController alloc] init];
	[self.navigationController pushViewController:stocklist animated:YES];
	
}

-(void)gotomenu:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]-230;
	ReturnMoneyListViewController *returnmoney;
	JXGuidePriceViewController *guideprice;
	OnlineComplaintViewController *onlinecomplain;
	AnnouncementListViewController *announcement;
	InstitutionViewController *institution;
	ContactViewController *contactus;
	OnlineOrderListViewController *onlineorder;
	PerferentialsSupportViewController *perferent;
	switch (tagnow)
	{
		case 0://在线下单
            onlineorder = [[OnlineOrderListViewController alloc] init];
			[self.navigationController pushViewController:onlineorder animated:YES];
			break;
		case 1://指导价格
            guideprice = [[JXGuidePriceViewController alloc] init];
			[self.navigationController pushViewController:guideprice animated:YES];
			break;
		case 2://回款明细
			returnmoney = [[ReturnMoneyListViewController alloc] init];
			[self.navigationController pushViewController:returnmoney animated:YES];
			break;
		case 3://优惠支持
			perferent = [[PerferentialsSupportViewController alloc] init];
            [self.navigationController pushViewController:perferent animated:YES];
			break;
		case 4://在线投诉
			onlinecomplain = [[OnlineComplaintViewController alloc] init];
			[self.navigationController pushViewController:onlinecomplain animated:YES];
			break;
		case 5://公告查询
			announcement = [[AnnouncementListViewController alloc] init];
			[self.navigationController pushViewController:announcement animated:YES];
			break;
		case 6://制度查询
			institution = [[InstitutionViewController alloc] init];
			[self.navigationController pushViewController:institution animated:YES];
			break;
		case 7://联系我们
			contactus = [[ContactViewController alloc] init];
			[self.navigationController pushViewController:contactus animated:YES];
			break;

	}
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
