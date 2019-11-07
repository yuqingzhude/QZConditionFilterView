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
- (void)chooseFilterItem:(NSString *)item;

@end

@interface QZFilterTableView : UITableView

@property (nonatomic,weak) id<QZFilterTableViewDelegate> chooseDelegate;
// 对外提供设置能力,显示当前选中cell
@property (nonatomic,copy) NSString *selectedItem;

@property (nonatomic,strong) NSArray *dataArray;

- (void)dismiss;

@end
