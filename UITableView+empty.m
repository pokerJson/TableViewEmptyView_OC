//
//  UITableView+empty.m
//  UItableViewDefaultView
//
//  Created by dzc on 2021/8/4.
//

#import "UITableView+empty.h"

#import <objc/message.h>

static NSString *const NoDataEmptyViewKey = @"NoDataEmptyViewKey";
static NSString *const typeKey = @"typeKey";
static NSString *const refreshKey = @"refreshKey";


@implementation UITableView (empty)

#pragma mark - 交换方法 hook
+(void)load {
    Method originMethod = class_getInstanceMethod(self, @selector(reloadData));
    Method currentMethod = class_getInstanceMethod(self, @selector(my_reloadData));
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(originMethod, currentMethod);
    });
}

#pragma mark - 刷新数据
-(void)my_reloadData {
    [self my_reloadData];
    [self fillEmptyView];
}

#pragma mark - 填充空白页
-(void)fillEmptyView {
    
    NSInteger sections = 1;
    NSInteger rows = 0;
    
    id <UITableViewDataSource> dataSource = self.dataSource;
    
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        
        sections = [dataSource numberOfSectionsInTableView:self];
        
        if ([dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            for (int i=0; i<sections; i++) {
                rows += [dataSource tableView:self numberOfRowsInSection:i];
            }
        }
    }
    
    __weak __typeof(&*self)weakSelf = self;
    
    if (rows == 0) {
        if (![self.subviews containsObject:self.emptyView]) {
            self.emptyView = [[NoDataEmptyView alloc] initWithFrame:self.bounds];
            self.emptyView.refresh = ^{
                NSLog(@"刷新");
                if (weakSelf.refresh) {
                    weakSelf.refresh();
                }
            };
            [self addSubview:self.emptyView];
            switch (self.type) {
                case NoWifi: // 没网
                {
                    [self.emptyView changeTtile:@"没网"];
                }
                    break;
                case NoData:
                {
                    [self.emptyView changeTtile:@"暂无数据"];
                }
                    break;
                default:{
                    [self.emptyView changeTtile:@"暂无订单"];
                }
                    break;
            }
        }
    }
    else{
        [self.emptyView removeFromSuperview];
    }
}

#pragma mark - 关联对象--类型
- (void)setType:(NoDataType)type{
    objc_setAssociatedObject(self, &typeKey, @(type), OBJC_ASSOCIATION_ASSIGN);
}
- (NoDataType)type{
    return [objc_getAssociatedObject(self, &typeKey) intValue] ;
}

#pragma mark - 关联对象--block
- (void)setRefresh:(RefreshDataBlock)refresh{
    objc_setAssociatedObject(self, &refreshKey, refresh, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (RefreshDataBlock)refresh{
    return objc_getAssociatedObject(self, &refreshKey);
}

#pragma mark - 关联对象--缺省图
-(void)setEmptyView:(NoDataEmptyView *)emptyView {
    objc_setAssociatedObject(self, &NoDataEmptyViewKey, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NoDataEmptyView *)emptyView {
    return objc_getAssociatedObject(self, &NoDataEmptyViewKey);
}

@end
