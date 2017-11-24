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
#import "LLPhotoBrowser.h"
@interface TbeaProductDetailViewController : UIViewController<WKUIDelegate,WKScriptMessageHandler,WKNavigationDelegate,ActionDelegate,LLPhotoBrowserDelegate,YBPopupMenuDelegate>
{
	AppDelegate *app;
	WKWebView   *wkwebview;
	WKUserContentController * userContentController;
	YBPopupMenu *ybpopmenu;
    NSMutableArray *FCphotoArr;
    NSArray *FCarraypic;
    int FCnowpage;
}
@property(nonatomic,strong)NSDictionary *FCdicproduct;
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic,strong)NSString *strurl;


@end
