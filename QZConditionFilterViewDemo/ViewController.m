//
//  ViewController.m
//  QZConditionFilterViewDemo
//
//  Created by MrYu on 16/9/21.
//  Copyright © 2016年 yu qingzhu. All rights reserved.
//

#import "ViewController.h"
#import "QZConditionFilterView.h"
#import "UIView+QZExtension.h"

@interface ViewController () {

    NSString *_filter1String;
    NSString *_filter2String;
    NSString *_filter3String;
    
    QZConditionFilterView *_conditionFilterView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ListView";
    self.view.backgroundColor = [UIColor whiteColor];

    
    _conditionFilterView = [QZConditionFilterView conditionFilterViewWithFilterBlock:^(NSString *filter1, NSString *filter2, NSString *filter3) {
        // 选择新的筛选条件触发
        _filter1String = filter1;
        _filter2String = filter2;
        _filter3String = filter3;
        [self startRequest];
    }];
    _conditionFilterView.y = SafeAreaTopHeight;
    // 设置初次加载显示的默认数据 即初次加载还没有选择操作之前要显示的标题数据
    NSArray *titlesArray = @[@"综合排序", @"销量最高", @"信用最高"];
    // 传入数据源，对应三个tableView顺序
    _conditionFilterView.dataArray1 = @[@"1-1",@"1-2",@"1-3",@"1-4",@"1-5"];
    _conditionFilterView.dataArray2 = @[@"2-1",@"2-2",@"2-3",@"2-4",@"2-5"];
    _conditionFilterView.dataArray3 = @[@"3-1",@"3-2",@"3-3",@"3-4",@"3-5"];
    [_conditionFilterView updateFilterTableTitleWithTitleArray:titlesArray];
    [self.view addSubview:_conditionFilterView];
    
}

- (void)startRequest {
    NSString *source1 = _filter1String;
    NSString *source2 = _filter2String;
    NSString *source3 = _filter3String;
    // 可以用字符串在dic换成对应英文key
    NSLog(@"\n第一个条件:%@\n  第二个条件:%@\n  第三个条件:%@\n",source1,source2,source3);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
