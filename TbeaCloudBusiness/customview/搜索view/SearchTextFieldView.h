//
//  SearchTextFieldView.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/21.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTextFieldView : UIView<UITextFieldDelegate>
{
	AppDelegate *app;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame Pastr:(NSString *)pastr;
@end
