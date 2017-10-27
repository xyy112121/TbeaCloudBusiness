//
//  ComMettinDetailUploadSummaryViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/14.
//  Copyright © 2017年 谢 毅. All rights reserved.
//
/**
 上传会议纪要
 **/


#import <UIKit/UIKit.h>

@interface ComMettinDetailUploadSummaryViewController : UIViewController<ActionDelegate,UITextViewDelegate>
{
    AppDelegate *app;
    VBTextView *vbtextview;
}
@property(nonatomic,strong)NSString *FCmettingid;
@property(nonatomic,strong)NSString *FCfromflag;//1表示可编辑   0表示不可编辑
@property(nonatomic,strong)NSString *FCmettingdes;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
