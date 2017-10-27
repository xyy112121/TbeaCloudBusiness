//
//  QRCodeScan.h
//  KuaiPaiYunNan
//
//  Created by 谢 毅 on 13-7-12.
//  Copyright (c) 2013年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarReaderViewController.h"
#import "ActionDelegate.h"
@interface QRCodeScan : UIViewController<ZBarReaderDelegate,UIWebViewDelegate>
{
	UIScrollView *scrollview;
	UIWebView *webview;
	NSDictionary *dicdata;
	UIView *view1;
	UIView *view2;
	NSDictionary *dicscan;
}
@property(nonatomic,strong)NSString *fromflag;  //1表示来自于大客户的物流扫描   2表示是确认扫码返利
@property(nonatomic,strong)NSString *resultText;
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@end
