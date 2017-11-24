//
//  TbeaScrollviewPicDisplayViewController.m
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/11/24.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "TbeaScrollviewPicDisplayViewController.h"

@interface TbeaScrollviewPicDisplayViewController ()

@end

@implementation TbeaScrollviewPicDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    button.layer.borderColor = [UIColor clearColor].CGColor;
    [button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    [self initview];
    // Do any additional setup after loading the view.
}

-(void)initview
{
    FCphotoArr = [[NSMutableArray alloc] init];
    for(int i=0;i<[_FCarraypic count];i++)
    {
        NSDictionary *dictemp = [_FCarraypic objectAtIndex:i];
        [FCphotoArr addObject:[dictemp objectForKey:@"picture"]];
    }
    
    // 1 初始化
    LLPhotoBrowser *photoBrowser = [[LLPhotoBrowser alloc]init];
    // 2 设置代理
    photoBrowser.delegate = self;
    // 3 设置当前图片
    photoBrowser.currentImageIndex = self.FCnowpage;
    // 4 设置图片的个数
    photoBrowser.imageCount = [_FCarraypic count];
    // 5 设置图片的容器
    photoBrowser.sourceImagesContainerView = self.view;
    // 6 展示
    [photoBrowser show];
}

#pragma mark LLPhotoDelegate
// 代理方法 返回图片URL
- (NSURL *)photoBrowser:(LLPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index{
    
    NSURL *url = [NSURL URLWithString:FCphotoArr[index]];
    return url;
}
// 代理方法返回缩略图
- (UIImage *)photoBrowser:(LLPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index{
    
    //    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
//    UIImageView *imageview = [self.view viewWithTag:EnWaterMettingPicArrmentImageViewTag+index];
    
    return nil;//imageview.image;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
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
