//
//  QZFilterTableView.h
//  QZConditionFilterViewDemo
//
//  Created by MrYu on 16/9/21.
//  Copyright © 2016年 yu qingzhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QZFilterTableViewDelegate <NSObject>

@optional
// 选中筛选项触发
- (void)choseSort:(NSArray *)sortAry;

@end

@interface QZFilterTableView : UITableView

@property (nonatomic,weak) id<QZFilterTableViewDelegate> chooseDelegate;
/// 选中的数据
@property (nonatomic,strong) NSMutableArray *sortArr;

@property (nonatomic,copy) NSString *selectedCell;

@property (nonatomic,strong) NSArray *dateArray;

/// didSelect处理好数据调用此方法
- (void)bindChoseArraySort:(NSArray *)sortAry;

- (void)dismiss;

@end
