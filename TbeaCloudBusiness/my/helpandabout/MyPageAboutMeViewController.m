//
//  MyPageAboutMeViewController.m
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/10/30.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyPageAboutMeViewController.h"

@interface MyPageAboutMeViewController ()

@end

@implementation MyPageAboutMeViewController

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
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self initWKWebView];
    
}

- (void)initWKWebView
{
    userContentController = [[WKUserContentController alloc] init];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    //    [userContentController addScriptMessageHandler:self name:@"commonBack"];
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 40.0;
    configuration.preferences = preferences;
    
    
    NSString *strurlnow = [NSString stringWithFormat:@"%@%@",[app.GBURLPreFix length]>0?app.GBURLPreFix:Interfacehtmlurlheader,HtmlURLAboutMeIns];
    
    self.strurl = strurlnow;
    wkwebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-40)
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
    //    YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-160, 200, 200)];
    //    imageViewgif.tag = EnYLImageViewTag;
    //    imageViewgif.image = [YLGIFImage imageNamed:@"ccwb_common_write.gif"];
    //    [self.view insertSubview:imageViewgif aboveSubview:wkwebview];
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
    [userContentController removeScriptMessageHandlerForName:@"commonBack"];
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
#pragma mark wkviewDelegate
#pragma mark - WKScriptMessageHandler

-(void)gotoreturnjs:(NSDictionary *)dicfrom JSFunction:(NSString *)jsf
{
    //    DLog(@"custom====%@",[CustomPageObject convertToJSONData:dicfrom]);
    //    NSString *js = [NSString stringWithFormat:@"%@(%@)",jsf, [CustomPageObject convertToJSONData:dicfrom]];
    //    [wkwebview evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
    //        //TODO
    //        NSLog(@"responsec %@ %@",response,error);
    //    }];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"body:%@,%@",message.body,message.name);
    if ([message.name isEqualToString:@"commonBack"]) //返回
    {
        [self returnback];
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
    //    NSString *JsStr = @"(document.getElementsByTagName(\"video\")[0]).src";
    //    [webView evaluateJavaScript:JsStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
    //        if(![response isEqual:[NSNull null]] && response != nil){
    //            //截获到视频地址了
    //            NSLog(@"response == %@",response);
    //        }else{
    //            //没有视频链接
    //        }
    //    }];
    
    __block MyPageAboutMeViewController *weakSelf = self;
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
