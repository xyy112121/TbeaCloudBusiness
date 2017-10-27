//
//  ComMettingScheduleViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**0205-公司人员-水电工会议-准备-会议安排**/

#import <UIKit/UIKit.h>

@interface ComMettingScheduleViewController : UIViewController<ActionDelegate,UITextViewDelegate>
{
    AppDelegate *app;
    VBTextView *vbtextview;
}
@property(nonatomic,strong)NSString *FCfromflag;//1表示可编辑   0表示不可编辑 
@property(nonatomic,strong)NSString *FCmettingdes;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
