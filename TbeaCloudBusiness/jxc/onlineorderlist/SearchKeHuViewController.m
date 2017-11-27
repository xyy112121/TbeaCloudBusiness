//
//  SearchKeHuViewController.m
//  TeBian
//
//  Created by xyy520 on 16/1/25.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "SearchKeHuViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
#import "KeHuLiseResultViewController.h"
@interface SearchKeHuViewController ()

@end

@implementation SearchKeHuViewController

@synthesize delegate1;


-(void)returnback:(id)sender
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	JQIndicatorView *indicator = [app.window viewWithTag:IndicatorTag];
	[indicator stopAnimating];
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)addreturnflag:(int)iflag
{
	if(iflag == 1)
		returnflag = 1;
}

-(void)viewWillAppear:(BOOL)animated
{
	if(returnflag == 1)
		[self returnback:nil];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	
    self.view.backgroundColor = [UIColor whiteColor];
    
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"查找客户";
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
	returnflag = 0;
	// Do any additional setup after loading the view.
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	scrollview.contentSize = CGSizeMake(SCREEN_WIDTH,800);
	
	
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	scrollview.contentSize = CGSizeMake(SCREEN_WIDTH,400);
	return YES;
}

-(void)clickdone:(id)sender
{
	UITextField *textfield1 = [scrollview viewWithTag:621];
	UITextField *textfield2 = [scrollview viewWithTag:622];
	[textfield1 resignFirstResponder];
	[textfield2 resignFirstResponder];
	if(([textfield1.text length]==0)&&([textfield2.text length]==0))
	{
        [MBProgressHUD showError:@"编码,描述,名称不能同时为空!" toView:self.view];

	}
	else
	{
        KeHuLiseResultViewController *kehulist = [[KeHuLiseResultViewController alloc] init];
		kehulist.strpcode = [textfield1.text length]>0?textfield1.text:@"";
		kehulist.strpname = [textfield2.text length]>0?textfield2.text:@"";
		kehulist.delegate1 = self.delegate1;
		kehulist.delegate2 = self;
		[self.navigationController pushViewController:kehulist animated:YES];
	}
}

-(void)initview:(id)sender
{
	scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
	scrollview.backgroundColor = [UIColor clearColor];
	scrollview.showsHorizontalScrollIndicator = NO;
	scrollview.showsVerticalScrollIndicator = NO;
	[self.view addSubview:scrollview];
	
	UILabel *labelwuliao = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 50, 20)];
	labelwuliao.font = FONTN(12.0f);
	labelwuliao.text = @"编      码";
	labelwuliao.textColor = COLORNOW(51, 51, 51);
	[scrollview addSubview:labelwuliao];
	
	UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(labelwuliao.frame.origin.x+labelwuliao.frame.size.width+10, 15, SCREEN_WIDTH-90, 30)];
	textfield.layer.cornerRadius = 3;
	textfield.layer.borderColor = COLORNOW(230, 230, 230).CGColor;
	textfield.layer.borderWidth = 0.5f;
	textfield.backgroundColor = [UIColor whiteColor];
	textfield.tag = 621;
	textfield.delegate = self;
	textfield.placeholder = @"填入编码(可选)";
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
	labelnum.text = @"名      称";
	labelnum.textColor = COLORNOW(51, 51, 51);
	[scrollview addSubview:labelnum];
	
	UITextField *textfieldnum = [[UITextField alloc] initWithFrame:CGRectMake(labelnum.frame.origin.x+labelnum.frame.size.width+10, labelnum.frame.origin.y-5, SCREEN_WIDTH-90, 30)];
	textfieldnum.layer.cornerRadius = 3;
	textfieldnum.layer.borderColor = COLORNOW(230, 230, 230).CGColor;
	textfieldnum.layer.borderWidth = 0.5f;
	textfieldnum.backgroundColor = [UIColor whiteColor];
	textfieldnum.tag = 622;
	textfieldnum.delegate = self;
	textfieldnum.placeholder = @"填写名称(可选)";
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
