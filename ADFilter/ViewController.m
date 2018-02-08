//
//  ViewController.m
//  ADFilter
//
//  Created by 马乾征 on 2017/8/30.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import "ViewController.h"
#import "ADFilterHeader.h"
@interface ViewController ()<ADFilterDelegate, ADFilterDataSource>
@property (nonatomic, strong)ADFilter *filter;
@property (nonatomic, strong)NSArray *titles;
@property (nonatomic, copy)NSString *meeee;
@end

@implementation ViewController

- (void)viewDidLoad {
    _meeee = @"huahua";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [super viewDidLoad];
    _filter = [[ADFilter alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 36)];
    [self.view addSubview:_filter];
    _filter.delegate = self;
    _filter.dataSource = self;
    ADFilterMenu *menu = [ADFilterFactory singleMenuWithTitle:@"你好"];
    ADFilterMenu *menu2 = [ADFilterFactory doubleMenuWithTitle:@"double"];
    ADFilterMenu *menu3 = [ADFilterFactory integratedMenuWithTitle:@"交换机"];
    [_filter addMenu:menu];
    [_filter addMenu:menu2];
    [_filter addMenu:menu3];
    [_filter reloadData];
}

#pragma mark - menu delegate

- (NSInteger)filter:(ADFilter *)filter numberOfSectionInZone:(NSInteger)zone{
    if (zone == 2) {
        return 1;
    }
    return 3;
}

- (NSInteger)filter:(ADFilter *)filter numberOfItemInSection:(NSInteger)section zone:(NSInteger)zone {
    if (zone == 2) {
        return 3;
    }
    return 8;
}

- (NSString *)filter:(ADFilter *)filter itemTitleAtSection:(NSInteger)section zone:(NSInteger)zone{
    if (zone == 2) {
        return @"综合服务";
    }
    return @"别来别去";
}

- (NSString *)filter:(ADFilter *)filter itemTitleAtIndexPath:(NSIndexPath *)indexPath zone:(NSInteger)zone {
    if (zone == 0) {
        NSString *tt = [NSString stringWithFormat:@"%ld - %ld zozooz", (long)indexPath.row, (long)indexPath.section];
        return tt;
    }
    return _meeee;
}

- (void)filter:(ADFilter *)filter didSelectedItemAtZone:(NSInteger)zone {
    ADFilterMenu *menu = [filter menuWithZone:zone];
    if (zone == 1) {
        [menu selectedItemAtSections:@[@0]];
    }
    else {
        [menu selectedItemAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]]];
    }
}

- (void)filter:(ADFilter *)filter didSelectedItemAtIndexPath:(NSIndexPath *)indexPath zone:(NSInteger)zone {
    NSLog(@"%ld", (long)indexPath.row);
    if (zone == 1) {
        [filter setTitle:@"zzzass" zone:zone];
        [filter dismissMenuViewAtZone:zone animation:NO];
    }
    ADFilterMenu *menu = [filter menuWithZone:zone];
    NSLog(@"seeeee : %@", [menu indexPathsForSelectedRows]);
}

- (void)filter:(ADFilter *)filter didSelectedItemAtSection:(NSInteger)section zone:(NSInteger)zone {
    _meeee = @"上天下地";
    ADFilterMenu *menu = [filter menuWithZone:zone];
    NSLog(@"seeeee : %@", [menu sectionsForSelected]);
}
@end
