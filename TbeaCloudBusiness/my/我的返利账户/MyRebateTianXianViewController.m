//
//  MyRebateTianXianViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/16.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyRebateTianXianViewController.h"

@interface MyRebateTianXianViewController ()

@end

@implementation MyRebateTianXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = COLORNOW(240, 240, 240);
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self getmytixianinfo];
    
    UIImage* img=LOADIMAGE(@"returnback", @"png");
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    [button setImage:img forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    // Do any additional setup after loading the view.
}

-(void)initview:(NSDictionary *)dicsrc
{
    NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.title = @"提现";
    
    NSDictionary *dic = [dicsrc objectForKey:@"mymoneyinfo"];
    NSDictionary *dicdistributor = [dicsrc objectForKey:@"firstdistributorinfo"];
    
    UIImageView *imageviewbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 115)];
    imageviewbg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageviewbg];
    
    UIImageView *imageviewunder = [[UIImageView alloc] initWithFrame:CGRectMake(0, XYViewBottom(imageviewbg)+10, SCREEN_WIDTH, 600)];
    imageviewunder.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageviewunder];
    
    UILabel *labeltixian = [[UILabel alloc] initWithFrame:CGRectMake(imageviewbg.frame.origin.x+20, imageviewbg.frame.origin.y+10, 100, 20)];
    labeltixian.textColor = ColorBlackdeep;
    labeltixian.font = FONTN(15.0f);
    labeltixian.text = @"提现金额";
    [self.view addSubview:labeltixian];
    
    
    UILabel *labelmoney = [[UILabel alloc] initWithFrame:CGRectMake(labeltixian.frame.origin.x, labeltixian.frame.origin.y+labeltixian.frame.size.height+12, 10, 10)];
    labelmoney.textColor = ColorBlackdeep;
    labelmoney.font = FONTMEDIUM(12.0f);
    labelmoney.text = @"￥";
    [self.view addSubview:labelmoney];
    
    UITextField *textfieldmoney = [[UITextField alloc] init];
    textfieldmoney.frame = CGRectMake(labelmoney.frame.origin.x+labelmoney.frame.size.width+5, labeltixian.frame.origin.y+labeltixian.frame.size.height+9, 200, 20);
    textfieldmoney.backgroundColor = [UIColor clearColor];
    textfieldmoney.placeholder = @"提现金额请填写整数";
    textfieldmoney.font = FONTMEDIUM(18.0f);
    textfieldmoney.textColor = ColorBlackdeep;
    textfieldmoney.tag = EnMeTiXianMoneyTextFieldTag;
    [self.view addSubview:textfieldmoney];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(imageviewbg.frame.origin.x, labelmoney.origin.y+labelmoney.frame.size.height+15, imageviewbg.frame.size.width, 0.5)];
    imageline.backgroundColor = Colorgray;
    [self.view addSubview:imageline];
    
    UILabel *labelins = [[UILabel alloc] initWithFrame:CGRectMake(labeltixian.frame.origin.x, imageline.frame.origin.y+10, 255, 20)];
    labelins.textColor = ColorBlackGray;
    labelins.backgroundColor = [UIColor clearColor];
    labelins.font = FONTN(13.0f);
    labelins.text = [NSString stringWithFormat:@"当前可提现金额￥%@",[dic objectForKey:@"currentmoney"]];
    [self.view addSubview:labelins];
    
    
    UIButton *btall = [UIButton buttonWithType:UIButtonTypeCustom];
    btall.frame = CGRectMake(labelins.frame.origin.x+labelins.frame.size.width-100,labelins.frame.origin.y-5, 60, 30);
    [btall setTitle:@"全部提现" forState:UIControlStateNormal];
    [btall setTitleColor:ColorBlue forState:UIControlStateNormal];
    btall.titleLabel.font = FONTN(14.0f);
    [btall addTarget:self action:@selector(tixianall:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btall];
    
    UIButton *btqrcode = [UIButton buttonWithType:UIButtonTypeCustom];
    btqrcode.frame = CGRectMake(20,imageviewbg.frame.origin.y+imageviewbg.frame.size.height+20, SCREEN_WIDTH-40, 40);
    btqrcode.backgroundColor = COLORNOW(27, 130, 210);
    [btqrcode setTitle:@"提现" forState:UIControlStateNormal];
    [btqrcode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btqrcode.titleLabel.font = FONTN(15.0f);
    [btqrcode addTarget:self action:@selector(createqrcode:) forControlEvents:UIControlEventTouchUpInside];
    btqrcode.layer.cornerRadius= 2.0f;
    btqrcode.clipsToBounds = YES;
    [self.view addSubview:btqrcode];
    
    UILabel *labelbottomins = [[UILabel alloc] initWithFrame:CGRectMake(btqrcode.frame.origin.x, btqrcode.frame.origin.y+btqrcode.frame.size.height+10, btqrcode.frame.size.width, 55)];
    labelbottomins.textColor = ColorBlackGray;
    labelbottomins.font = FONTN(13.0f);
    labelbottomins.numberOfLines = 3;
    labelbottomins.text = @"确认提现后，系统将生成一个提现二维码，请将此二维码给您注册所在区域内的任意授权经销商扫码确认后，您将换取相应的现金。";
    [self.view addSubview:labelbottomins];
    
    UIImageView *imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, XYViewBottom(labelbottomins)+10, SCREEN_WIDTH, 0.7)];
    imageline1.backgroundColor = COLORNOW(220, 220, 220);
    [self.view addSubview:imageline1];
    
    [self firstdistributorview:dicdistributor Frame:CGRectMake(0, XYViewBottom(imageline1), SCREEN_WIDTH, 60)];
}

-(void)firstdistributorview:(NSDictionary *)dic Frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 80, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = [UIColor blackColor];
    labelname.font = FONTN(15.0f);
    labelname.text = @"总经销商";
    [view addSubview:labelname];
    
    UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, 40, 40)];
    [imageheader setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"thumbpicture"]] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
    imageheader.layer.cornerRadius = 15.0f;
    imageheader.clipsToBounds = YES;
    imageheader.contentMode = UIViewContentModeScaleAspectFill;
    [view addSubview:imageheader];
    
    CGSize sizeuser = [AddInterface getlablesize:[dic objectForKey:@"personname"] Fwidth:100 Fheight:20 Sfont:FONTN(15.0f)];
    UILabel *labelusername = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, 10, sizeuser.width, 20)];
    labelusername.backgroundColor = [UIColor clearColor];
    labelusername.textColor = [UIColor blackColor];
    labelusername.font = FONTN(15.0f);
    labelusername.text = [dic objectForKey:@"personname"];
    [view addSubview:labelusername];
    
    
    UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labelusername)+5, XYViewTop(labelusername)+5, 28, 10)];
    [imageicon setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"persontypeicon"]]];
    [view addSubview:imageicon];
    
    
    UILabel *labeldes = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelusername), XYViewBottom(labelusername), 180, 20)];
    labeldes.backgroundColor = [UIColor clearColor];
    labeldes.textColor =COLORNOW(117, 117, 117);
    labeldes.font = FONTN(15.0f);
    labeldes.text = [dic objectForKey:@"companyname"];
    [view addSubview:labeldes];
    
    UIButton *buttonnext = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonnext.frame = CGRectMake(0, 0, SCREEN_WIDTH-30, 60);
    [buttonnext setImage:LOADIMAGE(@"userarrowgray", @"png") forState:UIControlStateNormal];
    [buttonnext addTarget:self action:@selector(gotonext:) forControlEvents:UIControlEventTouchUpInside];
    buttonnext.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [view addSubview:buttonnext];
}

#pragma mark IBaction
-(void)gotonext:(id)sender
{
    
}

-(void)tixianall:(id)sender
{
    UITextField *textfield = [self.view viewWithTag:EnMeTiXianMoneyTextFieldTag];
    textfield.text = [NSString stringWithFormat:@"%@",[[dicmymoney objectForKey:@"mymoneyinfo"] objectForKey:@"canexchangemoney"]];
}

-(void)createqrcode:(id)sender
{
    UITextField *textfield = [self.view viewWithTag:EnMeTiXianMoneyTextFieldTag];
    [textfield resignFirstResponder];
    if([textfield.text length]==0)
    {
        [MBProgressHUD showError:@"请填写要提现的金额" toView:app.window];
    }
    else if(![AddInterface isValidatenumber:textfield.text])
    {
        [MBProgressHUD showError:@"只能输入数字" toView:app.window];
    }
    else
    {
        float nowmoney = [[[dicmymoney objectForKey:@"mymoneyinfo"] objectForKey:@"canexchangemoney"] floatValue];
        float inputmoney = [textfield.text floatValue];
        
        if(nowmoney<inputmoney)
        {
            [MBProgressHUD showError:@"你填写的提现金额不能超过可以提现的金额！" toView:app.window];
        }
        else if(inputmoney>0)
        {
            MyTiXianQRCodeViewController *tixiancode = [[MyTiXianQRCodeViewController alloc] init];
            tixiancode.tixianmoney = textfield.text;
            tixiancode.strdistribuid = selectdistribuid;
            [self.navigationController pushViewController:tixiancode animated:YES];
            
        }
        else
        {
            [MBProgressHUD showError:@"你填写的提现金额必须大于0！" toView:app.window];
        }
    }
    
}

-(void)returnback
{
   
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 接口
-(void)getmytixianinfo
{
    NSDictionary *params = nil;//@{@"takemoneycode":@"08381145920000775299"};
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQMyTiXianMoneyManyInfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            if([[dic objectForKey:@"success"] isEqualToString:@"true"])
            {
                dicmymoney = [dic objectForKey:@"data"];
                selectdistribuid = [[dicmymoney objectForKey:@"firstdistributorinfo"] objectForKey:@"id"];
                [self initview:dicmymoney];

            }
            else
            {
                [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
            }
            
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
