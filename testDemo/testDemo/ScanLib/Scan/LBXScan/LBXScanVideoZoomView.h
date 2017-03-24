//
//  LBXScanVideoZoomView.h
//

#import <UIKit/UIKit.h>

@interface LBXScanVideoZoomView : UIView

/**
 @brief 控件值变化
 */
@property (nonatomic, copy) void (^block)(float value);

- (void)setMaximunValue:(CGFloat)value;
@end
