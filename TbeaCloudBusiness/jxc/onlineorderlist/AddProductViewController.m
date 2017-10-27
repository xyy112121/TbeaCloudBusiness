//
//  AddProductViewController.m
//  TeBian
//
//  Created by xyy520 on 15/12/24.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import "AddProductViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
#import "SearchWuLiaoViewController.h"
@interface AddProductViewController ()

@end

@implementation AddProductViewController
@synthesize delegate1;
@synthesize strorderid;

-(void)returnback:(id)sender
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	JQIndicatorView *indicator = [app.window viewWithTag:IndicatorTag];
	[indicator stopAnimating];
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
    self.view.backgroundColor = [UIColor whiteColor];
    
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"添加产品";
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	[button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
	button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
	[button addTarget:self action: @selector(returnback:) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	
	UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
	UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
	[buttonright setImage:LOADIMAGE(@"Confirm", @"png") forState:UIControlStateNormal];
	buttonright.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
	[buttonright addTarget:self action: @selector(clickdone:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewright addSubview:buttonright];
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
	
	[self initview:nil];
    // Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	scrollview.contentSize = CGSizeMake(SCREEN_WIDTH,800);
	if(textField.tag == 621)
	{
		[textField resignFirstResponder];
		
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SearchWuLiaoViewController *searchwuliao = [[SearchWuLiaoViewController alloc] init];
		searchwuliao.delegate1 = self;
		[self.navigationController pushViewController:searchwuliao animated:YES];
		return NO;
	}
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	scrollview.contentSize = CGSizeMake(SCREEN_WIDTH,400);
	return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

-(void)updateselectwuliao:(NSDictionary *)wuliao
{
	dicwuliao = wuliao;
	UITextField *textfield = (UITextField *)[self.view viewWithTag:621];
	textfield.text = [dicwuliao objectForKey:@"ProductName"];
}



-(void)clickdone:(id)sender
{
	[self returnkeyboard:nil];
	UITextField *textfield1 = (UITextField *)[scrollview viewWithTag:621];
	UITextField *textfield2 = (UITextField *)[scrollview viewWithTag:622];
	UITextField *textfield3 = (UITextField *)[scrollview viewWithTag:623];
	UITextField *textfield4 = (UITextField *)[scrollview viewWithTag:624];
	UITextView *textview5 = (UITextView *)[scrollview viewWithTag:625];
	
	if(([textfield1.text length]==0)||([textfield2.text length]==0)||([textfield3.text length]==0))
	{
        [MBProgressHUD showError:@"物料，单价，数量 必须要填写" toView:self.view];

	}
	else if(![AddInterface isPureInt:textfield2.text])
	{
        [MBProgressHUD showError:@"数量填写格式不正确" toView:self.view];

	}
	else if(![AddInterface isPureFloat:textfield3.text])
	{
        [MBProgressHUD showError:@"数量填写格式不正确" toView:self.view];

	}
	else if(![AddInterface isPureFloat:textfield4.text])
	{
        [MBProgressHUD showError:@"浮动比例填写格式不正确" toView:self.view];

	}
	else
	{
		NSString *sfloat = [textfield4.text length]>0?textfield4.text:@"";
		NSString *snote = [textview5.text length]>0?textview5.text:@"";
		[self requestaddproduct:[dicwuliao objectForKey:@"ProductId"] Count:textfield2.text Floadr:sfloat Price:textfield3.text Note:snote orderid:self.strorderid];
	}
	
}

-(void) requestaddproduct:(NSString *)pcode Count:(NSString *)count Floadr:(NSString *)floatr Price:(NSString *)price Note:(NSString *)note orderid:(NSString *)orderid
{
	NSDictionary *parameters =  @{@"OrderId":orderid,@"ProductCode":pcode,@"Count":count,@"FloatRatio":floatr,@"Price":price,@"Note":note};
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA07030600" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 if([[responseObject objectForKey:@"RspCode"] isEqualToString:@"RC00000"])
		 {
			 if([delegate1 respondsToSelector:@selector(addproductsuccess:)])
			 {
				 [delegate1 addproductsuccess:[responseObject objectForKey:@"OrderId"]];
			 }
			 [self returnback:nil];
		 }
		 
         [MBProgressHUD showError:[responseObject objectForKey:@"RspDesc"] toView:self.view];

	 }];
	
}

-(void)returnkeyboard:(id)sender
{
	UITextField *textfield1 = (UITextField *)[scrollview viewWithTag:621];
	UITextField *textfield2 = (UITextField *)[scrollview viewWithTag:622];
	UITextField *textfield3 = (UITextField *)[scrollview viewWithTag:623];
	UITextField *textfield4 = (UITextField *)[scrollview viewWithTag:624];
	UITextField *textfield5 = (UITextField *)[scrollview viewWithTag:625];
	[textfield1 resignFirstResponder];
	[textfield2 resignFirstResponder];
	[textfield3 resignFirstResponder];
	[textfield4 resignFirstResponder];
	[textfield5 resignFirstResponder];
}

-(void)initview:(id)sender
{
	scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
	scrollview.backgroundColor = [UIColor clearColor];
	scrollview.showsHorizontalScrollIndicator = NO;
	scrollview.showsVerticalScrollIndicator = NO;
	[self.view addSubview:scrollview];
	
	UILabel *labelwuliao = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 50, 20)];
	labelwuliao.font = FONTN(12.0f);
	labelwuliao.text = @"物      料";
	labelwuliao.textColor = COLORNOW(51, 51, 51);
	[scrollview addSubview:labelwuliao];
	
	UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(labelwuliao.frame.origin.x+labelwuliao.frame.size.width+10, 15, SCREEN_WIDTH-90, 30)];
	textfield.layer.cornerRadius = 3;
	textfield.layer.borderColor = COLORNOW(230, 230, 230).CGColor;
	textfield.layer.borderWidth = 0.5f;
	textfield.backgroundColor = [UIColor whiteColor];
	textfield.tag = 621;
	textfield.delegate = self;
	textfield.placeholder = @"选择物料";
	textfield.font = FONTN(13.0f);
	textfield.returnKeyType = UIReturnKeyDone;
	textfield.clearButtonMode = UITextFieldViewModeAlways;
	UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
	textfield.leftView = leftview;
	leftview.userInteractionEnabled = NO;
	textfield.leftViewMode = UITextFieldViewModeAlways;
	[scrollview addSubview:textfield];
	
	UIImageView *imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, textfield.frame.origin.y+textfield.frame.size.height+10, SCREEN_WIDTH, 0.5)];
	imageline1.backgroundColor = COLORNOW(240, 240, 240);
	[scrollview addSubview:imageline1];
	
	UILabel *labelnum = [[UILabel alloc] initWithFrame:CGRectMake(20, imageline1.frame.origin.y+20, 50, 20)];
	labelnum.font = FONTN(12.0f);
	labelnum.text = @"数      量";
	labelnum.textColor = COLORNOW(51, 51, 51);
	[scrollview addSubview:labelnum];
	
	UITextField *textfieldnum = [[UITextField alloc] initWithFrame:CGRectMake(labelnum.frame.origin.x+labelnum.frame.size.width+10, labelnum.frame.origin.y-5, SCREEN_WIDTH-90, 30)];
	textfieldnum.layer.cornerRadius = 3;
	textfieldnum.layer.borderColor = COLORNOW(230, 230, 230).CGColor;
	textfieldnum.layer.borderWidth = 0.5f;
	textfieldnum.backgroundColor = [UIColor whiteColor];
	textfieldnum.tag = 622;
	textfieldnum.delegate = self;
	textfieldnum.placeholder = @"填写数量";
	textfieldnum.font = FONTN(13.0f);
	textfieldnum.returnKeyType = UIReturnKeyDone;
	textfieldnum.clearButtonMode = UITextFieldViewModeAlways;
	UIView *leftviewnum = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
	textfieldnum.leftView = leftviewnum;
	leftview.userInteractionEnabled = NO;
	textfieldnum.leftViewMode = UITextFieldViewModeAlways;
	[scrollview addSubview:textfieldnum];
	
	UIImageView *imageline2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, textfieldnum.frame.origin.y+textfieldnum.frame.size.height+10, SCREEN_WIDTH, 0.5)];
	imageline2.backgroundColor = COLORNOW(240, 240, 240);
	[scrollview addSubview:imageline2];
	
	UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(20, imageline2.frame.origin.y+20, 50, 20)];
	labelprice.font = FONTN(12.0f);
	labelprice.text = @"单      价";
	labelprice.textColor = COLORNOW(51, 51, 51);
	[scrollview addSubview:labelprice];
	
	UITextField *textfieldprice = [[UITextField alloc] initWithFrame:CGRectMake(labelprice.frame.origin.x+labelprice.frame.size.width+10, labelprice.frame.origin.y-5, SCREEN_WIDTH-90, 30)];
	textfieldprice.layer.cornerRadius = 3;
	textfieldprice.layer.borderColor = COLORNOW(230, 230, 230).CGColor;
	textfieldprice.layer.borderWidth = 0.5f;
	textfieldprice.backgroundColor = [UIColor whiteColor];
	textfieldprice.tag = 623;
	textfieldprice.delegate = self;
	textfieldprice.placeholder = @"填写价格";
	textfieldprice.font = FONTN(13.0f);
	textfieldprice.returnKeyType = UIReturnKeyDone;
	textfieldprice.clearButtonMode = UITextFieldViewModeAlways;
	UIView *leftviewprice = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
	textfieldprice.leftView = leftviewprice;
	leftviewprice.userInteractionEnabled = NO;
	textfieldprice.leftViewMode = UITextFieldViewModeAlways;
	[scrollview addSubview:textfieldprice];
	
	UIImageView *imageline3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, textfieldprice.frame.origin.y+textfieldprice.frame.size.height+10, SCREEN_WIDTH, 0.5)];
	imageline3.backgroundColor = COLORNOW(240, 240, 240);
	[scrollview addSubview:imageline3];
	
	UILabel *labelproportion = [[UILabel alloc] initWithFrame:CGRectMake(20, imageline3.frame.origin.y+20, 50, 20)];
	labelproportion.font = FONTN(12.0f);
	labelproportion.text = @"浮动比例";
	labelproportion.textColor = COLORNOW(51, 51, 51);
	[scrollview addSubview:labelproportion];
	
	UITextField *textfieldproportion = [[UITextField alloc] initWithFrame:CGRectMake(labelproportion.frame.origin.x+labelproportion.frame.size.width+10, labelproportion.frame.origin.y-5, SCREEN_WIDTH-90, 30)];
	textfieldproportion.layer.cornerRadius = 3;
	textfieldproportion.layer.borderColor = COLORNOW(230, 230, 230).CGColor;
	textfieldproportion.layer.borderWidth = 0.5f;
	textfieldproportion.backgroundColor = [UIColor whiteColor];
	textfieldproportion.tag = 624;
	textfieldproportion.delegate = self;
	textfieldproportion.placeholder = @"填写浮动比例";
	textfieldproportion.font = FONTN(13.0f);
	textfieldproportion.returnKeyType = UIReturnKeyDone;
	textfieldproportion.clearButtonMode = UITextFieldViewModeAlways;
	UIView *leftviewproportion = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
	textfieldproportion.leftView = leftviewproportion;
	leftviewproportion.userInteractionEnabled = NO;
	textfieldproportion.leftViewMode = UITextFieldViewModeAlways;
	[scrollview addSubview:textfieldproportion];
	
	UIImageView *imageline4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, textfieldproportion.frame.origin.y+textfieldproportion.frame.size.height+10, SCREEN_WIDTH, 0.5)];
	imageline4.backgroundColor = COLORNOW(240, 240, 240);
	[scrollview addSubview:imageline4];
	
	UILabel *labelremark = [[UILabel alloc] initWithFrame:CGRectMake(20, imageline4.frame.origin.y+20, 50, 20)];
	labelremark.font = FONTN(12.0f);
	labelremark.text = @"备      注";
	labelremark.textColor = COLORNOW(51, 51, 51);
	[scrollview addSubview:labelremark];
	
	UITextView *textviewremark = [[UITextView alloc] initWithFrame:CGRectMake(labelremark.frame.origin.x+labelremark.frame.size.width+10, labelremark.frame.origin.y-5, SCREEN_WIDTH-90, 60)];
	textviewremark.layer.borderWidth =1.0;
	textviewremark.layer.borderColor = COLORNOW(230, 230, 230).CGColor;
	textviewremark.layer.cornerRadius = 2;
	textviewremark.tag = 625;
	[scrollview addSubview:textviewremark];
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
