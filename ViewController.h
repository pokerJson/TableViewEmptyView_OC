//
//  ViewController.h
//  UItableViewDefaultView
//
//  Created by dzc on 2021/8/4.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) UIButton       *haveDataBtn;
@property (nonatomic, strong) UIButton       *clearDataBtn;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

