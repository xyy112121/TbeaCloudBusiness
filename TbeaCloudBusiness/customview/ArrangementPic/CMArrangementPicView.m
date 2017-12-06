//
//  CMArrangementPicView.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/12/6.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "CMArrangementPicView.h"
#define space 10.0f //每两块间的空隔是10个朴素，
#define verticalnum  5 //一排排5个


@implementation CMArrangementPicView

-(id)initWithFrame:(CGRect)frame ArraySelect:(NSMutableArray *)arraySelect
{
    self = [super initWithFrame:frame];
    if(self)
    {
        FCArraySelect = [[NSMutableArray alloc] initWithArray:arraySelect];
        [self ArrangementPic:FCArraySelect];
    }
    return self;
}

-(void)ArrangementPic:(NSMutableArray *)arraySelect
{
    int widthnow = (SCREEN_WIDTH-space*(verticalnum+1))/verticalnum;
    
    int countnow = (int)[arraySelect count];
    int nowhorizontalnum  = countnow==0?0:(countnow-1)/verticalnum+1;  //表示有多少行
    int nowverticalnum;
    
    
    if(countnow==0)
    {
        //添加 添加图片按钮
        UIButton *buttonadd = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonadd.frame = CGRectMake(space, 10, widthnow, widthnow);
        [buttonadd addTarget:self action:@selector(clickaddpic:) forControlEvents:UIControlEventTouchUpInside];
        [buttonadd setBackgroundImage:LOADIMAGE(@"useraddpic", @"png") forState:UIControlStateNormal];
        [self addSubview:buttonadd];
    }
    
    for(int i = 0;i<nowhorizontalnum;i++)
    {
        if(i<nowhorizontalnum-1)
            nowverticalnum = (countnow%verticalnum)==0?verticalnum:countnow%verticalnum;
        else
        {
            nowverticalnum = verticalnum;
            
            
        }
        for(int j=0;j<nowverticalnum;j++)
        {
            //显示图片
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(space+j*widthnow, 10+i*widthnow, widthnow, widthnow)];
            [self addSubview:imageview];
            
            //删除按钮
            UIButton *buttondelete = [UIButton buttonWithType:UIButtonTypeCustom];
            buttondelete.frame = CGRectMake(XYViewR(imageview)-10, XYViewTop(imageview), 10, 10);
            buttondelete.tag = EnArrangementPicDeleteBt+i*verticalnum+j;
            [buttondelete setBackgroundImage:LOADIMAGE(@"closeorder", @"png") forState:UIControlStateNormal];
            [buttondelete addTarget:self action:@selector(clickdeleteimage:)
                   forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:buttondelete];
        }
        
    }
    
}

-(void)clickaddpic:(id)sender
{
//    UIImageView *imageview = [tableview viewWithTag:EnUserCenterSonAccountHeaderPicTag];
    UIViewController *viewcontroller = [AddInterface GetControllerFromView:self];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择图片"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    //取消:style:UIAlertActionStyleCancel
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [JPhotoMagenage getTakeLibryImageInController:viewcontroller finish:^(UIImage *images) {
            NSLog(@"%@",images);
//            UIImage *image = [AddInterface scaleToSize:images size:CGSizeMake(800, 800)];
//            imageview.image = image;
//            FCimage = image;
//            [self uploadcustompic:FCimage];
        } cancel:^{
            
        }];
    }];
    
    [alertController addAction:moreAction];
    
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [JPhotoMagenage JphotoGetFromLibrayInController:viewcontroller finish:^(NSArray<UIImage *> *images) {
            
        } cancel:^{
            
        }];
    }];
    [alertController addAction:OKAction];
    
    [viewcontroller presentViewController:alertController animated:YES completion:nil];
}

-(void)clickdeleteimage:(id)sender
{
    int tagnow = (int)[(UIButton *)sender tag]-EnArrangementPicDeleteBt;
    
    if(_delegate1&&[_delegate1 respondsToSelector:@selector(DGClickDeleteArrangementPic:)])
    {
        [_delegate1 DGClickDeleteArrangementPic:tagnow];
        [FCArraySelect removeObjectAtIndex:tagnow];
        [self ArrangementPic:FCArraySelect];
    }
    
    
    
}


@end
