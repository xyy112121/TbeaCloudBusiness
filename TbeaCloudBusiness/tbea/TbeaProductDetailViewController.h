//
//  TbeaProductDetailViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/15.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0030-06-特变电工-产品介绍-详情
 **/

#import <UIKit/UIKit.h>

@interface TbeaProductDetailViewController : UIViewController<WKUIDelegate,WKScriptMessageHandler,WKNavigationDelegate,ActionDelegate,YBPopupMenuDelegate>
{
	AppDelegate *app;
	WKWebView   *wkwebview;
	WKUserContentController * userContentController;
	YBPopupMenu *ybpopmenu;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic,strong)NSString *strurl;


@end
