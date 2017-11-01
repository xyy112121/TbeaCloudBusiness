//
//  MyPageHelpViewController.h
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/10/30.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 帮助页面
 **/

#import <UIKit/UIKit.h>

@interface MyPageHelpViewController : UIViewController<WKUIDelegate,WKScriptMessageHandler,WKNavigationDelegate,ActionDelegate>
{
    AppDelegate *app;
    WKWebView   *wkwebview;
    WKUserContentController * userContentController;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic,strong)NSString *strurl;

@end
