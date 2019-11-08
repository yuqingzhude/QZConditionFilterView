//
//  QZFilterTableView.m
//  QZConditionFilterViewDemo
//
//  Created by MrYu on 16/9/21.
//  Copyright © 2016年 yu qingzhu. All rights reserved.
//

#import "QZFilterTableView.h"
#import "QZFilterCell.h"
#import "UIView+QZExtension.h"

@interface QZFilterTableView()<UITableViewDelegate,UITableViewDataSource> {
    NSInteger _selectedIndex;   // 记录被选中的cell
}
@end

@implementation QZFilterTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _dataArray = [[NSMutableArray alloc] init];
        self.backgroundColor=[UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[QZFilterCell class] forCellReuseIdentifier:@"cell"];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QZFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [QZFilterCell filterCell];
    }
    if (indexPath.row == _selectedIndex) {
        cell.markView.hidden = NO;
        cell.textLabel.textColor = UIColorFromRGB(0x00a0ff);
    }else{
        cell.markView.hidden = YES;
        cell.textLabel.textColor = UIColorFromRGB(0x333333);
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // reset other cells color
    for (NSInteger i = 0; i < _dataArray.count; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        QZFilterCell *cell = [tableView cellForRowAtIndexPath:path];
        cell.markView.hidden = YES;
        cell.textLabel.textColor = UIColorFromRGB(0x333333);
    }
    
    QZFilterCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.markView.hidden = NO;
    cell.textLabel.textColor = UIColorFromRGB(0x00a0ff);
    [self bindSelectedItem:_dataArray[indexPath.row]];
    _selectedIndex = indexPath.row;
}

- (void)bindSelectedItem:(NSString *)selectedItem {
    if (self.chooseDelegate && [self.chooseDelegate respondsToSelector:@selector(chooseFilterItem:)]) {
        [self.chooseDelegate chooseFilterItem:selectedItem];
    }
}

#pragma mark - 设置默认显示
- (void)setSelectedItem:(NSString *)selectedItem {
    // 显示View之前会给sortView.selectedItem赋值 继而处理选中cell reload
    _selectedItem = selectedItem;
    // 处理默认显示
    _selectedIndex = [self.dataArray indexOfObject:_selectedItem];
    if ([_selectedItem isEqualToString:@""] || _selectedItem == nil) {
        _selectedIndex = 0;
    }
    
    [self reloadData];
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    self.height = MIN(_dataArray.count, 8) * 44;
}

- (void)dismiss {
    [self removeFromSuperview];
}

@end
