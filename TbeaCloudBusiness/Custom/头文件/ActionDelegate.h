//
//  ActionDelegate.h
//  KuaiPaiYunNan
//
//  Created by 谢 毅 on 13-6-18.
//  Copyright (c) 2013年 谢 毅. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ActionDelegate<NSObject>
@optional

-(void)DGClickFunctionGotoView:(NSDictionary *)sender;  //首页扫码返利
-(void)DGModelSelectInfo:(NSDictionary *)sender; //规格选择
-(void)DGSpecificationSelectInfo:(NSDictionary *)sender; //型号选择
-(void)DGProductSpecification:(NSString *)sender Speid:(NSString *)speid Modelid:(NSString *)modelid;//选择的产品规格
-(void)DGSelectDateHourSecondDone:(NSString *)starttime EndTime:(NSString *)endtime;//选择时间结束
-(void)DGSelectDateDone:(NSString *)starttime EndTime:(NSString *)endtime;//选择时间结束
-(void)DGClickWaterFunctionHp:(int)tagnow; //水平工管理页面个人主页功能
-(void)DGCLickWaterPersonHeader:(id)sender;//点击 进入个人资料
-(void)DGFocusClickNumberPic:(id)sender;//点击的焦点图的第几张
-(void)DGClickTopFunction:(int)sender;//点击特变电工上的功能按钮
-(void)DGClickTbeaHpProduct:(NSDictionary *)sender;//特变电工首页产品
-(void)DGLoginSuccess:(id)sender;//登录成功
-(void)DGAreaSelectDone:(NSArray *)sender;//区域选择确认
-(void)DGClickMallStoreFunctionGotoView:(NSDictionary *)sender;  //首页扫码返利
-(void)DGCLickScanCode:(id)sender;//点击首页右边的二维码扫描
-(void)DGScanQRClickPayDone:(id)sender;//扫码返利确认支付
-(void)DGClickselectItemDone:(id)sender;//点击选择项
-(void)DGSelectJXSCellView:(id)sender;//公司人员
-(void)DGSelectJoinMemberCellView:(id)sender;//选择参与人员
-(void)DGMettingScheduleDone:(NSString *)sender;//会议安排
-(void)DGClickCellFunction:(NSDictionary *)sender;//点击首页横条功能cell
-(void)DGSelectAreaAddress:(NSString *)pstr City:(NSString *)city Area:(NSString *)area Address:(NSString *)address;
-(void)DGWaterMettingCommitDone:(NSString *)sender;
-(void)DGGetMettingSummary:(NSString *)sender;   //会议纪要
-(void)DGGetMettingPicNumber:(NSString *)sender;    //会议图片数量
-(void)DGSaveSonAccountFunctionAuthorList:(id)sender;
-(void)DGClickSearchResultTextField:(NSString *)str;
-(void)DGClickGoToSearch:(id)sender;
-(void)DGclickMessage:(id)sender; //点击消息
-(void)DGSlectLinkSelectItemDong:(EnMallStoreLinkSelecttype)selectype SelectItem:(NSDictionary *)selectitem; //链接 页面
-(void)DGSaveSpecifiModulename:(NSString *)strname SetFlag:(NSString *)setflag;//保存型号规格
-(void)DGProductSelectCommity:(NSDictionary *)sender;//生成二维码时选择产品名称
-(void)DGTbeaSelectPaiDanPersonInfo:(NSDictionary *)person;
-(void)DGTbeaSelectPersonPaiDanDone:(id)sender;
-(void)DGCommitClickJieDan:(NSString *)strelecid;//接单提交
-(void)DGClickUserHeaderIntoInfo:(id)sender;//点击头像


//以下是分销系统用到的，由于原来移植过来的所以全部放在这里了
-(void)setnewspageframe:(CGRect)sender;
-(void)gotonewsdetaildelegate:(NSString *)strid;
-(void)doneselect:(int)sender;
-(void)cannelselect:(int)sender;
-(void)gotocommoditydetail:(NSString *)strid Flag:(NSString *)flag;
-(void)commitorder:(id)sender;
-(void)removeexchangeview:(id)sender;
-(void)ExchangeCommoditydelegate:(id)sender;
-(void)selectguigeyanse:(int)sender Comid:(NSString *)comid;
-(void)removeloginview:(id)sender;
-(void)refershpersonpage:(int)sender;
-(void)settechnologyframe:(CGRect)sender;
-(void)gotoadverdetail:(NSString *)sender;
-(void)selectbigniebie:(NSDictionary *)dicniebie;
-(void)selectsmallniebie:(NSDictionary *)dicniebie;
-(void)freshproductservice:(NSDictionary *)sender;
-(void)gotoprojectdetail:(NSDictionary *)strid;
-(void)searchnewsdelegate:(NSString *)newstext;
-(void)changenactlright:(int)sender;
-(void)selectcompanydone:(NSDictionary *)dicniebie;
-(void)commitaddshopp:(id)sender;
-(void)commitmodifyshopp:(id)sender;

-(void)jxsearchstock:(NSString *)sender;

-(void)updateselectkehu:(NSDictionary *)kehu;
-(void)updateselectwuliao:(NSDictionary *)wuliao;
-(void)addproductsuccess:(NSString *)strid;
-(void)addreturnflag:(int)iflag;
-(void)clicksearchcode:(NSString *)sender;

-(void)scancoderesult:(NSString *)scancode;
-(void)Delegateupdatewuliuinfo:(NSString *)scancode;
-(void)wuliuselectAddr:(NSDictionary *)dicaddr;

@end
