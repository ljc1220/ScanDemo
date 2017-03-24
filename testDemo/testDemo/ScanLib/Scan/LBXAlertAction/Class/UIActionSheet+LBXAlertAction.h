//
//  UIActionSheet+Block.h
//


#import <UIKit/UIKit.h>


@interface UIActionSheet (LBXAlertAction)<UIActionSheetDelegate>


- (void)showInView:(UIView *)view block:(void(^)(NSInteger idx,NSString* buttonTitle))block;

@end
