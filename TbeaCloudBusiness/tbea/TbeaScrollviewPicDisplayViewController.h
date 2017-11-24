//
//  TbeaScrollviewPicDisplayViewController.h
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/11/24.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLPhotoBrowser.h"
@interface TbeaScrollviewPicDisplayViewController : UIViewController<LLPhotoBrowserDelegate>
{
    AppDelegate *app;
    NSMutableArray *FCphotoArr;
}

@property(nonatomic,strong)NSArray *FCarraypic;
@property(nonatomic)int FCnowpage;
@end
