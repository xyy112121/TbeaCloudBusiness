//
//  FDCityPicker.h
//  timePicker
//
//  Created by xuansa on 2017/1/10.
//  Copyright © 2017年 xuansa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDTool.h"

NS_ASSUME_NONNULL_BEGIN
@class FDCityPicker;
@protocol FDCityPickerDelegate <NSObject>

- (void)pickerAreaer:(FDCityPicker *)pickerAreaer province:(NSString *)province city:(NSString *)city area:(NSString *)area;

@end

@interface FDCityPicker : UIButton

@property(nonatomic, weak) id<FDCityPickerDelegate> delegate ;

- (instancetype)initWithDelegate:(nullable id<FDCityPickerDelegate>)delegate;

@property (nonatomic, strong, nullable) FDTool *toolbar;

- (void)show;


@end
NS_ASSUME_NONNULL_END
