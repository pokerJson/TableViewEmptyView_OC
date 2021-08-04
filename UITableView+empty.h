//
//  UITableView+empty.h
//  UItableViewDefaultView
//
//  Created by dzc on 2021/8/4.
//

#import <UIKit/UIKit.h>
#import "NoDataEmptyView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^RefreshDataBlock)(void);

typedef enum : NSUInteger {
    NoWifi,
    NoData,
    NoDingDan,
} NoDataType;

@interface UITableView (empty)

@property (nonatomic, strong) NoDataEmptyView *emptyView;

@property (nonatomic,assign)NoDataType type;

@property(nonatomic,copy)RefreshDataBlock refresh;

@end

NS_ASSUME_NONNULL_END
