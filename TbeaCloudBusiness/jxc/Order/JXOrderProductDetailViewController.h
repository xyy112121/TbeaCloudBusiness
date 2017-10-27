//
//  JXOrderProductDetailViewController.h
//  TeBian
//
//  Created by xyy520 on 16/2/26.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXOrderProductDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
	NSArray *arraydata;
}
@property(nonatomic,strong)NSString *strorderid;
@property(nonatomic,strong)IBOutlet UITableView *tableview;

@end
