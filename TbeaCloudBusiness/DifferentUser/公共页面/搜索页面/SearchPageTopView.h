//
//  SearchPageView.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/23.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchPageTopView : UIView<UITextFieldDelegate>
{
	int fromflag; // 1 表示是几个首页的搜索  2表示城市的搜索  3表示点击 首页搜索进去后的搜索
	AppDelegate *app;
	
}

@property(nonatomic,strong)id<ActionDelegate>delgate1;
-(id)initWithFrame:(CGRect)frame Whiter:(int)white;
-(id)initWithgoods:(CGRect)frame;
@end
