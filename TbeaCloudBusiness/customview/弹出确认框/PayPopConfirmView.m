//
//  PayPopConfirmView.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/11.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "PayPopConfirmView.h"

@implementation PayPopConfirmView

-(instancetype)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom
{
    self =[super initWithFrame:frame];
    if (self) {
        //设置模板层背景色
        self.backgroundColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:0.7];
        [self initview:dicfrom];
        
    }
    return self;
}

-(void)initview:(NSDictionary *)dic
{
    UIButton *clearbt  =[UIButton buttonWithType:UIButtonTypeCustom];
    [clearbt addTarget:self action:@selector(btnClickremove:) forControlEvents:UIControlEventTouchUpInside];
    clearbt.backgroundColor=[UIColor clearColor];
    clearbt.frame = CGRectMake(0,0,XYViewWidth(self),XYViewHeight(self));
    [self addSubview:clearbt];
    
    UIView *tipebackView =[[UIView alloc]initWithFrame:CGRectMake(30, self.frame.size.height/2-90-StatusBarAndNavigationHeight, self.frame.size.width-60, 180)];
    tipebackView.backgroundColor=[UIColor whiteColor];
    tipebackView.layer.cornerRadius=5;
    [self addSubview:tipebackView];
    
    UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
    imageicon.image = [UIImage imageNamed:@"useralert.png"];
    imageicon.backgroundColor = [UIColor clearColor];
    [tipebackView addSubview:imageicon];
    
    
    UILabel *tipeLabeltitle =[[UILabel alloc]initWithFrame:CGRectMake(imageicon.frame.origin.x+imageicon.frame.size.width+5, 10, tipebackView.frame.size.width-40, 20)];
    tipeLabeltitle.textColor = [UIColor blackColor];
    tipeLabeltitle.text = @"确认提示";
    tipeLabeltitle.font =  FONTMEDIUM(15.0f);
    [tipebackView addSubview:tipeLabeltitle];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(20, 40, tipebackView.frame.size.width-40, 0.7)];
    imageline.backgroundColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1];
    [tipebackView addSubview:imageline];
    
    UILabel *tipeuser =[[UILabel alloc]initWithFrame:CGRectMake(XYViewL(imageicon), XYViewBottom(imageline)+10, 70, 20)];
    tipeuser.textColor = [UIColor blackColor];
    tipeuser.text = @"支付用户:";
    tipeuser.font =  FONTN(15.0f);
    [tipebackView addSubview:tipeuser];
    
    UILabel *tipeuservalue =[[UILabel alloc]initWithFrame:CGRectMake(XYViewR(tipeuser), XYViewTop(tipeuser), 150, 20)];
    tipeuservalue.textColor = [UIColor blackColor];
    tipeuservalue.text = [dic objectForKey:@"personname"];
    tipeuservalue.font =  FONTN(15.0f);
    [tipebackView addSubview:tipeuservalue];
    
    UILabel *tipemoney =[[UILabel alloc]initWithFrame:CGRectMake(XYViewL(imageicon), XYViewBottom(tipeuser)+3, 70, 20)];
    tipemoney.textColor = [UIColor blackColor];
    tipemoney.text = @"支付金额:";
    tipemoney.font =  FONTN(15.0f);
    [tipebackView addSubview:tipemoney];
    
    UILabel *tipemoneyvalue =[[UILabel alloc]initWithFrame:CGRectMake(XYViewR(tipemoney), XYViewTop(tipemoney), 200, 20)];
    tipemoneyvalue.textColor = [UIColor blackColor];
    tipemoneyvalue.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"money"]];
    tipemoneyvalue.font =  FONTN(15.0f);
    [tipebackView addSubview:tipemoneyvalue];
    
    UIButton *sureBtn  =[UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.tag=EnPayPopConfirmViewBtTag;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font =[UIFont systemFontOfSize:16 weight:0.5];
    sureBtn.layer.cornerRadius = 3.0f;
    sureBtn.clipsToBounds = YES;
    [sureBtn addTarget:self action:@selector(btnClickSelector:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.backgroundColor=[UIColor colorWithRed:254/255.0 green:72/255.0 blue:68/255.0 alpha:1.0];
    sureBtn.frame = CGRectMake(XYViewL(tipemoney), XYViewBottom(tipemoney)+20, XYViewWidth(tipebackView)-40, 40);
    [tipebackView addSubview:sureBtn];
}

-(void)btnClickSelector:(id)sender
{
    if([self.delegate1 respondsToSelector:@selector(DGScanQRClickPayDone:)])
    {
        [self.delegate1 DGScanQRClickPayDone:nil];
        
    }
    
}

-(void)btnClickremove:(id)sender
{
    [self removeFromSuperview];
}

@end
