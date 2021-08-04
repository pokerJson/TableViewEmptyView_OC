//
//  NoDataEmptyView.m
//  UItableViewDefaultView
//
//  Created by dzc on 2021/8/4.
//

#import "NoDataEmptyView.h"

@interface NoDataEmptyView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel     *label;
@property (nonatomic, strong) UIButton     *btn;
@end

@implementation NoDataEmptyView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.imageView.image = [UIImage imageNamed:@"img_kby"];
    self.imageView.center = self.center;
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.label.text = @"暂无数据";
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.center = CGPointMake(self.imageView.center.x, CGRectGetMaxY(self.imageView.frame)+40);
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = CGRectMake(0, 0, 100, 40);
    [self.btn setTitle:@"点击刷新" forState:UIControlStateNormal];
    self.btn.backgroundColor = [UIColor redColor];
    self.btn.center = CGPointMake(self.label.center.x, CGRectGetMaxY(self.label.frame)+40);
    [self.btn addTarget:self action:@selector(refreshBtnCLick) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:self.imageView];
    [self addSubview:self.label];
    [self addSubview:self.btn];
}
- (void)refreshBtnCLick{
    if (self.refresh) {
        self.refresh();
    }
}
- (void)changeTtile:(NSString *)str{
    self.label.text = str;
    self.btn.hidden = YES;
}
@end
