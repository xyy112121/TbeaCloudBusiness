//
//  QRCodeScan.m
//  KuaiPaiYunNan
//
//  Created by 谢 毅 on 13-7-12.
//  Copyright (c) 2013年 谢 毅. All rights reserved.
//

#import "QRCodeScan.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
@interface QRCodeScan ()

@end

@implementation QRCodeScan
@synthesize resultText;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)returnback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self scanButtonTapped];
    self.title = @"二维码扫描";
	if([self.fromflag isEqualToString:@"2"])
	{
		 self.title = @"扫码详情";
	}
	self.view.backgroundColor = COLORNOW(240, 240, 240);
//    [[self.navigationController.navigationBar viewWithTag:1009] setAlpha:0];
    UIImage* img=LOADIMAGE(@"returnback", @"png");
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(0, 0, 40, 40);
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn addTarget: self action: @selector(returnback:) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem* item=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=item;


}

-(UIView *)viewproduct:(NSDictionary *)sender Frame:(CGRect)frame
{
	UIView *productview = [[UIView alloc] initWithFrame:frame];
	productview.backgroundColor = [UIColor whiteColor];
	productview.layer.cornerRadius = 3.0f;
	productview.clipsToBounds = YES;
	
	
	for(int i=0;i<4;i++)
	{
		UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40*i, frame.size.width, 0.5)];
		imageviewline.backgroundColor = COLORNOW(230, 230, 230);
		[productview addSubview:imageviewline];
		
		if(i==0)
		{
			UILabel *labelproduct = [[UILabel alloc] initWithFrame:CGRectMake(10,10, 200, 20)];
			labelproduct.font = FONTN(15.0f);
			labelproduct.text = @"产品信息";
			labelproduct.textColor = COLORNOW(0, 51, 153);
			[productview addSubview:labelproduct];
		}
		else if(i==1)
		{
			UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10,imageviewline.frame.origin.y+10, 65, 20)];
			labelname.font = FONTN(15.0f);
			labelname.text = @"产品名称:";
			labelname.textColor = COLORNOW(153, 153, 153);
			[productview addSubview:labelname];
			
			UILabel *labelnamevalue = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x+labelname.frame.size.width+2,imageviewline.frame.origin.y+1, 100, 38)];
			labelnamevalue.font = FONTN(13.0f);
			labelnamevalue.numberOfLines = 2;
			labelnamevalue.text = [sender objectForKey:@"Name"];
			labelnamevalue.textColor = COLORNOW(0, 0, 0);
			[productview addSubview:labelnamevalue];
			
			UILabel *labelguige = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,labelname.frame.origin.y, 65, 20)];
			labelguige.font = FONTN(15.0f);
			labelguige.text = @"型号规格:";
			labelguige.textColor = COLORNOW(153, 153, 153);
			[productview addSubview:labelguige];
			
			UILabel *labelguigevalue = [[UILabel alloc] initWithFrame:CGRectMake(labelguige.frame.origin.x+labelguige.frame.size.width+2,imageviewline.frame.origin.y+1, SCREEN_WIDTH/2-80, 38)];
			labelguigevalue.font = FONTN(13.0f);
			labelguigevalue.numberOfLines = 2;
			labelguigevalue.text = [sender objectForKey:@"Specifications"];
			labelguigevalue.textColor = COLORNOW(0, 0, 0);
			[productview addSubview:labelguigevalue];
		}
		else if(i==2)
		{
			UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10,imageviewline.frame.origin.y+10, 65, 20)];
			labelname.font = FONTN(15.0f);
			labelname.text = @"生产日期:";
			labelname.textColor = COLORNOW(153, 153, 153);
			[productview addSubview:labelname];
			
			UILabel *labelnamevalue = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x+labelname.frame.size.width+2,imageviewline.frame.origin.y+1, SCREEN_WIDTH/2-80, 38)];
			labelnamevalue.font = FONTN(13.0f);
			labelnamevalue.numberOfLines = 2;
			labelnamevalue.text = [sender objectForKey:@"DeliverDate"];
			labelnamevalue.textColor = COLORNOW(0, 0, 0);
			[productview addSubview:labelnamevalue];
			
			UILabel *labelguige = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,labelname.frame.origin.y, 65, 20)];
			labelguige.font = FONTN(15.0f);
			labelguige.text = @"发货日期:";
			labelguige.textColor = COLORNOW(153, 153, 153);
			[productview addSubview:labelguige];
			
			UILabel *labelguigevalue = [[UILabel alloc] initWithFrame:CGRectMake(labelguige.frame.origin.x+labelguige.frame.size.width+2,imageviewline.frame.origin.y+1, SCREEN_WIDTH/2-80, 38)];
			labelguigevalue.font = FONTN(13.0f);
			labelguigevalue.numberOfLines = 2;
			labelguigevalue.text = [sender objectForKey:@"ManuDate"];
			labelguigevalue.textColor = COLORNOW(0, 0, 0);
			[productview addSubview:labelguigevalue];
		}
		else if(i==3)
		{
			UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10,imageviewline.frame.origin.y+10, 65, 20)];
			labelname.font = FONTN(15.0f);
			labelname.text = @"发往客户:";
			labelname.textColor = COLORNOW(153, 153, 153);
			[productview addSubview:labelname];
			
			UILabel *labelnamevalue = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x+labelname.frame.size.width+2,imageviewline.frame.origin.y+1, SCREEN_WIDTH-80, 38)];
			labelnamevalue.font = FONTN(13.0f);
			labelnamevalue.text = [sender objectForKey:@"Manufacture"];;
			labelnamevalue.textColor = COLORNOW(0, 0, 0);
			[productview addSubview:labelnamevalue];
		}
	}
	
	return productview;
}


-(UIView *)viewparame:(NSArray *)sender Frame:(CGRect)frame
{
	UIView *productview = [[UIView alloc] initWithFrame:frame];
	productview.backgroundColor = [UIColor whiteColor];
	productview.layer.cornerRadius = 3.0f;
	productview.clipsToBounds = YES;
	
	
	for(int i=0;i<5;i++)
	{
		UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40*i, frame.size.width, 0.5)];
		imageviewline.backgroundColor = COLORNOW(230, 230, 230);
		[productview addSubview:imageviewline];
		
		if(i==0)
		{
			UILabel *labelproduct = [[UILabel alloc] initWithFrame:CGRectMake(10,10, 200, 20)];
			labelproduct.font = FONTN(15.0f);
			labelproduct.text = @"工艺参数";
			labelproduct.textColor = COLORNOW(0, 51, 153);
			[productview addSubview:labelproduct];
			
			
		}
		else if(i==1)
		{
			
			UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10,imageviewline.frame.origin.y+10, 60, 20)];
			labelname.font = FONTN(15.0f);
			labelname.text = @"工序:";
			labelname.textColor = COLORNOW(153, 153, 153);
			[productview addSubview:labelname];
			
			UILabel *labelnamevalue = [[UILabel alloc] initWithFrame:CGRectMake(productview.frame.size.width/3,imageviewline.frame.origin.y+1, 100, 38)];
			labelnamevalue.font = FONTN(13.0f);
			labelnamevalue.numberOfLines = 2;
			labelnamevalue.text =@"班组";
			labelnamevalue.textColor = COLORNOW(153,153,153);
			[productview addSubview:labelnamevalue];
			
			UILabel *labelguige = [[UILabel alloc] initWithFrame:CGRectMake(productview.frame.size.width/3*2,labelname.frame.origin.y, 65, 20)];
			labelguige.font = FONTN(15.0f);
			labelguige.text = @"日期";
			labelguige.textColor = COLORNOW(153, 153, 153);
			[productview addSubview:labelguige];
		}
		else if(i==2)
		{
			if([sender count]>0)
			{
				NSDictionary *dictemp = [sender objectAtIndex:0];
				UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10,imageviewline.frame.origin.y+1, productview.frame.size.width/3-10, 38)];
				labelname.font = FONTN(15.0f);
				labelname.text = [dictemp objectForKey:@"ProcessName"]; ;
				labelname.textColor = COLORNOW(0, 0, 0);
				[productview addSubview:labelname];
				
				UILabel *labelnamevalue = [[UILabel alloc] initWithFrame:CGRectMake(productview.frame.size.width/3,imageviewline.frame.origin.y+1, productview.frame.size.width/3-10, 38)];
				labelnamevalue.font = FONTN(13.0f);
				labelnamevalue.numberOfLines = 2;
				labelnamevalue.text = [dictemp objectForKey:@"Department"];
				labelnamevalue.textColor = COLORNOW(0, 0, 0);
				[productview addSubview:labelnamevalue];
				
				UILabel *labelguigevalue = [[UILabel alloc] initWithFrame:CGRectMake(productview.frame.size.width/3*2,imageviewline.frame.origin.y+1, productview.frame.size.width/3-10, 38)];
				labelguigevalue.font = FONTN(13.0f);
				labelguigevalue.numberOfLines = 2;
				labelguigevalue.text = [dictemp objectForKey:@"ProcessDate"];
				labelguigevalue.textColor = COLORNOW(0, 0, 0);
				[productview addSubview:labelguigevalue];
			}
		}
		else if(i==3)
		{
			if([sender count]>1)
			{
				NSDictionary *dictemp = [sender objectAtIndex:1];
				UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10,imageviewline.frame.origin.y+1, productview.frame.size.width/3-10, 38)];
				labelname.font = FONTN(15.0f);
				labelname.text = [dictemp objectForKey:@"ProcessName"]; ;
				labelname.textColor = COLORNOW(0, 0, 0);
				[productview addSubview:labelname];
				
				UILabel *labelnamevalue = [[UILabel alloc] initWithFrame:CGRectMake(productview.frame.size.width/3,imageviewline.frame.origin.y+1, productview.frame.size.width/3-10, 38)];
				labelnamevalue.font = FONTN(13.0f);
				labelnamevalue.numberOfLines = 2;
				labelnamevalue.text = [dictemp objectForKey:@"Department"];
				labelnamevalue.textColor = COLORNOW(0, 0, 0);
				[productview addSubview:labelnamevalue];
				
				UILabel *labelguigevalue = [[UILabel alloc] initWithFrame:CGRectMake(productview.frame.size.width/3*2,imageviewline.frame.origin.y+1, productview.frame.size.width/3-10, 38)];
				labelguigevalue.font = FONTN(13.0f);
				labelguigevalue.numberOfLines = 2;
				labelguigevalue.text = [dictemp objectForKey:@"ProcessDate"];
				labelguigevalue.textColor = COLORNOW(0, 0, 0);
				[productview addSubview:labelguigevalue];
			}
		}
		else if(i==4)
		{
			if([sender count]>2)
			{
				NSDictionary *dictemp = [sender objectAtIndex:2];
				UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10,imageviewline.frame.origin.y+1, productview.frame.size.width/3-10, 38)];
				labelname.font = FONTN(15.0f);
				labelname.text = [dictemp objectForKey:@"ProcessName"]; ;
				labelname.textColor = COLORNOW(0, 0, 0);
				[productview addSubview:labelname];
				
				UILabel *labelnamevalue = [[UILabel alloc] initWithFrame:CGRectMake(productview.frame.size.width/3,imageviewline.frame.origin.y+1, productview.frame.size.width/3-10, 38)];
				labelnamevalue.font = FONTN(13.0f);
				labelnamevalue.numberOfLines = 2;
				labelnamevalue.text = [dictemp objectForKey:@"Department"];
				labelnamevalue.textColor = COLORNOW(0, 0, 0);
				[productview addSubview:labelnamevalue];
				
				UILabel *labelguigevalue = [[UILabel alloc] initWithFrame:CGRectMake(productview.frame.size.width/3*2,imageviewline.frame.origin.y+1, productview.frame.size.width/3-10, 38)];
				labelguigevalue.font = FONTN(13.0f);
				labelguigevalue.numberOfLines = 2;
				labelguigevalue.text = [dictemp objectForKey:@"ProcessDate"];
				labelguigevalue.textColor = COLORNOW(0, 0, 0);
				[productview addSubview:labelguigevalue];
			}
		}
		
	}
	
	return productview;
}

-(void)initview:(id)sender
{
	NSDictionary *productinfo  = [sender objectForKey:@"ProductInfo"];
	NSArray *Manufac = [sender objectForKey:@"ManufactureProcess"];
	scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
	scrollview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:scrollview];
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
	imageview.tag = 1500;
	imageview.contentMode = UIViewContentModeScaleAspectFill;
	imageview.clipsToBounds = YES;
	[scrollview addSubview:imageview];
	
	//	UIImageView *imageviewbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageview.frame.origin.y+imageview.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-64-100)];
	//	imageviewbg.image = LOADIMAGE(@"scanbg", @"png");
	//	imageviewbg.contentMode = UIViewContentModeScaleAspectFill;
	//	imageviewbg.clipsToBounds = YES;
	//	[scrollview addSubview:imageviewbg];
	
	webview = [[UIWebView alloc] initWithFrame:CGRectMake(10, 120, SCREEN_WIDTH-20, 260)];
	webview.delegate = self;
	webview.tag = 910;
	webview.opaque = NO;
	webview.backgroundColor = [UIColor clearColor];
	//	UIScrollView *tempView=(UIScrollView *)[webview.subviews objectAtIndex:0];
	//	tempView.scrollEnabled=NO;
	[scrollview addSubview:webview];
	
	view1 = [self viewproduct:productinfo Frame:CGRectMake(5, webview.frame.origin.y+webview.frame.size.height, SCREEN_WIDTH-10, 160)];
	[scrollview addSubview:view1];
	
	view2 = [self viewparame:Manufac Frame:CGRectMake(5, webview.frame.origin.y+webview.frame.size.height, SCREEN_WIDTH-10, 200)];
	[scrollview addSubview:view2];
	
	for (UIView *_aView in [webview subviews])
	{
		if ([_aView isKindOfClass:[UIScrollView class]])
		{
			[(UIScrollView *)_aView setShowsVerticalScrollIndicator:NO]; //右侧的滚动条
			
			for (UIView *_inScrollview in _aView.subviews)
			{
				
				if ([_inScrollview isKindOfClass:[UIImageView class]])
				{
					_inScrollview.hidden = YES;  //上下滚动出边界时的黑色的图片
				}
			}
		}
	}
	
//	UIImageView *imageviewbottom = [[UIImageView alloc] initWithFrame:CGRectMake(20, webview.frame.origin.y+webview.frame.size.height+10, SCREEN_WIDTH-40, 100)];
//	imageviewbottom.backgroundColor = COLORNOW(252, 254, 222);
//	[scrollview addSubview:imageviewbottom];
//	
//	UIImageView *imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake(imageviewbottom.frame.origin.x+10, imageviewbottom.frame.origin.y+15, 15, 15)];
//	imageviewicon.image = LOADIMAGE(@"alerticon", @"png");
//	[scrollview addSubview:imageviewicon];
//	
//	
//	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imageviewicon.frame.origin.x+imageviewicon.frame.size.width+10,imageviewbottom.frame.origin.y+10, imageviewbottom.frame.size.width-40, 60)];
//	labelname.font = FONTN(13.0f);
//	labelname.numberOfLines = 4;
//	labelname.tag = 401;
//	labelname.textColor = COLORNOW(121, 121, 121);
//	[scrollview addSubview:labelname];
	
}

-(void)inittixiandoneview:(NSDictionary *)dic
{
	self.view.backgroundColor = COLORNOW(27, 130, 210);
	
	UIImageView *imageviewbg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 74, SCREEN_WIDTH-20, SCREEN_HEIGHT-84)];
	imageviewbg.backgroundColor = [UIColor whiteColor];
	imageviewbg.layer.cornerRadius = 10.0f;
	imageviewbg.clipsToBounds = YES;
	[self.view addSubview:imageviewbg];
	
	//二维码之上
	UIImageView *imageviewxuxian1 = [[UIImageView alloc] initWithFrame:CGRectMake(imageviewbg.frame.origin.x, imageviewbg.frame.origin.y+40, imageviewbg.frame.size.width, 0.5)];
	imageviewxuxian1.image = LOADIMAGE(@"me_xuxian", @"png");
	[self.view addSubview:imageviewxuxian1];
	
	UIImageView *imageviewpoint1 = [[UIImageView alloc] initWithFrame:CGRectMake(imageviewxuxian1.frame.origin.x-5, imageviewxuxian1.frame.origin.y-5, 10, 10)];
	imageviewpoint1.layer.cornerRadius = 5.0f;
	imageviewpoint1.clipsToBounds = YES;
	imageviewpoint1.backgroundColor = COLORNOW(27, 130, 210);;
	[self.view addSubview:imageviewpoint1];
	
	UIImageView *imageviewpoint2 = [[UIImageView alloc] initWithFrame:CGRectMake(imageviewxuxian1.frame.origin.x+imageviewxuxian1.frame.size.width-5, imageviewxuxian1.frame.origin.y-5, 10, 10)];
	imageviewpoint2.backgroundColor = COLORNOW(27, 130, 210);
	imageviewpoint2.layer.cornerRadius = 5.0f;
	imageviewpoint2.clipsToBounds = YES;
	[self.view addSubview:imageviewpoint2];
	
	UIImageView *imageviewxuxian2 = [[UIImageView alloc] initWithFrame:CGRectMake(imageviewxuxian1.frame.origin.x, imageviewxuxian1.frame.origin.y+50, imageviewxuxian1.frame.size.width, 0.5)];
	imageviewxuxian2.image = LOADIMAGE(@"me_xuxian", @"png");
	[self.view addSubview:imageviewxuxian2];
	
	//数据
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(imageviewbg.frame.origin.x+10, imageviewbg.frame.origin.y+10, 190, 20)];
	labeltime.textColor = COLORNOW(72, 72, 72);
	labeltime.font = FONTN(14.0f);
	labeltime.text = [NSString stringWithFormat:@"有效期至:%@",[dic objectForKey:@"validexpiredtime"]];
	labeltime.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:labeltime];
	
	UILabel *labelstatus = [[UILabel alloc] initWithFrame:CGRectMake(imageviewbg.frame.origin.x+imageviewbg.frame.size.width-130, labeltime.frame.origin.y, 120, 20)];
	labelstatus.textColor = COLORNOW(72, 72, 72);
	labelstatus.font = FONTN(14.0f);
	labelstatus.text = [NSString stringWithFormat:@"状态:%@",[dic objectForKey:@"takemoneystatus"]];
	labelstatus.textAlignment = NSTextAlignmentRight;
	[self.view addSubview:labelstatus];
	
	UILabel *labelnumber = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-280)/2, imageviewpoint1.frame.origin.y+imageviewpoint1.frame.size.height+10, 280, 24)];
	labelnumber.textColor = COLORNOW(27, 130, 210);
	labelnumber.font = FONTN(22.0f);
	labelnumber.text = [dic objectForKey:@"takemoneycode"];
	labelnumber.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:labelnumber];
	
	
	UILabel *labeltixian = [[UILabel alloc] initWithFrame:CGRectMake(30, imageviewxuxian2.frame.origin.y+20, SCREEN_WIDTH-60, 20)];
	labeltixian.textColor = COLORNOW(72, 72, 72);
	labeltixian.font = FONTN(15.0f);
	labeltixian.text = @"提现金额";
	labeltixian.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:labeltixian];
	
	
	UILabel *labelmoney = [[UILabel alloc] initWithFrame:CGRectMake(labeltixian.frame.origin.x, labeltixian.frame.origin.y+labeltixian.frame.size.height+10, labeltixian.frame.size.width, 25)];
	labelmoney.textColor = COLORNOW(72, 72, 72);
	labelmoney.font = FONTN(25.0f);
	labelmoney.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"money"]];
	labelmoney.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:labelmoney];
	
	//下面两要线
	UIImageView *imageviewline1 = [[UIImageView alloc] initWithFrame:CGRectMake(imageviewxuxian1.frame.origin.x, labelmoney.frame.origin.y+labelmoney.frame.size.height+10, imageviewxuxian1.frame.size.width, 0.5)];
	imageviewline1.backgroundColor = COLORNOW(220, 220, 220);
	[self.view addSubview:imageviewline1];
	
	UIImageView *imageviewline2 = [[UIImageView alloc] initWithFrame:CGRectMake(imageviewline1.frame.origin.x, imageviewline1.frame.origin.y+imageviewline1.frame.size.height+40, imageviewxuxian1.frame.size.width, 0.5)];
	imageviewline2.backgroundColor = COLORNOW(220, 220, 220);
	[self.view addSubview:imageviewline2];
	
	NSString *strtixian = [NSString stringWithFormat:@"提现用户:%@",[dic objectForKey:@"username"]];
	
	UILabel *labeluser = [[UILabel alloc] initWithFrame:CGRectMake(imageviewbg.frame.origin.x+20, imageviewline1.frame.origin.y+10, imageviewbg.frame.size.width-40, 20)];
	labeluser.textColor = COLORNOW(72, 72, 72);
	labeluser.font = FONTN(14.0f);
	labeluser.textAlignment = NSTextAlignmentCenter;
	labeluser.text = [NSString stringWithFormat:@"%@",strtixian];
	[self.view addSubview:labeluser];

	UIButton *buttondone= [UIButton buttonWithType:UIButtonTypeCustom];
	buttondone.frame = CGRectMake(imageviewline2.frame.origin.x+15, imageviewline2.frame.origin.y+imageviewline2.frame.size.height+10, imageviewline2.frame.size.width-30, 40);
	buttondone.layer.cornerRadius = 3.0f;
	buttondone.clipsToBounds = YES;
	[buttondone setTitle:@"确定" forState:UIControlStateNormal];
	buttondone.backgroundColor = COLORNOW(27, 130, 210);
	[buttondone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	buttondone.titleLabel.font = FONTN(15.0f);
	[buttondone addTarget:self action:@selector(clickdone) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttondone];
	
}

- (void) scanButtonTapped
{    
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    
    reader.readerDelegate = self;
    
    //非全屏
    
    reader.wantsFullScreenLayout = NO;
    
    //隐藏底部控制按钮
    
    reader.showsZBarControls = NO;
    
    //设置自己定义的界面
    
    [self setOverlayPickerView:reader];
    
    ZBarImageScanner *scanner = reader.scanner;
    
    [scanner setSymbology: ZBAR_I25
     
                   config: ZBAR_CFG_ENABLE
     
                       to: 0];
    
    [self presentViewController:reader animated:YES completion:nil];
    
}

-(void) requestJXscan:(NSString *)comname Reader:(UIImagePickerController*)reader
{
	if([self.fromflag isEqualToString:@"1"])
	{
		[reader dismissViewControllerAnimated:YES completion:nil];
		if([self.delegate1 respondsToSelector:@selector(scancoderesult:)])
		{
			[self.delegate1 scancoderesult:comname];
		}
		[self returnback:nil];
	}
	else if([self.fromflag isEqualToString:@"2"])
	{
		if([comname rangeOfString:@"tbscrfl_"].location !=NSNotFound)
		{
			NSArray *arraycode = [comname componentsSeparatedByString:@"_"];
			
			if([[arraycode objectAtIndex:0] isEqualToString:@"tbscrfl"])
			{
				[self requesttixianqrcodeinfo:comname Reader:reader];
			}
		}
	}
	else
	{
		[reader dismissViewControllerAnimated:YES completion:nil];
		NSString *postUrl = URLHeader;
		AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		NSDictionary *parameters = @{@"ScanCode":comname,@"Longitude":[NSString stringWithFormat:@"%f",app.diliweizhi.longitude],@"Latitude":[NSString stringWithFormat:@"%f",app.diliweizhi.latitude],@"Address":app.diliweizhi.dilicity};
		
		
		
		[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA06000200" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
		 {
			 
		 }
											  Success:^(NSDictionary *responseObject)
		 {
			 DLog(@"dic====%@",responseObject);
			 NSDictionary *dictemp = [responseObject objectForKey:@"ProductInfo"];
			 if([dictemp count]>0)
			 {
				 dicdata = responseObject;
				 [self initview:dicdata];
				 
				 UIImageView *imageview = (UIImageView *)[scrollview viewWithTag:1500];
				 [webview loadHTMLString:[dictemp objectForKey:@"AdvertiseText"] baseURL:nil];
				 UILabel *label1 = (UILabel*)[scrollview viewWithTag:401];
				 
				 
				 NSURL *urlstr = [NSURL URLWithString:[URLPicHeader stringByAppendingString:[dictemp objectForKey:@"Picture"]]];
				 [imageview setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"scantopbg", @"png")];
				 label1.text = [dictemp objectForKey:@"ProductInfo"];
			 }
			 else
			 {
                 [MBProgressHUD showError:@"无该产品信息，请与厂家联系400-887-7980" toView:self.view];

				 [self returnback:nil];
			 }
		 }];
	}
}

-(void)clickdone
{
	[self requesttixiandone:dicscan Reader:nil];
}

//请求二维码信息

-(void) requesttixianqrcodeinfo:(NSString *)codeid Reader:(UIImagePickerController*)reader
{
	NSString *postUrl = URLHeader;
	
	NSDictionary *parameters = @{@"takemoneyflag":codeid};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA09000300" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 if([[responseObject objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 [reader dismissViewControllerAnimated:YES completion:nil];
			 dicscan = [responseObject objectForKey:@"data"];
			 [self inittixiandoneview:[responseObject objectForKey:@"data"]];
		 }
		 else
		 {
             [MBProgressHUD showError:[responseObject objectForKey:@"msg"] toView:self.view];

		 }
	 }];
	
}


//确认提现
-(void) requesttixiandone:(NSDictionary *)dic Reader:(UIImagePickerController*)reader
{
	NSString *postUrl = URLHeader;
	
	NSDictionary *parameters = @{@"takemoneycode":[dic objectForKey:@"takemoneycode"]};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA09000200" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 if([[responseObject objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 [self.navigationController popViewControllerAnimated:YES];
		 }
		 else
		 {
             [MBProgressHUD showError:[responseObject objectForKey:@"msg"] toView:self.view];

		 }
	 }];
	
}


- (void)webViewDidFinishLoad:(UIWebView *) webView
{
	//    [AddInterface addactivi];
	CGSize actualSize = [webView sizeThatFits:CGSizeZero];
	
	float height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
	
	CGRect newFrame = webView.frame;
	NSLog(@"height======%f,%f,%f",height,newFrame.size.height,actualSize.height);
	newFrame.size.height = height+25;
	webView.frame = newFrame;
	
	
	CGSize size =  newFrame.size;//[self returnsize:str Fontnow:app.userinfo.floatfont];
	float textHeight = size.height;
	size.height = textHeight+10;
	
	
	
	//	self.scrollview.frame = CGRectMake(self.scrollview.frame.origin.x,self.scrollview.frame.origin.y,self.scrollview.frame.size.width,size.height+300);
	view1.frame = CGRectMake(view1.frame.origin.x, webView.frame.origin.y+webView.frame.size.height, view1.frame.size.width, view1.frame.size.height);
	
	view2.frame = CGRectMake(view2.frame.origin.x, view1.frame.origin.y+view1.frame.size.height+10, view2.frame.size.width, view2.frame.size.height);
	scrollview.contentSize = CGSizeMake(SCREEN_WIDTH,size.height+500);
	
	//    [AddInterface removeactive];
	
	//    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(removeaction:) userInfo:nil repeats:NO];
	NSLog(@"dfaksdjfh;aksdf;laksdjfl;kasjdf;lkajsd;fkahslkdjfhakjshdgfkajsdhgfkasjdflakjsdhflkajsdhflkjasdf");
}


- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
	
    id<NSFastEnumeration> results =
	[info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
	
    // EXAMPLE: do something useful with the barcode data
    resultText = symbol.data;
//	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//	JQIndicatorView *indicator = [[JQIndicatorView alloc] initWithType:JQIndicatorTypeBounceSpot1 tintColor:COLORNOW(200, 200, 200)];
//	indicator.center = app.window.center;
//	indicator.tag = IndicatorTag;
//	[app.window addSubview:indicator];
//	[indicator startAnimating];
    // EXAMPLE: do something useful with the barcode image
    //    resultImage.image =
    //	[info objectForKey: UIImagePickerControllerOriginalImage];
	
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
	
	
	[self requestJXscan:resultText Reader:reader];
}

- (void)setOverlayPickerView:(ZBarReaderViewController *)reader
{
    //清除原有控件
//    reader
    
    for (UIView *temp in [reader.view subviews]) {
        
        for (UIButton *button in [temp subviews]) {
            
            if ([button isKindOfClass:[UIButton class]]) {
                
                [button removeFromSuperview];
                
            }
            
        }
        
        for (UIToolbar *toolbar in [temp subviews]) {
            
            if ([toolbar isKindOfClass:[UIToolbar class]]) {
                
                [toolbar setHidden:YES];
                
                [toolbar removeFromSuperview];
                
            }
            
        }
        
    }
    
//    //画中间的基准线
//    
//    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(40, 220, 240, 1)];
//    
//    line.backgroundColor = [UIColor redColor];
//    
//    [reader.view addSubview:line];
	
    //最上部view
    
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    
    upView.alpha = 0.3;
    
    upView.backgroundColor = [UIColor blackColor];
    
    [reader.view addSubview:upView];
    
    //用于说明的label
    UIImageView *imageviewbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    imageviewbg.image = [UIImage imageNamed:@"top.png"];
    [reader.view addSubview:imageviewbg];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setFrame:CGRectMake(11, 22, 40, 40)];
    if(iphone5)
        [returnButton setFrame:CGRectMake(11, 22, 40, 40)];
    UIImage *imagereturn = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"returnback" ofType:@"png"]];
    [returnButton setBackgroundImage:imagereturn forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(dismissOverlayView:)forControlEvents:UIControlEventTouchUpInside];
    [reader.view addSubview:returnButton];
    
    UILabel * labIntroudction= [[UILabel alloc] init];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.frame=CGRectMake(80, 22, 160, 40);
    if(iphone5)
        labIntroudction.frame=CGRectMake(80, 22, 160, 40);
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"二维码扫描";
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.font = [UIFont fontWithName:@"STHeitiTC-Medium" size:24.0f];
    [reader.view addSubview:labIntroudction];
    
    //左侧的view
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, 15, SCREEN_HEIGHT-40)];
    
    leftView.alpha = 0.3;
    
    leftView.backgroundColor = [UIColor blackColor];
    
    [reader.view addSubview:leftView];

    
    //右侧的view
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15, 80, 15, SCREEN_HEIGHT-40)];
    
    rightView.alpha = 0.3;
    
    rightView.backgroundColor = [UIColor blackColor];
    
    [reader.view addSubview:rightView];
    
    
    //底部view
    
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-120, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
    
    downView.alpha = 0.3;
    
    downView.backgroundColor = [UIColor blackColor];
    
    [reader.view addSubview:downView];

    //用于取消操作的button
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setFrame:CGRectMake(15, 390, 290, 41)];
    UIImage *imagecannel = [UIImage imageNamed:@"QRcancel.png"];
    [cancelButton setBackgroundImage:imagecannel forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(dismissOverlayView:)forControlEvents:UIControlEventTouchUpInside];  
    [reader.view addSubview:cancelButton];  
    
}

- (void)dismissOverlayView:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self returnback:nil];
}

-(NSString *)fliternetaddress:(NSString *)source
{
	NSLog(@"source====%@",source);
	
	char oldnetaddress[1024];
	char netaddress[1024];
	char *newaddress;
	strcpy(oldnetaddress,[source UTF8String]);
	newaddress = strstr(oldnetaddress,"http://");
    if(newaddress == nil)
        newaddress = strstr(oldnetaddress,"https://");
    if(newaddress == nil)
        return nil;
	memset(netaddress,'\0',1024);
	int i = 0;
	int aa = strlen(newaddress);
	if(newaddress != NULL)
	{
		while((*newaddress != ';')&&(i<aa))
		{
			netaddress[i] = *newaddress;
			newaddress++;
			i++;
		}
		return ([NSString stringWithUTF8String:netaddress]);
	}
	return nil;
}

-(int)fliterintaddress:(NSString *)source
{
	NSLog(@"source====%@",source);
	
	char oldnetaddress[1024];
	char *newaddress;
	strcpy(oldnetaddress,[source UTF8String]);
	newaddress = strstr(oldnetaddress,"http://");
	if(newaddress != NULL)
	{
		int aa = strlen(newaddress);
		return aa;
	}
	return 0;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
