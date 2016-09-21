//
//  QZFilterDataTableView.h
//  QZConditionFilterViewDemo
//
//  Created by MrYu on 16/9/21.
//  Copyright © 2016年 yu qingzhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QZFilterDataTableViewDelegate <NSObject>

@optional
// 选中筛选项触发
-(void)choseSort:(NSArray *)sortAry;

@end

@interface QZFilterDataTableView : UITableView

@property (nonatomic,weak) id<QZFilterDataTableViewDelegate> sortDelegate;
/** 选中的数据*/
@property (nonatomic,strong) NSMutableArray *sortArr;
/** 选中的cell
 *  对外接口 可能会有用的情况
 *  参数为需要被选中的cell显示的string
 */
@property (nonatomic,copy) NSString *selectedCell;

@property (nonatomic,strong) NSArray *dateArray;

/** didSelect处理好数据调用此方法*/
-(void)bindChoseArraySort:(NSArray *)sortAry;

-(void)dismiss;

@end
