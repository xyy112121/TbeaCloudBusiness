//
//  AnnouncementDetailViewController.m
//  TeBian
//
//  Created by xyy520 on 15/12/16.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import "AnnouncementDetailViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
#import "YTextField.h"
@interface AnnouncementDetailViewController ()

@end

@implementation AnnouncementDetailViewController
@synthesize stranid;


-(void)returnback:(id)sender
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	JQIndicatorView *indicator = [app.window viewWithTag:IndicatorTag];
	[indicator stopAnimating];
	[self.navigationController popViewControllerAnimated:YES];
}


-(void) requestJXAndetail:(NSString *)anid
{
	NSString *postUrl = URLHeader;
	
	NSDictionary *parameters = @{@"Id":anid};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA11020000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
     Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 if([[responseObject objectForKey:@"RspCode"] isEqualToString:@"RC00000"])
		 {
			 [self initview:[responseObject objectForKey:@"AnnouncementInfo"]];
		 }
		 
         [MBProgressHUD showError:[responseObject objectForKey:@"RspDesc"] toView:self.view];

	 }];

}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"公告详情";
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	[button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
	
	button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
	[button addTarget:self action: @selector(returnback:) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	
	
	[self requestJXAndetail:self.stranid];
	// Do any additional setup after loading the view.
}

-(void)initview:(NSDictionary *)sender
{
	scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
	scrollview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:scrollview];
	
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 300, 20)];
	labeltitle.font = FONTMEDIUM(12.0f);
	labeltitle.text = [sender objectForKey:@"Name"];
	labeltitle.textColor = COLORNOW(51, 51, 51);
	[scrollview addSubview:labeltitle];
	
	float nowwidth = 5;
	float fontnow = 8.0f;
	float width1 = 80;
	float width2 = 105;
	if(SCREEN_WIDTH>380)
	{
		width1 = 110;
		width2 = 130;
		nowwidth = 5;
		fontnow = 11.0f;
	}
	else if(SCREEN_WIDTH>370)
	{
		width1 = 100;
		width2 = 120;
		nowwidth = 5;
		fontnow = 10.0f;
	}
	UILabel *labelcode = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x,labeltitle.frame.origin.y+labeltitle.frame.size.height, width1, 15)];
	labelcode.font = FONTN(fontnow);
	labelcode.text = [NSString stringWithFormat:@"编号 %@",[sender objectForKey:@"Code"]];
	labelcode.textColor = COLORNOW(151, 151, 151);
	[scrollview addSubview:labelcode];
	
	UILabel *labelstarttime = [[UILabel alloc] initWithFrame:CGRectMake(labelcode.frame.origin.x+labelcode.frame.size.width+nowwidth,labelcode.frame.origin.y, width2, 15)];
	labelstarttime.font = FONTN(fontnow);
	labelstarttime.text = [NSString stringWithFormat:@"发布日期 %@",[sender objectForKey:@"PublishDate"]];
	labelstarttime.textColor = COLORNOW(151, 151, 151);
	[scrollview addSubview:labelstarttime];
	
//	UILabel *labelendtime = [[UILabel alloc] initWithFrame:CGRectMake(labelstarttime.frame.origin.x+labelstarttime.frame.size.width+nowwidth,labelstarttime.frame.origin.y, width2, 15)];
//	labelendtime.font = FONTN(fontnow);
//	labelendtime.text = @"发布日期 2016-10-01";
//	labelendtime.textColor = COLORNOW(151, 151, 151);
//	[scrollview addSubview:labelendtime];
	
	UILabel *labelsendpersion = [[UILabel alloc] initWithFrame:CGRectMake(labelstarttime.frame.origin.x+labelstarttime.frame.size.width+nowwidth,labelstarttime.frame.origin.y,width2, 15)];
	labelsendpersion.font = FONTN(fontnow);
	labelsendpersion.text =  [NSString stringWithFormat:@"发布人 %@",[sender objectForKey:@"Author"]];
	labelsendpersion.textColor = COLORNOW(151, 151, 151);
	[scrollview addSubview:labelsendpersion];
	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(10, 60, SCREEN_WIDTH-20, 0.5)];
	imageviewline.backgroundColor = COLORNOW(211, 211, 211);
	[scrollview addSubview:imageviewline];
	
	webview = [[UIWebView alloc] initWithFrame:CGRectMake(10, imageviewline.frame.origin.y+10, SCREEN_WIDTH-20, SCREEN_HEIGHT-60-64-20)];
	webview.delegate = self;
	webview.backgroundColor = [UIColor clearColor];
	[webview loadHTMLString:[sender objectForKey:@"Content"] baseURL:nil];
	[scrollview addSubview:webview];
	
	for (UIView *_aView in [webview subviews])
	{
		if ([_aView isKindOfClass:[UIScrollView class]])
		{
			[(UIScrollView *)_aView setShowsVerticalScrollIndicator:NO]; //右侧的滚动条
			
			for (UIView *_inScrollview in _aView.subviews)
			{
				
				if ([_inScrollview isKindOfClass:[UIImageView class]])
				{
					_inScrollview.hidden = YES;  //上下滚动出边界时的黑色的图片
				}
			}
		}
	}
}

- (void)webViewDidFinishLoad:(UIWebView *) webView
{
	//    [AddInterface addactivi];
	CGSize actualSize = [webView sizeThatFits:CGSizeZero];
	
	float height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
	
	CGRect newFrame = webView.frame;
	NSLog(@"height======%f,%f,%f",height,newFrame.size.height,actualSize.height);
	newFrame.size.height = height+25;
	webView.frame = newFrame;
	
	
	CGSize size =  newFrame.size;//[self returnsize:str Fontnow:app.userinfo.floatfont];
	float textHeight = size.height;
	size.height = textHeight+10;
	
	
	scrollview.contentSize = CGSizeMake(scrollview.frame.size.width,size.height+300);
	
	//	[self setpagewebviewframe:self.frame];
	//    [AddInterface removeactive];
	
	//    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(removeaction:) userInfo:nil repeats:NO];
	NSLog(@"dfaksdjfh;aksdf;laksdjfl;kasjdf;lkajsd;fkahslkdjfhakjshdgfkajsdhgfkasjdflakjsdhflkajsdhflkjasdf");
}

-(void)gotodone:(id)sender
{
	
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
