//
//  TbeaProductDetailViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/15.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#define TITLES @[@"消息",@"首页",@"分享"]

#import "TbeaProductDetailViewController.h"

@interface TbeaProductDetailViewController ()

@end

@implementation TbeaProductDetailViewController

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
	
	UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
	UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
	[buttonright setImage:LOADIMAGE(@"morepointwhite", @"png") forState:UIControlStateNormal];
	[buttonright addTarget:self action: @selector(Clickmorefunction:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewright addSubview:buttonright];
	buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
	// Do any additional setup after loading the view.
}

#pragma mark 页面布局
-(void)initview
{
	self.title = [_FCdicproduct objectForKey:@"name"];
	self.view.backgroundColor = [UIColor whiteColor];
    FCphotoArr = [[NSMutableArray alloc] init];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	UIView *view = [self addtabviewheader:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
	[self.view addSubview:view];
	[self initWKWebView];
}

//表头
-(UIView *)addtabviewheader:(CGRect)frame
{
	UIView *viewselectitem = [[UIView alloc] initWithFrame:frame];
	viewselectitem.backgroundColor = [UIColor whiteColor];
	
	UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 0.7)];
	line1.backgroundColor = COLORNOW(200, 200, 200);
	[viewselectitem addSubview:line1];
	
	UIButton *buttonleft = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonleft.frame = CGRectMake(0, 0, SCREEN_WIDTH/2,39);
	buttonleft.backgroundColor = [UIColor clearColor];
	buttonleft.tag = EnTbeaProductDetailSelect1;
	[buttonleft setTitle:@"图片信息" forState:UIControlStateNormal];
	buttonleft.titleLabel.font = FONTN(15.0f);
	[buttonleft setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
	[buttonleft addTarget:self action:@selector(clickbuttonselectitem:) forControlEvents:UIControlEventTouchUpInside];
	[viewselectitem addSubview:buttonleft];
	
	UIButton *buttonright = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonright.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2,39);
	buttonright.backgroundColor = [UIColor clearColor];
	buttonright.tag = EnTbeaProductDetailSelect2;
	[buttonright setTitle:@"产品参数" forState:UIControlStateNormal];
	buttonright.titleLabel.font = FONTN(15.0f);
	[buttonright setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
	[buttonright addTarget:self action:@selector(clickbuttonselectitem:) forControlEvents:UIControlEventTouchUpInside];
	[viewselectitem addSubview:buttonright];
	
	return viewselectitem;
}

- (void)initWKWebView
{
	userContentController = [[WKUserContentController alloc] init];
	WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
	configuration.userContentController = userContentController;
    [userContentController addScriptMessageHandler:self name:@"showlargepicture"];
	
	WKPreferences *preferences = [WKPreferences new];
	preferences.javaScriptCanOpenWindowsAutomatically = YES;
	preferences.minimumFontSize = 40.0;
	configuration.preferences = preferences;
	
	self.strurl = [NSString stringWithFormat:@"%@%@%@",[app.GBURLPreFix length]>0?app.GBURLPreFix:Interfacehtmlurlheader,HtmlURLTbeaProductDetail,[_FCdicproduct objectForKey:@"id"]];
	wkwebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-64-40)
								   configuration:configuration];
	NSURL *fileURL = [NSURL URLWithString:self.strurl];
	NSURLRequest *request  = [NSURLRequest requestWithURL:fileURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
	[wkwebview loadRequest:request];
	wkwebview.navigationDelegate = self;
	wkwebview.UIDelegate = self;
	[self.view addSubview:wkwebview];
	
	wkwebview.backgroundColor = [UIColor clearColor];
	wkwebview.scrollView.showsVerticalScrollIndicator = NO;
	wkwebview.scrollView.showsHorizontalScrollIndicator = NO;
	UIScrollView *scroller = [wkwebview.subviews objectAtIndex:0];
	if ([scroller isKindOfClass:[UIScrollView class]]&&scroller)
	{
		scroller.bounces = NO;
		scroller.alwaysBounceVertical = NO;
		scroller.alwaysBounceHorizontal = NO;
	}
	//	YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-160, 200, 200)];
	//	imageViewgif.tag = EnYLImageViewTag;
	//	imageViewgif.image = [YLGIFImage imageNamed:@"ccwb_common_write.gif"];
	//	[self.view insertSubview:imageViewgif aboveSubview:wkwebview];
}

- (void)dealloc
{
	NSLog(@"%s",__FUNCTION__);
	[userContentController removeScriptMessageHandlerForName:@"showlargepicture"];
}

-(void)viewWillAppear:(BOOL)animated
{
	[[self.navigationController.navigationBar viewWithTag:EnNctlSearchViewTag] removeFromSuperview];
	self.navigationController.navigationBar.translucent = NO;
	[self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
	[self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
	UIColor* color = [UIColor whiteColor];
	NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes= dict;
}

#pragma mark 点击网络图片
-(void)clickwebpic
{
    [FCphotoArr removeAllObjects];
    for(int i=0;i<[FCarraypic count];i++)
    {
        NSDictionary *dictemp = [FCarraypic objectAtIndex:i];
        [FCphotoArr addObject:[dictemp objectForKey:@"picture"]];
    }
    
    // 1 初始化
    LLPhotoBrowser *photoBrowser = [[LLPhotoBrowser alloc]init];
    // 2 设置代理
    photoBrowser.delegate = self;
    // 3 设置当前图片
    photoBrowser.currentImageIndex = FCnowpage;
    // 4 设置图片的个数
    photoBrowser.imageCount = [FCarraypic count];
    // 5 设置图片的容器
    photoBrowser.sourceImagesContainerView = self.view;
    // 6 展示
    [photoBrowser show];
}

#pragma mark LLPhotoDelegate
// 代理方法 返回图片URL
- (NSURL *)photoBrowser:(LLPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index{
    
    NSURL *url = [NSURL URLWithString:FCphotoArr[index]];
    return url;
}
// 代理方法返回缩略图
- (UIImage *)photoBrowser:(LLPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index{
    
    //    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
    //    UIImageView *imageview = [self.view viewWithTag:EnWaterMettingPicArrmentImageViewTag+index];
    
    return nil;//imageview.image;
    
}


#pragma mark pop弹出框
- (void)Clickmorefunction:(id)sender
{
	//	UIButton *button = (UIButton *)sender;
	
	NSMutableArray *arrayicons = [[NSMutableArray alloc] init];
	[arrayicons addObject:LOADIMAGE(@"tbeamessageicon", @"png")];
	[arrayicons addObject:LOADIMAGE(@"tbeahpicon", @"png")];
	[arrayicons addObject:LOADIMAGE(@"tbeashareicon", @"png")];
	ybpopmenu = [YBPopupMenu showRelyOnView:sender titles:TITLES icons:arrayicons menuWidth:100 otherSettings:^(YBPopupMenu *popupMenu)
				 {
					 popupMenu.dismissOnSelected = NO;
					 popupMenu.isShowShadow = YES;
					 popupMenu.delegate = self;
					 popupMenu.offset = 5;
					 popupMenu.type = YBPopupMenuTypeDefault;
					 popupMenu.rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight|UIRectCornerAllCorners;
				 }];
	
}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
	if([TITLES[index] isEqualToString:@"全部"])
	{
		
	}
	else if([TITLES[index] isEqualToString:@"分销商"])
	{
		
	}
	else
	{
		
	}
	[ybpopmenu dismiss];
	NSLog(@"点击了 %@ 选项",TITLES[index]);
}

#pragma mark IBAction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)clickbuttonselectitem:(id)sender
{
	UIButton *button = (UIButton *)sender;
	UIButton *button1 = [self.view viewWithTag:EnTbeaProductDetailSelect1];
	UIButton *button2 = [self.view viewWithTag:EnTbeaProductDetailSelect2];
	
	[button1 setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
	[button2 setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
	[button setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
	int tagnow = (int)[button tag];
	if(tagnow == EnTbeaProductDetailSelect1)
	{
		self.strurl = [NSString stringWithFormat:@"%@%@%@",[app.GBURLPreFix length]>0?app.GBURLPreFix:Interfacehtmlurlheader,HtmlURLTbeaProductDetail,[_FCdicproduct objectForKey:@"id"]];
		NSURL *fileURL = [NSURL URLWithString:self.strurl];
		NSURLRequest *request  = [NSURLRequest requestWithURL:fileURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
		[wkwebview loadRequest:request];
	}
	else if(tagnow == EnTbeaProductDetailSelect2)
	{
		self.strurl = [NSString stringWithFormat:@"%@%@%@",[app.GBURLPreFix length]>0?app.GBURLPreFix:Interfacehtmlurlheader,HtmlUrlTbeaProductParameter,[_FCdicproduct objectForKey:@"id"]];
		NSURL *fileURL = [NSURL URLWithString:self.strurl];
		NSURLRequest *request  = [NSURLRequest requestWithURL:fileURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
		[wkwebview loadRequest:request];
	}
	
}

#pragma mark wkviewDelegate
#pragma mark - WKScriptMessageHandler

-(void)gotoreturnjs:(NSDictionary *)dicfrom JSFunction:(NSString *)jsf
{
	//	DLog(@"custom====%@",[CustomPageObject convertToJSONData:dicfrom]);
	//	NSString *js = [NSString stringWithFormat:@"%@(%@)",jsf, [CustomPageObject convertToJSONData:dicfrom]];
	//	[wkwebview evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
	//		//TODO
	//		NSLog(@"responsec %@ %@",response,error);
	//	}];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
	NSLog(@"body:%@,%@",message.body,message.name);
	if ([message.name isEqualToString:@"showlargepicture"]) //返回
	{
        NSString *strjson = message.body;
        if (![strjson isKindOfClass:[NSString class]]) {
            return;
        }
        
        NSDictionary *tempdic = [AddInterface dictionaryWithJsonString:strjson];
        
        
        [self getpiclist:[tempdic objectForKey:@"id"] NowPage:[tempdic objectForKey:@"sequence"]];

        DLog(@"userinfo====%@",tempdic);
	}
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
	DLog(@"开始加载");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
	
	DLog(@"加载完成");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
	//	NSString *JsStr = @"(document.getElementsByTagName(\"video\")[0]).src";
	//	[webView evaluateJavaScript:JsStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
	//		if(![response isEqual:[NSNull null]] && response != nil){
	//			//截获到视频地址了
	//			NSLog(@"response == %@",response);
	//		}else{
	//			//没有视频链接
	//		}
	//	}];
	
	__block TbeaCompanyIntroductionViewController *weakSelf = self;
	dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
	dispatch_after(delayTime, dispatch_get_main_queue(), ^{
		[[weakSelf.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
	});
	
	
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
	
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
	[[self.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
	DLog(@"55555");
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
	DLog(@"22222");
}



// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
	DLog(@"333333");
	NSLog(@"%@",navigationResponse.response.URL.absoluteString);
	NSString *requestString = navigationResponse.response.URL.absoluteString;
	
	decisionHandler(WKNavigationResponsePolicyAllow);
	
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
	DLog(@"3453453");
	NSLog(@"%@",navigationAction.request.URL.absoluteString);
	NSString *requestString = navigationAction.request.URL.absoluteString;
	
	decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		completionHandler();
	}])];
	
	[self presentViewController:alertController animated:YES completion:nil];
	
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
	//    DLOG(@"msg = %@ frmae = %@",message,frame);
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
		completionHandler(NO);
	}])];
	[alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		completionHandler(YES);
	}])];
	
	[self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
	[alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
		textField.text = defaultText;
	}];
	[alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		completionHandler(alertController.textFields[0].text?:@"");
	}])];
	
	[self presentViewController:alertController animated:YES completion:nil];
	
}


#pragma mark 接口
-(void)getpiclist:(NSString *)commodityid NowPage:(NSString *)nowpage
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"commodityid"] = commodityid;

    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQWebPicDisplayListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraypic = [[dic objectForKey:@"data"] objectForKey:@"picturelist"];
            FCnowpage = [nowpage intValue];
            [self clickwebpic];
//            TbeaScrollviewPicDisplayViewController *tbeascrollview = [[TbeaScrollviewPicDisplayViewController alloc] init];
//            tbeascrollview.FCarraypic = [[dic objectForKey:@"data"] objectForKey:@"picturelist"];
//            tbeascrollview.FCnowpage = [nowpage intValue];
//            [self.navigationController pushViewController:tbeascrollview animated:YES];
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
