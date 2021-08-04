//
//  NoDataEmptyView.h
//  UItableViewDefaultView
//
//  Created by dzc on 2021/8/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RefreshBlock)(void);

@interface NoDataEmptyView : UIView

//根据type不同更改缺省内容
- (void)changeTtile:(NSString *)str;

@property(nonatomic,copy)RefreshBlock refresh;

@end

NS_ASSUME_NONNULL_END
