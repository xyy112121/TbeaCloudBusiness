//
//  SearchKeHuViewController.h
//  TeBian
//
//  Created by xyy520 on 16/1/25.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionDelegate.h"
@interface SearchKeHuViewController : UIViewController<UITextFieldDelegate,ActionDelegate>
{
	UIScrollView *scrollview;
	NSDictionary *dickehu;
	int returnflag;
}

@property(nonatomic,strong)id<ActionDelegate> delegate1;

@end
