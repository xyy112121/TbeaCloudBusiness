//
//  SearchWuLiaoViewController.h
//  TeBian
//
//  Created by xyy520 on 16/1/4.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionDelegate.h"
@interface SearchWuLiaoViewController : UIViewController<UITextFieldDelegate,ActionDelegate>
{
	UIScrollView *scrollview;
	int returnflag;
}

@property(nonatomic,strong)id<ActionDelegate> delegate1;

@end
