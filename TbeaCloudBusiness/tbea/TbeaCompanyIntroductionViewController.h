//
//  TbeaCompanyIntroductionViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/14.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0010-特变电工-公司简介
 **/

#import <UIKit/UIKit.h>

@interface TbeaCompanyIntroductionViewController : UIViewController<WKUIDelegate,WKScriptMessageHandler,WKNavigationDelegate,ActionDelegate>
{
	AppDelegate *app;
	WKWebView   *wkwebview;
	WKUserContentController * userContentController;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic,strong)NSString *strurl;
@end
