//
//  RequestInterface.m
//  CcwbNews
//
//  Created by xyy520 on 16/5/19.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "RequestInterface.h"
#import "Jwt.h"
@implementation RequestInterface

//获取普通管理器
+(AFHTTPSessionManager *)getHTTPManager{
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.requestSerializer.timeoutInterval = 20.0f;
	manager.responseSerializer = [AFHTTPResponseSerializer serializer];
	return manager;
}

+(AppDelegate *)getAppdelegate
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	return app;
}

//普通 接口没有请求动画效果的
+(void)doGetJsonWithParametersNoAn:(NSDictionary * )parameters App:(AppDelegate *)app RequestCode:(NSString *)requestcode  ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success Failur:(void (^)(NSString * strmsg))failure
{
	AFHTTPSessionManager *manager = [RequestInterface getHTTPManager];
	NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:parameters];
	
	XYW8IndicatorView *animationView = [[XYW8IndicatorView alloc] init];
	animationView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
	animationView.frame = (CGRect){0,0,SCREEN_WIDTH,SCREEN_HEIGHT};
	animationView.dotColor = [UIColor colorWithRed:27/255.0f green:130/255.0f blue:210/255.0f alpha:1];
	[app.window addSubview:animationView];
	[animationView startAnimating];
	
	[manager.requestSerializer setValue:@"IPHONE" forHTTPHeaderField:@"origdomain"];
	[manager.requestSerializer setValue:@"tbeayun_v1" forHTTPHeaderField:@"protocolver"];
	[manager.requestSerializer setValue:@"V_1.0" forHTTPHeaderField:@"appversion"];
	[manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"actioncode"];
	[manager.requestSerializer setValue:requestcode forHTTPHeaderField:@"servicecode"];
	[manager.requestSerializer setValue:app.userinfo.userid forHTTPHeaderField:@"userid"];
	[manager.requestSerializer setValue:[NSString stringWithFormat:@"%f",app.diliweizhi.longitude] forHTTPHeaderField:@"longitude"];
	[manager.requestSerializer setValue:[NSString stringWithFormat:@"%f",app.diliweizhi.latitude] forHTTPHeaderField:@"latitude"];
	
	
	[manager POST:requrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
	 {
		 
	 }
		  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
	 {
		 if(always){
			 always();
		 }
		 
		 NSString *str = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
     //    DLog(@"str====%@",str);
		 NSDictionary *jsonvalue = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
		 success(jsonvalue);
		 [animationView stopAnimating:YES];
		 [animationView removeFromSuperview];
		 
	 }
		  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
	 {
		 [animationView stopAnimating:YES];
		 [animationView removeFromSuperview];
         failure(@"请求失败,请检查网络");
	//	 [MBProgressHUD showError:@"请求失败,请检查网络" toView:showview];
		 
	 }];
}


//普通 接口没有请求动画效果的  从优商移植过来的
+(void)doGetJsonWithParametersNoAn:(NSDictionary * )parameters App:(AppDelegate *)app RequestCode:(NSString *)requestcode ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success
{
    AFHTTPSessionManager *manager = [RequestInterface getHTTPManager];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:parameters];
    
    XYW8IndicatorView *animationView = [[XYW8IndicatorView alloc] init];
    animationView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    animationView.frame = (CGRect){0,0,SCREEN_WIDTH,SCREEN_HEIGHT};
    animationView.dotColor = [UIColor colorWithRed:27/255.0f green:130/255.0f blue:210/255.0f alpha:1];
    [app.window addSubview:animationView];
    [animationView startAnimating];
    
    [manager.requestSerializer setValue:@"IPHONE" forHTTPHeaderField:@"OrigDomain"];
    [manager.requestSerializer setValue:@"tbea_v1" forHTTPHeaderField:@"ProtocolVer"];
    [manager.requestSerializer setValue:@"V_1.0" forHTTPHeaderField:@"AppVersion"];
    [manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"ActionCode"];
    [manager.requestSerializer setValue:requestcode forHTTPHeaderField:@"ServiceCode"];
    [manager.requestSerializer setValue:app.userinfo.userid forHTTPHeaderField:@"UserId"];
    [manager.requestSerializer setValue:app.diliweizhi.dililocality forHTTPHeaderField:@"CityId"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%f",app.diliweizhi.longitude] forHTTPHeaderField:@"longitude"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%f",app.diliweizhi.latitude] forHTTPHeaderField:@"latitude"];
    [manager.requestSerializer setValue:[app.diliweizhi.diliprovince stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forHTTPHeaderField:@"ProvinceName"];
    [manager.requestSerializer setValue:[app.diliweizhi.dilicity stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forHTTPHeaderField:@"CityName"];
    [manager.requestSerializer setValue:@"tbeadelan" forHTTPHeaderField:@"TbeaBranchId"];
    
    
    [manager POST:requrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     }
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if(always){
             always();
         }
         
         NSDictionary *jsonvalue = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         success(jsonvalue);
         [animationView stopAnimating:YES];
         [animationView removeFromSuperview];
         
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [animationView stopAnimating:YES];
         [animationView removeFromSuperview];
         [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
     }];
}

//上传图片接口
+(void)doGetJsonWithArraypic:(NSArray * )arrayimage Parameter:(NSDictionary * )parameters App:(AppDelegate *)app RequestCode:(NSString *)requestcode ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success Failur:(void (^)(NSString * strmsg))failure
{
	AFHTTPSessionManager *manager = [RequestInterface getHTTPManager];
//	NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:parameters];
    [manager.requestSerializer setValue:@"IPHONE" forHTTPHeaderField:@"origdomain"];
    [manager.requestSerializer setValue:@"tbeayun_v1" forHTTPHeaderField:@"protocolver"];
    [manager.requestSerializer setValue:@"V_1.0" forHTTPHeaderField:@"appversion"];
    [manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"actioncode"];
    [manager.requestSerializer setValue:requestcode forHTTPHeaderField:@"servicecode"];
    [manager.requestSerializer setValue:app.userinfo.userid forHTTPHeaderField:@"userid"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%f",app.diliweizhi.longitude] forHTTPHeaderField:@"longitude"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%f",app.diliweizhi.latitude] forHTTPHeaderField:@"latitude"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:requrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i=0;i<[arrayimage count];i++)
        {
            NSDate *date = [NSDate date];
            NSDateFormatter *formormat = [[NSDateFormatter alloc]init];
            [formormat setDateFormat:@"HHmmss"];
            NSString *dateString = [formormat stringFromDate:date];
            NSString *fileName = [NSString  stringWithFormat:@"%@.png",dateString];
            
            NSData *imageData;
            UIImage *image = [arrayimage objectAtIndex:i];
            imageData = UIImageJPEGRepresentation(image, 0.5f);
            
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"file%d",i] fileName:fileName mimeType:@"image/jpg/png/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *str = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        		 DLog(@"str====%@",str);
        
        NSDictionary *jsonvalue = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        success(jsonvalue);
        NSLog(@"responseObject = %@, task = %@",responseObject,task);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:showview];
    }];
    
    
}


@end
