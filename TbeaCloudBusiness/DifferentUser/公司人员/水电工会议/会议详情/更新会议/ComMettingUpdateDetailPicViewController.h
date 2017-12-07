//
//  ComMettingUpdateDetailPicViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/12/7.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComMettingUpdateDetailPicViewController : UIViewController<UITextFieldDelegate>
{
    AppDelegate *app;
    NSString *FCuploadstrpic;
    NSArray*FCArraySelectPic;
}
@property(nonatomic,strong)NSString *FCmettingid;
@end
