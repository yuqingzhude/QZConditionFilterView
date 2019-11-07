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
    // *存储* 网络请求url中的筛选项 数据来源：View中_dataSource1或者一开始手动的初值
    NSArray *_selectedDataSource1Ary;
    NSArray *_selectedDataSource2Ary;
    NSArray *_selectedDataSource3Ary;
    
    QZConditionFilterView *_conditionFilterView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ListView";
    self.view.backgroundColor = [UIColor whiteColor];

    // FilterBlock 选择下拉菜单选项触发
    _conditionFilterView = [QZConditionFilterView conditionFilterViewWithFilterBlock:^(BOOL isFilter, NSArray *dataSource1Ary, NSArray *dataSource2Ary, NSArray *dataSource3Ary) {
        if (isFilter) {
             //网络加载请求 存储请求参数
            _selectedDataSource1Ary = dataSource1Ary;
            _selectedDataSource2Ary = dataSource2Ary;
            _selectedDataSource3Ary = dataSource3Ary;
        }
        // 开始网络请求
        [self startRequest];
    }];
    
    
    _conditionFilterView.y += 64;
    
    // 设置初次加载显示的默认数据 即初次加载还没有选择操作之前要显示的标题数据
    _selectedDataSource1Ary = @[@"默认条件"];
    _selectedDataSource2Ary = @[@"默认条件"];
    _selectedDataSource3Ary = @[@"默认条件"];
    
    // 传入数据源，对应三个tableView顺序
    _conditionFilterView.dataArray1 = @[@"1-1",@"1-2",@"1-3",@"1-4",@"1-5"];
    _conditionFilterView.dataArray2 = @[@"2-1",@"2-2",@"2-3",@"2-4",@"2-5"];
    _conditionFilterView.dataArray3 = @[@"3-1",@"3-2",@"3-3",@"3-4",@"3-5"];
   
    // 初次设置默认显示数据(标题)，内部会调用block 进行第一次数据加载
    [_conditionFilterView bindChoseArrayDataSource1:_selectedDataSource1Ary DataSource2:_selectedDataSource2Ary DataSource3:_selectedDataSource3Ary];
    
    [self.view addSubview:_conditionFilterView];
    
}

- (void)startRequest {

    NSString *source1 = [NSString stringWithFormat:@"%@",_selectedDataSource1Ary.firstObject];
    NSString *source2 = [NSString stringWithFormat:@"%@",_selectedDataSource2Ary.firstObject];
    NSString *source3 = [NSString stringWithFormat:@"%@",_selectedDataSource3Ary.firstObject];
    // 可以用字符串在dic换成对应英文key
    
    NSLog(@"\n第一个条件:%@\n  第二个条件:%@\n  第三个条件:%@\n",source1,source2,source3);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
