//
//  ComMettingDetailSHowPicViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/14.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/*图片上传页展示 页，如无图片，本页展示 成无图片，右上角带上传*/

#import <UIKit/UIKit.h>

@interface ComMettingDetailSHowPicViewController : UIViewController<ActionDelegate,UITextFieldDelegate>
{
    AppDelegate *app;
    NSMutableArray *FCarraydata;
    UIImageView *imageviewno;
}

@property(nonatomic,strong)NSString *FCfromflag; //1表示可以上传  0表示不可以上传
@property(nonatomic,strong)NSString *FCmettingid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
