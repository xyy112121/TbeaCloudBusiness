//
//  MallStoreSendDynamicViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/9/1.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/*发表动态文章*/

#import <UIKit/UIKit.h>

@interface MallStoreSendDynamicViewController : UIViewController<ActionDelegate,UITextFieldDelegate>
{
    
    AppDelegate *app;
    NSString *FCuploadstrpic;
    UIView *FCviewpic;
    
    NSMutableArray *FCarraypic;
    NSMutableArray *FCarrayimage;
    
    UITextField *FCtextfieldtitle;
    UITextField *FCtextfieldcontent;
}
@property(nonatomic,strong)NSString *FCmettingid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;


@end
