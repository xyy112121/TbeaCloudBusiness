//
//  OtherAppPageViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/18.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "OtherAppPageViewController.h"

@interface OtherAppPageViewController ()

@end

@implementation OtherAppPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	[self initview];
	// Do any additional setup after loading the view.
}

-(void)initview
{
	self.title = @"全部应用";
	self.view.backgroundColor = [UIColor whiteColor];
//	[self layoutappfunctionview];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self geotherppageapp];
}

-(void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBar.translucent = NO;
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
	[self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
}

-(void)layoutappfunctionview  //总经销商
{
	float widthspace = 20;//左右的距离
	float widthbt = 60;// 每个button的宽度
	float heightbt = 70;//   每个BUTTON的高度
	float widthnow = (SCREEN_WIDTH-widthbt*4-widthspace*2)/3;
	
	for(int i=0;i<3;i++)
	{
		for(int j=0;j<4;j++)
		{
			NSString *strpic;
			NSString *strtitle;
			switch (i*4+j)
			{
				case 0:
					strpic = @"hp特变电工";
					strtitle = @"特变电工";
					break;
				case 1:
					strpic = @"hp分销系统";
					strtitle = @"分销系统";
					break;
				case 2:
					strpic = @"hp商城系统";
					strtitle = @"商城系统";
					break;
				case 3:
					strpic = @"hp水电工管理";
					strtitle = @"水电工管理";
					break;
				case 4:
					strpic = @"hp水电工会议";
					strtitle = @"水电工会议";
					break;
				case 5:
					strpic = @"hp特变卫士";
					strtitle = @"特变卫士";
					break;
				case 6:
					strpic = @"hp扫码返利";
					strtitle = @"扫码返利";
					break;
				case 7:
					strpic = @"hp分销商管理";
					strtitle = @"分销商管理";
					break;
				case 8:
					strpic = @"hp考勤管理";
					strtitle = @"考勤管理";
					break;
				case 9:
					strpic = @"hp物流系统";
					strtitle = @"物流系统";
					break;
				case 10:
					strpic = @"hp德缆信息系统";
					strtitle = @"德缆信息系统";
					break;
				case 11:
					strpic = @"hp会员管理";
					strtitle = @"会员管理";
					break;
			}
			
			UIButton *button = [self initbutton:LOADIMAGE(strpic, @"png") Title:strtitle BtFrame:CGRectMake(widthspace+(widthbt+widthnow)*j,10+(heightbt+10)*i,widthbt,heightbt)];
			button.tag = EnHpAppFuntionBt+i*4+j;
			[button addTarget:self action:@selector(clickappfunction:) forControlEvents:UIControlEventTouchUpInside];
			[self.view addSubview:button];
			
			UILabel *lable = [self initlabel:strtitle BtFrame:CGRectMake(button.frame.origin.x-10, XYViewBottom(button)-25, button.frame.size.width+20, 20)];
			[self.view addSubview:lable];
		}
	}
}

-(UIButton *)initbutton:(NSString *)strimage Title:(NSString *)title BtFrame:(CGRect)btframe
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = btframe;
    button.backgroundColor = [UIColor clearColor];
    [button setImageEdgeInsets:UIEdgeInsetsMake(-20, 0, 0, 0)];
    
    return button;
}

-(UILabel *)initlabel:(NSString *)title BtFrame:(CGRect)btframe
{
	UILabel *lable = [[UILabel alloc] initWithFrame:btframe];
	lable.text = title;
	lable.font = FONTN(13.0f);
	lable.textColor = COLORNOW(117, 117, 117);
	lable.backgroundColor = [UIColor clearColor];
	lable.textAlignment = NSTextAlignmentCenter;
	return lable;
}

//-(void)clickappfunction:(id)sender
//{
//	UIButton *button =(UIButton *)sender;
//	int tagnow = (int)[button tag]-EnHpAppFuntionBt;
//	
//	MemberManagementViewController *membermangement;
//	switch (tagnow)
//	{
//		case 11:
//			membermangement = [[MemberManagementViewController alloc] init];
//			membermangement.hidesBottomBarWhenPushed = YES;
//			[self.navigationController pushViewController:membermangement animated:YES];
//			break;
//	}
//}

-(void)clickappfunction:(NSDictionary *)sender
{
    ScanRebatehpViewController *scanrebate; //扫码返得
    WaterPersonMangerViewController *watermanger;//水电工管理
    WaterMettingViewController *watermetting;//水电工会议
    MallStoreHpViewController *mallstore;//商城系统
    ComWaterMettingHpViewController *comwater;
    DistributorRebateHpViewController *distributorrebate;
    ComWaterPersonMangerZJXViewController *comwaterperson;
    DistributorMangerViewController *distributormanger;//分销商管理
    TbeaHPViewController *tbhp;
    UIButton *button = (UIButton *)sender;
    int tagnow = (int)[button tag]-EnHpAppFuntionBt;
    NSDictionary *dictemp = [FCarraydata objectAtIndex:tagnow];
    NSString *strmoduleid = [dictemp objectForKey:@"moduleid"];
    if([strmoduleid isEqualToString:@"shuidiangongguanli"]) //水电工管理
    {
        watermanger = [[WaterPersonMangerViewController alloc] init];
        watermanger.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:watermanger animated:YES];
    }
    else if([strmoduleid isEqualToString:@"distributor_shuidiangongguanli"]) //分销商水电工管理
    {
        watermanger = [[WaterPersonMangerViewController alloc] init];
        watermanger.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:watermanger animated:YES];
    }
    else if([strmoduleid isEqualToString:@"shuidiangonghuiyi"]) //水电工会议
    {
        watermetting = [[WaterMettingViewController alloc] init];
        watermetting.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:watermetting animated:YES];
    }
    else if([strmoduleid isEqualToString:@"shaomafanli"]) //总经销商扫码返利
    {
        scanrebate = [[ScanRebatehpViewController alloc] init];
        scanrebate.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:scanrebate animated:YES];
    }
    else if([strmoduleid isEqualToString:@"distributor_shaomafanli"]) //分销商的扫码返利
    {
        distributorrebate = [[DistributorRebateHpViewController alloc] init];
        distributorrebate.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:distributorrebate animated:YES];
    }
    else if([strmoduleid isEqualToString:@"shangchengxitong"]) //商城系统
    {
        mallstore = [[MallStoreHpViewController alloc] init];
        mallstore.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mallstore animated:YES];
    }
    else if([strmoduleid isEqualToString:@"tebianweishi"]) //特变卫士
    {
        tbhp = [[TbeaHPViewController alloc] init];
        tbhp.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tbhp animated:YES];
    }
    else if([strmoduleid isEqualToString:@"marketer_shuidiangonghuiyi"]) //公司人员水电工管理
    {
        comwater = [[ComWaterMettingHpViewController alloc] init];
        comwater.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:comwater animated:YES];
    }
    else if([strmoduleid isEqualToString:@"marketer_shuidiangongguanli"]) //公司人员水电工管理
    {
        comwaterperson = [[ComWaterPersonMangerZJXViewController alloc] init];
        comwaterperson.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:comwaterperson animated:YES];
    }
    else if([strmoduleid isEqualToString:@"tbea"]) //点击特变电工
    {
        self.tabBarController.selectedIndex = 1;
    }
    else if([strmoduleid isEqualToString:@"qitayingyong"]) //其它就用
    {
        self.tabBarController.selectedIndex = 2;
    }
    else if([strmoduleid isEqualToString:@"fenxiaoshang"])
    {
        distributormanger = [[DistributorMangerViewController alloc] init];
        distributormanger.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:distributormanger animated:YES];
    }
        
}


-(void)refreshfunctionmodule
{
    float widthspace = 40;//左右的距离
    float widthbt = 30;// 每个image的宽度
    float heightbt = 30;//   每个image的高度
    float widthnow = (SCREEN_WIDTH-widthbt*4-widthspace*2)/3;
    
    int counth = 0;
    int countv = 0;
    int countspecifi = (int)[FCarraydata count];
    counth = (countspecifi%4==0?countspecifi/4:countspecifi/4+1);
    
    
    for(int i=0;i<counth;i++)
    {
        if(i<counth-1)
        {
            countv = 4;
        }
        else
        {
            countv = countspecifi%4==0?4:countspecifi%4;
        }
        
        for(int j=0;j<countv;j++)
        {
            NSDictionary *dictemp = [FCarraydata objectAtIndex:i*4+j];
            NSString *strpic;
            NSString *strtitle;
            
            
            strpic = [dictemp objectForKey:@"moduleicon"];//[InterfaceResource stringByAppendingString:[dictemp objectForKey:@"moduleicon"]];
            strtitle = [dictemp objectForKey:@"modulename"];
            
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(widthspace+(widthbt+widthnow)*j, 20+(heightbt+50)*i, widthbt, heightbt)];
            [imageview setImageWithURL:[NSURL URLWithString:strpic]];
            [self.view addSubview:imageview];
            
            UIButton *button = [self initbutton:strpic Title:strtitle BtFrame:CGRectMake(XYViewL(imageview)-10,XYViewTop(imageview),XYViewWidth(imageview)+20,XYViewHeight(imageview)+30)];
            button.tag = EnHpAppFuntionBt+i*4+j;
            [button addTarget:self action:@selector(clickappfunction:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
            
            UILabel *lable = [self initlabel:strtitle BtFrame:CGRectMake(imageview.frame.origin.x-30, XYViewBottom(imageview)+5, widthbt+60, 20)];
            [self.view addSubview:lable];
        }
    }
}


#pragma mark 接口
-(void)geotherppageapp
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQOtherAppPageViewCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"functionmodulelist"];
            
            [self refreshfunctionmodule];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
