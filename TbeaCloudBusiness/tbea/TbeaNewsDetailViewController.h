//
//  TbeaNewsDetailViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/14.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0020-02-特变电工-新闻资讯-查看
 **/

#import <UIKit/UIKit.h>

@interface TbeaNewsDetailViewController : UIViewController<WKUIDelegate,WKScriptMessageHandler,WKNavigationDelegate,ActionDelegate>
{
	AppDelegate *app;
	WKWebView   *wkwebview;
	WKUserContentController * userContentController;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic,strong)NSString *FCnewsid;

@end
