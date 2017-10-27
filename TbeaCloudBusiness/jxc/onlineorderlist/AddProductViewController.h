//
//  AddProductViewController.h
//  TeBian
//
//  Created by xyy520 on 15/12/24.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionDelegate.h"
@interface AddProductViewController : UIViewController<UITextFieldDelegate,ActionDelegate,UIScrollViewDelegate>
{
	UIScrollView *scrollview;
	NSDictionary *dicwuliao;
	
}
@property(nonatomic,strong)NSString *strorderid;
@property(nonatomic,strong)id<ActionDelegate> delegate1;
@end
