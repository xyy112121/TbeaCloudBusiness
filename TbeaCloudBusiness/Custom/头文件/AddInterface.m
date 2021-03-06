//
//  AddInterface.m
//  Ccwbnewclient
//
//  Created by 谢 毅 on 13-10-23.
//  Copyright (c) 2013年 谢 毅. All rights reserved.
//

#import "AddInterface.h"
#import "sys/utsname.h"
#import "AppDelegate.h"
#import "Header.h"
#import "Reachability.h"
#import <CommonCrypto/CommonDigest.h>
@implementation AddInterface

//+ (NSString *)getDeviceId
//{
//	NSString * currentDeviceUUIDStr = [SAMKeychain passwordForService:@" "account:@"uuid"];
//	if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""])
//	{
//		NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
//		currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
//		currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
//		currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
//		[SAMKeychain setPassword: currentDeviceUUIDStr forService:@" "account:@"uuid"];
//	}
//	return currentDeviceUUIDStr;
//}

+(BOOL)judgeislogin
{
    NSFileManager *filemanger = [NSFileManager defaultManager];
    if([filemanger fileExistsAtPath:UserMessage])
        return YES;
    return NO;

}

+(BOOL)isPureFloat:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+(BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

+(NSString*)DataTOjsonString:(id)object
{
	NSString *jsonString = nil;
	NSError *error;
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
													   options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
														 error:&error];
	if (! jsonData) {
		NSLog(@"Got an error: %@", error);
	} else {
		jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
	}
	return jsonString;
}

+ (id)toArrayOrNSDictionary:(NSData *)jsonData
{
	NSError *error = nil;
	id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
													options:NSJSONReadingMutableContainers
													  error:&error];
	
	if (jsonObject != nil && error == nil){
		return jsonObject;
	}else{
		// 解析错误
		return nil;
	}
	
}

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
	// 创建一个bitmap的context
	// 并把它设置成为当前正在使用的context
	UIGraphicsBeginImageContext(size);
	// 绘制改变大小的图片
	[img drawInRect:CGRectMake(0, 0, size.width, size.height)];
	// 从当前context中创建一个改变大小后的图片
	UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	// 使当前的context出堆栈
	UIGraphicsEndImageContext();
	// 返回新的改变大小后的图片
	return scaledImage;
}

+(CGSize) getlablesize:(NSString *)str Fwidth:(float)fwidth Fheight:(float)fheight Sfont:(UIFont *)sfont
{
	NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
	[style setLineBreakMode:NSLineBreakByCharWrapping];
	
	NSDictionary *attributes = @{ NSFontAttributeName : sfont, NSParagraphStyleAttributeName : style };

	
	CGSize Sizetemp = [str boundingRectWithSize:CGSizeMake(fwidth,fheight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
	
	return Sizetemp;
}

+ (NSString *) md5:(NSString *)str
{
	const char *cStr = [str UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
	
	NSMutableString *md5String = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
	
	for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		[md5String appendFormat:@"%02x", result[i]];
	}
	return md5String;
}

+(NSString *)RandomId:(int)numwei
{
    NSDate *nowdate = [NSDate date];
    NSDateFormatter* dateFormat123 = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat123 setDateFormat:@"yyyyMMddHHmmss"];//设定时间格式,这里可以设置成自己需要的格式
    NSString *randomstr = [dateFormat123 stringFromDate:nowdate];
    NSString *stringconst = @"abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSInteger x;
    for(int i = 0;i<numwei;i++)
    {
        x = arc4random()%61;
        randomstr = [randomstr stringByAppendingString:[stringconst substringWithRange:NSMakeRange(x,1)]];
    }
    DLog(@"randomstr=======%@",randomstr);
    return randomstr;
}

+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(float)fileSizeAtPath:(NSString *)path{
	NSFileManager *fileManager=[NSFileManager defaultManager];
	if([fileManager fileExistsAtPath:path]){
		long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
		return size/1024.0/1024.0;
	}
	return 0;
}

+(float)folderSizeAtPath:(NSString *)path{
	NSFileManager *fileManager=[NSFileManager defaultManager];
	float folderSize;
	if ([fileManager fileExistsAtPath:path]) {
		NSArray *childerFiles=[fileManager subpathsAtPath:path];
		for (NSString *fileName in childerFiles)
		{
			DLog(@"fileName====%@",fileName);
			NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
			folderSize +=[AddInterface fileSizeAtPath:absolutePath];
		}
//		　　　　　//SDWebImage框架自身计算缓存的实现
//		folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
		return folderSize;
	}
	return 0;
}

+(void)clearCache:(NSString *)path{
	NSFileManager *fileManager=[NSFileManager defaultManager];
	if ([fileManager fileExistsAtPath:path]) {
		NSArray *childerFiles=[fileManager subpathsAtPath:path];
		for (NSString *fileName in childerFiles) {
			//如有需要，加入条件，过滤掉不想删除的文件
			if(([fileName rangeOfString:@"jpg"].location !=NSNotFound)||([fileName rangeOfString:@"png"].location !=NSNotFound)||([fileName rangeOfString:@"mp4"].location !=NSNotFound))
			{
				NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
				[fileManager removeItemAtPath:absolutePath error:nil];
			}
			
		}
	}
}

#pragma mark 是否wifi
+ (BOOL) IsEnableWIFI
{
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}


#pragma mark  是否3G
+ (BOOL) IsEnable3G {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

+(NSString *)returnnowdate
{
    NSDate *nowdate = [NSDate date];
    NSDateFormatter* dateFormat123 = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat123 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSString *nowdatestr = [dateFormat123 stringFromDate:nowdate];
    return nowdatestr;
}

+(BOOL) isValidateMobile:(NSString *)mobile
{
	//手机号以13， 15，18开头，八个 \d 数字字符
	NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
	NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
	return [phoneTest evaluateWithObject:mobile];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
	if (jsonString == nil) {
		return nil;
	}
	
	NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
	NSError *err;
	NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
														options:NSJSONReadingMutableContainers
														  error:&err];
	if(err)
	{
		NSLog(@"json解析失败：%@",err);
		return nil;
	}
	return dic;
}

+(BOOL) isValidatenumber:(NSString *)mobile
{
	//
	NSString *regex = @"^\\d+(\\.\\d{2})?$";
	NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
	return [phoneTest evaluateWithObject:mobile];
}



+(NSString *)returnnowdatefromstr:(NSString *)str
{
	NSDate *nowdate = [NSDate date];
	NSDateFormatter* dateFormat123 = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
	[dateFormat123 setDateFormat:str];//设定时间格式,这里可以设置成自己需要的格式
	NSString *nowdatestr = [dateFormat123 stringFromDate:nowdate];
	return nowdatestr;
}

+(NSString *)returnnowdate2
{
    NSDate *nowdate = [NSDate date];
    NSDateFormatter* dateFormat123 = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat123 setDateFormat:@"yyyy/MM/dd HH:mm"];//设定时间格式,这里可以设置成自己需要的格式
    NSString *nowdatestr = [dateFormat123 stringFromDate:nowdate];
    return nowdatestr;
}


+(NSString *)returnnowdate3:(NSString *)strdate
{

    NSString *posthour = [strdate substringWithRange:NSMakeRange(11, 2)];
    NSString *postmin = [strdate substringWithRange:NSMakeRange(14, 2)];
    
    return [[posthour stringByAppendingString:@":"] stringByAppendingString:postmin];
}

+(NSString *)timeformat:(NSString *)datatime
{
    
    int postday = [[datatime substringWithRange:NSMakeRange(8, 2)] intValue];
    int posthour = [[datatime substringWithRange:NSMakeRange(11, 2)] intValue];
    int postmin = [[datatime substringWithRange:NSMakeRange(14, 2)] intValue];
    
    NSDate *nowdate = [NSDate date];
    NSDateFormatter* dateFormat123 = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat123 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSString *nowdatestr = [dateFormat123 stringFromDate:nowdate];
    int nowday = [[nowdatestr substringWithRange:NSMakeRange(8, 2)] intValue];
    int nowhour = [[nowdatestr substringWithRange:NSMakeRange(11, 2)] intValue];
    int nowmin = [[nowdatestr substringWithRange:NSMakeRange(14, 2)] intValue];
    DLog(@"postday=====%d,%d,%d",postday,posthour,postmin);
    DLog(@"nowday=====%d,%d,%d",nowday,nowhour,nowmin);
    if(postday != nowday)
    {
        return [datatime substringWithRange:NSMakeRange(5, 5)];
    }
    else if(posthour == nowhour)
    {
        return [NSString stringWithFormat:@"%d分钟前",nowmin-postmin];
    }
    else if(posthour != nowhour)
    {
        if((posthour+1) < nowhour)
        {
            return [NSString stringWithFormat:@"%d小时前",nowhour-posthour];
            
        }
        else if(((posthour+1)==nowhour)&&(postmin<nowmin))
        {
            return [NSString stringWithFormat:@"%d小时前",nowhour-posthour];
        }
        else
        {
            return [NSString stringWithFormat:@"%d分钟前",nowmin+60-postmin];
        }
    }
    else
        return @"刚刚";
}

//时间差
+(NSString *)intervalSinceNow: (NSString *) theDate
{
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];

    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
        
    }
    return timeString;
}


//根据选择的值 返回ID
+(NSString *)returnselectid:(NSArray *)arrayfrom SelectValue:(NSString *)seletvalue
{
	NSString *returnid;
	
	for(int i=0;i<[arrayfrom count];i++)
	{
		NSDictionary *dictemp = [arrayfrom objectAtIndex:i];
		if([[dictemp objectForKey:@"name"] isEqualToString:seletvalue])
		{
			returnid = [dictemp objectForKey:@"id"];
			break;
		}
	}
	
	return returnid;
}

//判断一个数组中是否包含当前dic
+(int)iscontaindic:(NSArray *)arrayfrom DicFrom:(NSDictionary *)dicfrom FlagId:(NSString *)flagid
{
	int flag = 0; //0表示不包含  1表示包含
	for(int i =0;i<[arrayfrom count];i++)
	{
		NSDictionary *dictemp = [arrayfrom objectAtIndex:i];
		if([[dictemp objectForKey:flagid] isEqualToString:[dicfrom objectForKey:flagid]])
		{
			flag = 1;
		}
	}
	
	return flag;
}

//获取view的controller
+(UIViewController *)GetControllerFromView:(UIView*) pView
{
    for (UIView* pNext = [pView superview]; pNext; pNext = pNext.superview) {
        UIResponder *pNextResponder = [pNext nextResponder];
        if ([pNextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)pNextResponder;
        }
    }
    return nil;
}

//时间差
+(BOOL)timechar: (NSString *)theDate
{
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd"];
    NSDate *d=[date dateFromString:theDate];
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    
    NSTimeInterval cha=now-late;
    
    if (cha/(24*60*60)>3) return YES;
    else
        return NO;
}

+ (NSInteger)OSVersion
{
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    return _deviceSystemMajorVersion;
}

+ (UIImage *)clipImageWithScaleWithsize:(CGSize)asize Image:(UIImage *)image
{
	UIImage *newimage;
	//	UIImage *image = self;
	if (nil == image) {
		newimage = nil;
	}
	else
	{
		CGSize oldsize = image.size;
		
		CGRect rect;
		if (asize.width/asize.height < oldsize.width/oldsize.height) {
			rect.size.width = asize.width;
			rect.size.height = asize.width*oldsize.height/oldsize.width;
			rect.origin.x = 0;
			rect.origin.y = (asize.height - rect.size.height)/2;
		}
		else{
			rect.size.width = asize.height*oldsize.width/oldsize.height;
			rect.size.height = asize.height;
			rect.origin.x = (asize.width - rect.size.width)/2;
			rect.origin.y = 0;
		}
		UIGraphicsBeginImageContext(asize);
		CGContextRef context = UIGraphicsGetCurrentContext();
		CGContextClipToRect(context, CGRectMake(0, 0, asize.width, asize.height));
		CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
		UIRectFill(CGRectMake(0, 0, asize.width, asize.height));
		[image drawInRect:rect];
		newimage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
	}
	return newimage;
}


#pragma mark view相对屏幕位置
+ (CGRect)relativeFrameForScreenWithView:(UIView *)v
{

	
	CGFloat screenHeight = SCREEN_HEIGHT;

	UIView *view = v;
	CGFloat x = .0;
	CGFloat y = .0;
	while (view.frame.size.width != 320 || view.frame.size.height != screenHeight) {
		x += view.frame.origin.x;
		y += view.frame.origin.y;
		view = view.superview;
		if ([view isKindOfClass:[UIScrollView class]]) {
			x -= ((UIScrollView *) view).contentOffset.x;
			y -= ((UIScrollView *) view).contentOffset.y;
		}
	}
	return CGRectMake(x, y, v.frame.size.width, v.frame.size.height);
}


@end
