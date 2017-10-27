//
//  SendComplainViewController.h
//  TeBian
//
//  Created by xyy520 on 15/12/16.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionDelegate.h"
@interface SendComplainViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
{
	UIScrollView *scrollview;
}
@property(nonatomic,strong)id<ActionDelegate> delegate1;
@end
