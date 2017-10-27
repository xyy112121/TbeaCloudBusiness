//
//  FDTimeChooser.h
//  timePicker
//
//  Created by xuansa on 2017/1/9.
//  Copyright © 2017年 xuansa. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kScaleFrom_iPhone5_Desgin(_X_) (_X_ * (kScreen_Width/320))

@class FDCycleScrollView;
@protocol FDCycleScrollViewDelegate <NSObject>

@optional
- (void)didClickPage:(FDCycleScrollView *)csView atIndex:(NSInteger)index;

- (void)scrollViewDidChangeNumber;

@end

@protocol FDCycleScrollViewDataSource <NSObject>

- (NSInteger)numberOfPages:(FDCycleScrollView *)scrollView;

- (UIView *)pageAtIndex:(NSInteger)index andScrollView:(FDCycleScrollView *)scrollView;

@end
@interface FDCycleScrollView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    NSInteger _totalPages;
    NSInteger _curPage;
    
    NSMutableArray *_curViews;
}
@property (nonatomic,readonly) UIScrollView *scrollView;
@property(assign, nonatomic) NSInteger currentPage;
@property (nonatomic, weak, setter = setDataource:) id<FDCycleScrollViewDataSource> datasource;
@property (nonatomic, weak, setter = setDelegate:)  id<FDCycleScrollViewDelegate> delegate;

- (void)setCurrentSelectPage:(NSInteger)selectPage;

- (void)reloadData;

- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;

@end

typedef enum {
    DatePickerDateMode,
    DatePickerTimeMode,
    DatePickerDateTimeMode,
    DatePickerYearMonthMode,
    DatePickerMonthDayMode,
    DatePickerHourMinuteMode,
    DatePickerDateHourMinuteMode
} DatePickerMode;

typedef void(^DatePickerCompleteAnimationBlock)(BOOL Complete);

typedef void(^ClickedOkBtn)(NSString *dateTimeStr);

@class FDTimeChooser;

@protocol FDTimeChooserDelegate <NSObject>

- (void)timeChooser:(FDTimeChooser *)timeChooser didSelectTimeString:(NSString *)timeString;

@end

@interface FDTimeChooser : UIView<FDCycleScrollViewDataSource,FDCycleScrollViewDelegate>
@property (nonatomic, weak) id<FDTimeChooserDelegate> fdDelegate;
@property (nonatomic,strong) ClickedOkBtn clickedOkBtn;
@property(assign, nonatomic) DatePickerMode datePickerMode;

@property (nonatomic, strong) UIView   *topView;
@property (nonatomic, strong) UIView   *line;
@property (nonatomic, strong) UIButton *okBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UILabel *selectedLabel;

@property (nonatomic,assign) NSInteger maxYear;
@property (nonatomic,assign) NSInteger minYear;

- (instancetype)initWithDefaultDatetime:(NSDate*)dateTime;
- (instancetype)initWithDatePickerMode:(DatePickerMode)datePickerMode defaultDateTime:(NSDate*)dateTime;

- (void)showInSuperview:(UIView *)superview;

@end

@interface UIColor (FDTimeChooser)
@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel;
@property (nonatomic, readonly) BOOL canProvideRGBComponents;
@property (nonatomic, readonly) CGFloat red; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat green; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat blue; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat white; // Only valid if colorSpaceModel == kCGColorSpaceModelMonochrome
@property (nonatomic, readonly) CGFloat alpha;
@property (nonatomic, readonly) UInt32 rgbHex;

+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert andAlpha:(CGFloat)alpha;
@end
