//
//  Enum_set.h
//  CcwbNews
//
//  Created by xyy520 on 16/5/5.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#ifndef Enum_set_h
#define Enum_set_h

typedef enum
{
	EnZJXUser,//总经销商
	EnFJXUser,//分经销商
	EnMangerUser//管理员
}EnAppUserType;

typedef enum{
	//各个tag表示的意思
	EnScanRebateUserAll,   //全部用户
	EnScanRebateUserWater, //水电工
	EnscanRebateUserFenXiaoShang //分销商

}EnScanRebateHpUserType;  //扫码返利用户类型


typedef enum       //提现数据  支付待支付
{
	EnTiXianDataZhifu,
	EnTiXianDataWeiZhifu,
    EnTiXianDataTiXian
}EnTiXianDataZhiFuType;

typedef enum       //提现数据  支付待支付
{
	EnWaterScanType,
	EnWaterTiXianType
}EnWaterScanTianType;

typedef enum
{
	EnTiXianDataSelectDate,//选择的时间
	EnTiXianDataSelectUser,//选择的用户
	EnTiXianDataSelectMoney//选择的金额
}EnTiXianDataSelectItem;

typedef enum
{
	EnStartTime,  //开始时间
	EnEndTime    //结束 时间
}EnSelectTime;

typedef enum
{
    EnMettingEdit,  //编辑状态
    EnMettingNotEdit    //不可编辑
}EnMettingEditStatus;

typedef enum
{
	EnSortMoreSelectUserType,//选择的用户
	EnSortMoreSelectArea,//选择的用户
	EnSortMoreSelectTiXian//选择的金额
}EnSortMoreSelectItem;

typedef enum
{
	EnMoneySortDesc,  //从大到小
	EnMoneySortAsc    //从小到大
}EnMoneySortSelect;

typedef enum
{
    EnTbeaHpSelectItemall,
    EnTbeaHpSelectItemdaichuli,
    EnTbeaHpSelectItemyipaidan,
    EnTbeaHpSelectItemyiwangong,
    EnTbeaHpSelectItemyishangchuan
}EnTbeaHpSelectItem;

//水电工个人主页功能类型
typedef enum
{
	EnWaterPersonScanRebate,
	EnWaterPersonMetting,
	EnWaterPersonService,
    EnWaterPersonOrder,
	EnWaterPersonSocialinfo,
	EnWaterPersonLogin
}EnWaterPersonHpFunctionType;

typedef enum
{
	EnWaterScanSelectDate,//选择的时间
	EnWaterScanSelectStatus,//状态
	EnWaterScanSelectUser,//选择的用户
	EnWaterScanSelectMoney//选择的金额
}EnWaterScanSelectItem;

typedef enum
{
	EnCheckInSelectmetting,//选择的会议
	EnCheckInSelectarea,//选择的区域
	EnCheckInSelecttime//选择的时间
}EnCheckInSelectItem;

typedef enum
{
	EnWaterMettingmetting,//选择的会议
	EnWaterMettingarea,//选择的区域
	EnWaterMettingstatus,//选择的状态
	EnWaterMettingtime//选择的时间
}EnWaterMettingSelectItem;


typedef enum
{
	EnButtonTextLeft,   //左对齐
	EnButtonTextCenter, //中间对齐
	EnButtonTextRight   //右对齐
}EnButtonTextAlignment;


typedef enum
{
	EnWaterMettingCheckInUser, //会议签到用户
	EnWaterMettingCheckInArea, //区域
	EnWaterMettingCheckInTime   //时间
}EnWaterMettingCheckInSelectItem;

typedef enum
{
	EnWaterMettingCheckInListUser, //会议签到用户
	EnWaterMettingCheckInListall, //累计签到
	EnWaterMettingCheckInListTime   //时间
}EnWaterMettingCheckInListSelectItem;

typedef enum    //表示选择与否
{
	EnNotSelect,
	EnSelectd
}EnSelectType;

typedef enum
{
	EnAttentionProduct,
	EnAttentionShop,
	EnAttentionPerson
}EnAttentionSelectMenuItem;

typedef enum     //会员管理管理框
{
	EnMemberMangerItemUser,
	EnMemberMangerItemArea
}EnMemberMangerSelectItem;

typedef enum
{
    EnMallStoreLinkSelectCommodity,  //店铺商品
    EnMallStoreLinkSelectActivity    //店铺动态
}EnMallStoreLinkSelecttype;

typedef enum
{
	EnHpFunctionCellType1, //普通类型 即6个元素的普通类型 ，能用型
	EnHpFunctionCellType2, //管理员扫码返利的这种类型  00-管理员-首页
	EnHpFunctionCellType3 //管理员扫码返利的考勤管理类型  00-管理员-首页

}EnHpFunctionCellType;

typedef enum
{
	EnCreateQRCodeHistorySelectTime,
	EnCreateQRCodeHistorySelectNumber,
	EnCreateQRCodeHistorySelectMoney,
	EnCreateQRCodeHistorySelectJiHuo
}EnCreateQRCodeHistorySelectItem;

typedef enum
{
    EnTbeaProductSelectItem1,
    EnTbeaProductSelectItem2,
    EnTbeaProductSelectItem3
}EnTbeaProductListType;

#endif /* Enum_set_h */


#define EnHpAppFuntionBt  50000   //首页功能button按钮
#define EnScanRebateHpBtLeft   50010  //扫码返利首页面选择经销商类型按钮
#define EnModelSpecificationLabel1  50021 //型号规格label
#define EnModelSpecificationLabel2  50022 //型号规格label
#define EnModelSpecificationLabel3  50023 //型号规格label
#define EnModelSpecificationCellLabel  50030 //规格cell选择
#define EnModelSpecificationSelectImage  51000 //规格cell选择图片
#define EnCreateCodeMoneyTextfield  52000 //规格cell选择图片
#define EnCreateCodeNumberTextfield  52010 //规格cell选择图片
#define EnCreateCodeModelSpeTextfield  52020 //规格cell选择图片
#define EnCreateCodeNameSpeTextfield  52022 //规格cell选择图片
#define EnRebateQRCodeHistoryButton1  52030 //规格cell选择图片
#define EnRebateQRCodeHistoryButton2  52031 //规格cell选择图片
#define EnRebateQRCodeHistoryButton3  52032 //规格cell选择图片
#define EnRebateQRCodeHistoryButton4  52033 //规格cell选择图片
#define EnJiHuoPageSelectButton1      52051  //激活页面选项button
#define EnJiHuoPageSelectButton2      52052  //激活页面选项button
#define EnJiHuoPageSelectButton3      52053  //激活页面选项button
#define EnTixianDataSelectItembt1     52061  //提现数据选项
#define EnTixianDataSelectItembt2     52062  //提现数据选项
#define EnTixianDataSelectItembt3     52063  //提现数据选项
#define EnTixianDataSelectItembt4     52064  //提现数据选项
#define EnTiXianDataZhifuBttag         52100  //提现数据支付
#define EnTiXianDataWeiZhifuBttag         52101  //提现数据未支付
#define EnTimeSelectTextfieldtag1      52201    //时间选择器开始
#define EnTimeSelectTextfieldtag2      52202    //时间选择器结束

#define EnSortMoreSelectItembt1     52301  //排序更多选项
#define EnSortMoreSelectItembt2     52302  //排序更多选项
#define EnSortMoreSelectItembt3     52303  //排序更多选项
#define EnSortMoreTimeSelectViewTag1   52401 //排行更多选择分销商时的view

#define EnWaterListSelectItembt1       52451
#define EnWaterListSelectItembt2       52452
#define EnWaterListSelectItembt3       52453

#define EnWaterHpFunctionRebateBt    52501 //水电工个人主页扫码返利更多
#define EnWaterHpFunctionMettingBt    52502 //水电工个人主页会议更多
#define EnWaterHpFunctionServiceBt    52503 //水电工个人主页预约服务更多
#define EnWaterHpFunctionSocialBt    52504 //水电工个人主页社交更多
#define EnWaterHpFunctionLoginBt    52505 //水电工个人主页登录统计更多
#define EnWaterScanCodeBt        52601  //水电工管理 扫码
#define EnWaterTiXianBt        52602  //水电工管理 提现

#define EnWaterCheckInSelectItembt1     52701  //水电工签到历史
#define EnWaterCheckInSelectItembt2     52702  //水电工签到历史
#define EnWaterCheckInSelectItembt3     52703  //水电工签到历史
#define EnWaterCheckInDetailSelectItembt1     52800  //水电工签到详情

#define EnWaterMettingSelectItembt1     52901 //水电工会议编号选择
#define EnWaterMettingSelectItembt2     52902 //水电工会议区域选择
#define EnWaterMettingSelectItembt3     52903 //水电工会议状态选择
#define EnWaterMettingSelectItembt4     52904 //水电工会议时间选择

#define EnWaterMettingCheckInSelectItembt1     53001  //水电工会议签到历史
#define EnWaterMettingCheckInSelectItembt2     53002  //水电工会议签到历史
#define EnWaterMettingCheckInSelectItembt3     53003  //水电工会议签到历史

#define EnWaterMettingCheckInListSelectItembt1     53101  //水电工会议签到历史
#define EnWaterMettingCheckInListSelectItembt2     53102  //水电工会议签到历史
#define EnWaterMettingCheckInListSelectItembt3     53103  //水电工会议签到历史

#define EnUserRegiestTextfield1     53201  //用户选择类型
#define EnUserRegiestTextfield2     53202  //用户选择类型
#define EnUserRegiestTextfield3     53203  //用户选择类型
#define EnUserRegiestTextfield4     53204  //用户选择类型
#define EnUserRegiestGetCodeBt5     53205  


#define EnUserMakeUpTextfield1   53301  //用户补全资料
#define EnUserMakeUpTextfield2   53302  //用户补全资料
#define EnUserMakeUpTextfield3   53303  //用户补全资料
#define EnUserMakeUpTextfield4   53304  //用户补全资料
#define EnUserMakeUpTextfield5   53305  //用户补全资料
#define EnUserMakeUpTextfield6   53306  //用户补全资料
#define EnUserMakeUpTextfield7   53307  //用户补全资料
#define EnUserMakeUpImageView1   53308


#define EnUserAuthorizaTextfield1  53401  //用户认证
#define EnUserAuthorizaTextfield2  53402  //用户认证
#define EnUserAuthorizaTextfield3  53403  //用户认证
#define EnUserAuthorizaTextfield4  53404  //用户认证
#define EnUserAuthorizaTextfield5  53405  //用户认证
#define EnUserAuthorizaTextfield6  53406  //用户认证

#define EnUserAuthorizaImageview1  53501  //用户认证
#define EnUserAuthorizaImageview2  53502  //用户认证
#define EnUserAuthorizaImageview3  53503  //用户认证
#define EnUserAuthorizaImageview4  53504  //用户认证
#define EnUserAuthorizaImageview5  53505  //用户认证

#define EnYLImageViewTag     54600

#define EnFocusFunctionButton     54700

#define EnTbeaCompanyInstroduceSelect1     54801
#define EnTbeaCompanyInstroduceSelect2     54802
#define EnTbeaCompanyInstroduceSelect3     54803

#define EnTbeaNewsListSelect1     54901
#define EnTbeaNewsListSelect2     54902
#define EnTbeaNewsListSelect3     54903

#define EnTbeaProductInstroduceSelect1     55001
#define EnTbeaProductInstroduceSelect2     55002
#define EnTbeaProductInstroduceSelect3     55003

#define EnTbeaProductDetailSelect1     55101
#define EnTbeaProductDetailSelect2     55102

#define EnNctlSearchViewTag     55200

#define EnModifyBindingOldGetCodeBtTag  55300//修改电话发送按钮
#define EnModifyBindingOldTelTextfieldTag  55301 //修改电话text
#define EnModifyBindingOldCodeTextfieldTag  55302 //修改电话text

#define EnModifyPwdOldPwdTextfield   55400 
#define EnModifyPwdNewPwdTextfield1   55401
#define EnModifyPwdNewPwdTextfield2   55402

#define EnAddAddressTextfieldTag1    55451  //新增地址
#define EnAddAddressTextfieldTag2    55452  //新增地址
#define EnAddAddressTextfieldTag3    55453  //新增地址
#define EnAddAddressTextfieldTag4    55454  //新增地址

#define EnSonAccountMangerTextfieldTag1 55501 //子账号管理1
#define EnSonAccountMangerTextfieldTag2 55502 //子账号管理1
#define EnSonAccountMangerTextfieldTag3 55503 //子账号管理1
#define EnSonAccountMangerTextfieldTag4 55504 //子账号管理1
#define EnSonAccountMangerTextfieldTag5 55505 //子账号管理1
#define EnSonAccountMangerTextfieldTag6 55506 //子账号管理1
#define EnSonAccountMangerTextfieldTag7 55507 //子账号管理1
#define EnSonAccountMangerTextfieldTag8 55508 //子账号管理1

#define EnMyAttentionButtonSelect1  55550  //我的关注选项
#define EnMyAttentionButtonSelect2  55551  //我的关注选项
#define EnMyAttentionButtonSelect3  55552  //我的关注选项

#define EnLoginPhoneTextfield   55600   // 登录
#define EnLoginPwdTextfield   55601   // 登录

#define EnMemberMangerSelectItem1 55650 
#define EnMemberMangerSelectItem2 55652

#define EnMemberSelectUsertypeImageview1 55700 
#define EnMemberSelectUsertypelabel1 55701
#define EnMemberSelectUsertypelabel2 55702

#define EnAreaSelectCellViewTag  55900

#define EnCreateQRCodeListSelectItem1   55600

#define EnCreateQRCodeListSelectItem2   55601
#define EnTiXianDataHeaderViewTag  55650

#define EnTiXianDataHeaderLabelMoneyTag  55651

#define EnTiXianDataHeaderLabelFlagTag  55652

#define EnMallStoreFunctionButtonTag 55700

#define EnHpNavigationViewTag  55750 

#define EnPayPopConfirmViewBtTag  55780 

#define EnMallStoreMangerLinkTypeSelectItem1 56001
#define EnMallStoreMangerLinkTypeSelectItem2 56002
#define EnMallStoreMangerLinkTypeSelectItem3 56003
#define EnMallStoreMangerLinkTypeSelectItem4 56004
#define EnMallStoreMangerLinkTypeSelectItem5 56005
#define EnMallStoreLinkTypeSelectValue       56010 
#define EnScanQRCodeInputCodeTextfieldTag    56020
#define EnMyKyNowTiXianMoneyLabelTag         56025
#define EnMeTiXianMoneyTextFieldTag         56030
#define EnMyInOutPutListHeaderViewTag       56040 
#define EnWaterMettingJoinMemberNumTag      56050
#define EnComWaterJXSSelectCellTag    56060
#define EnComWaterJXSSelectNumberTag    56070
#define EnComWaterJoinMemberNumberValue 56080
#define EnComMettingScheduleLabelValue  56090
#define EnComMettingScheduleTextviewTag  56100
#define EnComWaterTimeSelectLabelTag  56110
#define EnHpFunctionCellMoreBtTag  56120
#define EnWaterPersonScanTiXianMoneyView 56130
#define EnWaterMettingpreparaddresstextfieldtag 56140
#define EnWaterMettingPicArrmentImageViewTag 56200
#define EnUserCenterSonAccountHeaderPicTag 56300
#define EnSonAccountFunctionAuthorBtTag  56400
#define EnAttentionSelectItemBtTag 56500
#define EnSettingCustomMemoryRemove 56600
#define EnSearchHotWordBtTag  56700
#define EnSearchTextfieldCityTag1  56800
#define EnSearchTextfieldCityTag3 56801
#define EnSearchTextfieldCityTag2 56802
#define EnNearSearchViewBt 58820
#define IndicatorTag 29999
#define EnMallStoreRemoveSpeModuleListBtTag   58830
#define EnMallStoreAddNewGoodsTextfield1 58901
#define EnMallStoreAddNewGoodsTextfield2 58902
#define EnMallStoreAddNewGoodsTextfield3 58903
#define EnMallStoreAddNewGoodsTextfield4 58904
#define EnMallStoreAddNewGoodsTextfield5 58905
#define EnMallStoreAddNewGoodsTextfield6 58906
#define EnMallStoreAddNewGoodsTextfield7 58907
#define EnMallStoreAddNewGoodsTextfield8 58908
#define EnMallStoreAddNewGoodsTextfield9 58909
#define EnMallStoreAddNewGoodsTextfield10 58910
#define EnMallStoreAddNewCycleAdNameTextfield  59000
#define EnMallStoreDynamicDeleteBtTag  59100

#define EnWaterMettingPicArrmentDeleteBtTag 60200

#define EnTbeaHpViewTypeBtTag  60300

#define EnTixianHistoryViewTopView 60400

