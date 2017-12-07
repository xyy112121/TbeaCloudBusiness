//
//  CMArrangementPicView.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/12/6.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "CMArrangementPicView.h"
#define space 15.0f //每两块间的空隔是15个朴素，
#define verticalnum  4 //一排排4个


@implementation CMArrangementPicView

-(id)initWithFrame:(CGRect)frame ArraySelect:(NSMutableArray *)arraySelect
{
    self = [super initWithFrame:frame];
    if(self)
    {
        FCArraySelect = [[NSMutableArray alloc] init];
        [self ArrangementPic:FCArraySelect];
    }
    return self;
}

-(void)clickaddpic:(id)sender
{
    UIViewController *viewcontroller = [AddInterface GetControllerFromView:self];
    
    [JPhotoMagenage getImageInController:viewcontroller finish:^(NSArray<UIImage *> *images) {
        for(UIImage *imageone in images)
        {
            [FCArraySelect addObject:imageone];
        }
        [self updateselectpicarray];
        [self ArrangementPic:FCArraySelect];
    } cancel:^{
        
    }];
    
//    [JPhotoMagenage JphotoGetFromLibrayInController:viewcontroller finish:^(NSArray<UIImage *> *images) {
//        for(UIImage *imageone in images)
//        {
//            [FCArraySelect addObject:imageone];
//        }
//        [self updateselectpicarray];
//        [self ArrangementPic:FCArraySelect];
//    } cancel:^{
//
//    }];
}

-(void)ArrangementPic:(NSMutableArray *)arraySelect
{
    [FCViewbg removeFromSuperview];
    FCViewbg = nil;
    FCViewbg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, XYViewWidth(self), XYViewHeight(self))];
    FCViewbg.backgroundColor = [UIColor redColor];
    [self addSubview:FCViewbg];
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
        [FCViewbg addSubview:buttonadd];
    }
    
    for(int i = 0;i<nowhorizontalnum;i++)
    {
        if((nowhorizontalnum==1)||(i==nowhorizontalnum-1))
            nowverticalnum = (countnow%verticalnum)==0?verticalnum:countnow%verticalnum;
        else
            nowverticalnum = verticalnum;
        
        
        for(int j=0;j<nowverticalnum;j++)
        {
            //显示图片
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(space+j*(widthnow+10), 10+i*(widthnow+10), widthnow, widthnow)];
            imageview.image = [arraySelect objectAtIndex:i*verticalnum+j];
            [FCViewbg addSubview:imageview];
            
            //删除按钮
            UIButton *buttondelete = [UIButton buttonWithType:UIButtonTypeCustom];
            buttondelete.frame = CGRectMake(XYViewR(imageview)-20, XYViewTop(imageview), 20, 20);
            buttondelete.tag = EnArrangementPicDeleteBt+i*verticalnum+j;
            [buttondelete setBackgroundImage:LOADIMAGE(@"closeorder", @"png") forState:UIControlStateNormal];
            [buttondelete addTarget:self action:@selector(clickdeleteimage:)
                   forControlEvents:UIControlEventTouchUpInside];
            [FCViewbg addSubview:buttondelete];
        }
        
    }
    
}

//-(void)clickaddpic:(id)sender
//{
////    UIImageView *imageview = [tableview viewWithTag:EnUserCenterSonAccountHeaderPicTag];
//    UIViewController *viewcontroller = [AddInterface GetControllerFromView:self];
//    __weak typeof(self) weakSelf = self;
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择图片"
//                                                                             message:nil
//                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
//    //取消:style:UIAlertActionStyleCancel
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [alertController addAction:cancelAction];
//    
//    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [JPhotoMagenage JphotoGetFromLibrayInController:viewcontroller finish:^(NSArray<UIImage *> *images) {
//            for(UIImage *imageone in images)
//            {
//                [FCArraySelect addObject:imageone];
//            }
//            [weakSelf updateselectpicarray];
//            [weakSelf ArrangementPic:FCArraySelect];
//        } cancel:^{
//            
//        }];
//    }];
//    
//    [alertController addAction:moreAction];
//    
//    
//    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [JPhotoMagenage getOneImageInController:viewcontroller finish:^(UIImage *images) {
//             [FCArraySelect addObject:images];
//             [weakSelf updateselectpicarray];
//             [weakSelf ArrangementPic:FCArraySelect];
//        } cancel:^{
//            
//        }];
//       
//    }];
//    [alertController addAction:OKAction];
//    
//    [viewcontroller presentViewController:alertController animated:YES completion:nil];
//}

-(void)updateselectpicarray
{
    if(_delegate1&&[_delegate1 respondsToSelector:@selector(DGUpdateSelectPic:)])
    {
        [_delegate1 DGUpdateSelectPic:FCArraySelect];
    }
}

-(void)clickdeleteimage:(id)sender
{
    int tagnow = (int)[(UIButton *)sender tag]-EnArrangementPicDeleteBt;
    [FCArraySelect removeObjectAtIndex:tagnow];
    
    [self ArrangementPic:FCArraySelect];
//    if(_delegate1&&[_delegate1 respondsToSelector:@selector(DGUpdateSelectPic:)])
//    {
//        [FCArraySelect removeObjectAtIndex:tagnow];
//        [_delegate1 DGUpdateSelectPic:FCArraySelect];
//        [self ArrangementPic:FCArraySelect];
//    }
    
    
    
}


@end
