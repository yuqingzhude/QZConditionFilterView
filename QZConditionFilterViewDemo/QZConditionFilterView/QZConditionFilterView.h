//
//  QZConditionFilterView.h
//  QZConditionFilterViewDemo
//
//  Created by MrYu on 16/9/21.
//  Copyright © 2016年 yu qingzhu. All rights reserved.
//

#import <UIKit/UIKit.h>
/// tableView cell 类型的筛选
typedef void (^FilterBlock)(NSArray<NSString *> *filters);

@interface QZConditionFilterView : UIView
/// 下拉tableView datasource
@property (nonatomic, strong) NSArray<NSArray *> *dataArrays;

/// 是否展示
@property (nonatomic,readonly, assign) BOOL isShow;

/// 创建实例 with block
+ (instancetype)conditionFilterViewWithListCount:(NSInteger)listCount FilterBlock:(FilterBlock)filterBlock;

/// 更新显示三个小标题
- (void)updateFilterTableTitleWithTitleArray:(NSArray<NSString*> *)titleArray;

/// 消失
- (void)dismiss;

@end
