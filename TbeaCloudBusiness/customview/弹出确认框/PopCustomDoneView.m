//
//  PopCustomDoneView.m
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/10/24.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "PopCustomDoneView.h"

@implementation PopCustomDoneView

-(instancetype)initWithFrame:(CGRect)frame strFrom:(NSString *)str BtTitle:(NSString *)bttitle
{
    self =[super initWithFrame:frame];
    if (self) {
        //设置模板层背景色
        self.backgroundColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:0.7];
        [self initview:str BtTitle:bttitle];
        
    }
    return self;
}

-(void)initview:(NSString *)str BtTitle:(NSString *)bttitle
{
    UIButton *clearbt  =[UIButton buttonWithType:UIButtonTypeCustom];
    [clearbt addTarget:self action:@selector(btnClickremove:) forControlEvents:UIControlEventTouchUpInside];
    clearbt.backgroundColor=[UIColor clearColor];
    clearbt.frame = CGRectMake(0,0,XYViewWidth(self),XYViewHeight(self));
    [self addSubview:clearbt];
    
    UIView *tipebackView =[[UIView alloc]initWithFrame:CGRectMake(30, self.frame.size.height/2-90-64, self.frame.size.width-60, 180)];
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
    
    UILabel *popmessage =[[UILabel alloc]initWithFrame:CGRectMake(XYViewL(imageicon), XYViewBottom(imageline)+10, XYViewWidth(imageline), XYViewHeight(tipebackView)-120)];
    popmessage.textColor = [UIColor blackColor];
    popmessage.text = str;
    popmessage.numberOfLines = 3;
    popmessage.font =  FONTN(15.0f);
    [tipebackView addSubview:popmessage];
    
    UIButton *sureBtn  =[UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.tag=EnPayPopConfirmViewBtTag;
    [sureBtn setTitle:bttitle forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font =[UIFont systemFontOfSize:16 weight:0.5];
    sureBtn.layer.cornerRadius = 3.0f;
    sureBtn.clipsToBounds = YES;
    [sureBtn addTarget:self action:@selector(btnClickSelector:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.backgroundColor=[UIColor colorWithRed:254/255.0 green:72/255.0 blue:68/255.0 alpha:1.0];
    sureBtn.frame = CGRectMake(XYViewL(imageline), XYViewHeight(tipebackView)-60, XYViewWidth(tipebackView)-40, 40);
    [tipebackView addSubview:sureBtn];
}

-(void)btnClickSelector:(id)sender
{
    if([self.delegate1 respondsToSelector:@selector(DGTbeaSelectPersonPaiDanDone:)])
    {
        [self.delegate1 DGTbeaSelectPersonPaiDanDone:nil];
        
    }
    
}

-(void)btnClickremove:(id)sender
{
    [self removeFromSuperview];
}

@end
