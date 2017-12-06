//
//  ComMettingDetailUploadPicViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/14.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComMettingDetailUploadPicViewController : UIViewController<ActionDelegate,UITextFieldDelegate>
{
    
    AppDelegate *app;
    NSString *FCuploadstrpic;
    NSMutableArray *FCArraySelectPic;
}
@property(nonatomic,strong)NSString *FCmettingid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
