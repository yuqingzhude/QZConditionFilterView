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

@interface ViewController ()

@property (nonatomic, strong) QZConditionFilterView *conditionFilterView;
@property (nonatomic, strong) NSArray *filtersArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ListView";
    self.view.backgroundColor = [UIColor whiteColor];

    _conditionFilterView = [QZConditionFilterView conditionFilterViewWithListCount:3 FilterBlock:^(NSArray<NSString *> *filters) {
        self.filtersArray = filters;
        NSLog(@"%@", filters);
    }];
    _conditionFilterView.y = SafeAreaTopHeight;
    // 设置初次加载显示的默认数据 即初次加载还没有选择操作之前要显示的标题数据
    NSArray *titlesArray = @[@"综合排序", @"销量最高", @"信用最高"];
    // 传入数据源，对应tableView顺序
    NSArray *dataArray1 = @[@"1-1",@"1-2",@"1-3",@"1-4"];
    NSArray *dataArray2 = @[@"2-1",@"2-2",@"2-3",@"2-4",@"2-5"];
    NSArray *dataArray3 = @[@"3-1",@"3-2",@"3-3",];
    NSArray *dataArray4 = @[@"3-1",@"3-2",@"3-3",@"3-4",@"3-5"];
    _conditionFilterView.dataArrays = @[dataArray1, dataArray2, dataArray3];
    [_conditionFilterView updateFilterTableTitleWithTitleArray:titlesArray];
    [self.view addSubview:_conditionFilterView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
