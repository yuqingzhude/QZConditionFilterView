//
//  QZConditionFilterView.h
//  QZConditionFilterViewDemo
//
//  Created by MrYu on 16/9/21.
//  Copyright © 2016年 yu qingzhu. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 三个tableView cell 类型的筛选*/

typedef void (^FilterBlock)(BOOL isFilter, NSArray *dataSource1Ary,NSArray *dataSource2Ary, NSArray *dataSource3Ary);

@interface QZConditionFilterView : UIView

/** 原本用于内部设置createSubView时设置显示默认数据，现在通过外部设置默认，如果有需要可以在内部设置，暂时为无用变量*/
@property (nonatomic,strong) NSArray *sortTitleAry;
/** 对应三个下拉tableView的数据源*/
@property (nonatomic,strong) NSArray *dataAry1;
@property (nonatomic,strong) NSArray *dataAry2;
@property (nonatomic,strong) NSArray *dataAry3;

/**是否展示*/
@property (nonatomic,readonly,assign)BOOL isShow;

/** 创建实例 with block*/
+(instancetype)conditionFilterViewWithFilterBlock:(FilterBlock)filterBlock;

/** 刷新标题字*/
-(void)bindChoseArrayDataSource1:(NSArray *)dataSource1Ary DataSource2:(NSArray *)dataSource2Ary DataSource3:(NSArray *)dataSource3Ary;

/** 外部手动筛选加载*/
-(void)choseSortFromOutsideWithFirstSort:(NSArray *)firstAry WithSecondSort:(NSArray *)secondAry WithThirdSort:(NSArray *)thirdAry;

/** 消失*/
-(void)dismiss;

/** 网络请求key value从这取*/
@property (nonatomic,strong) NSDictionary *keyValueDic;

@end



// README 16/09/22
// 相似存储数组参数解释：
//
// QZConditionFilterView.h
//
// /** 外部传入对应三个下拉tableView的DataSource*/
//
//@property (nonatomic,strong) NSArray *dataAry1;
//
//@property (nonatomic,strong) NSArray *dataAry2;
//
//@property (nonatomic,strong) NSArray *dataAry3;
//
// 暂时为无用变量，用于内部设置默认数据 [1] [2] [3] 现在情况比较简单，外部赋初值
//
//@property (nonatomic,strong) NSArray *sortTitleAry;
//
//QZConditionFilterView.m
//
// 存储 tableView didSelected数据 数据来源：FilterDataTableView
//
//NSArray *_dataSource1;
//
//NSArray *_dataSource2;
//
//NSArray *_dataSource3;
//
//ViewController.m
//
// *存储* 网络请求url中的筛选项 数据来源：View中_dataSource1或者一开始手动的初值
//
//NSArray *_selectedDataSource1Ary;
//
//NSArray *_selectedDataSource2Ary;
//
//NSArray *_selectedDataSource3Ary;
