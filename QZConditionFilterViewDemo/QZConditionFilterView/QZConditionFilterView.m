//
//  QZConditionFilterView.m
//  QZConditionFilterViewDemo
//
//  Created by MrYu on 16/9/21.
//  Copyright © 2016年 yu qingzhu. All rights reserved.
//

#import "QZConditionFilterView.h"
#import "QZFilterTableView.h"
#import "UIView+QZExtension.h"

#define DefaultFilterNum    3
#define DefaultFont         [UIFont systemFontOfSize:13]

@interface QZConditionFilterView()<QZFilterTableViewDelegate>

@property (nonatomic, strong) NSMutableArray<UIButton *> *filterButtons;
@property (nonatomic, strong) NSMutableArray<NSString *> *choosedTableItems;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, assign) NSInteger listCount;
@property (nonatomic,strong) FilterBlock filterBlock;
@property (nonatomic, strong) QZFilterTableView *filterTableView;

@end


@implementation QZConditionFilterView

+ (instancetype)conditionFilterViewWithListCount:(NSInteger)listCount FilterBlock:(FilterBlock)filterBlock {
    QZConditionFilterView *conditionFilter = [[QZConditionFilterView alloc] initWithFrame:CGRectMake(0, 0, QZ_SCREEN_WIDTH, 40)];
    conditionFilter.filterBlock=filterBlock;
    conditionFilter.listCount = listCount;
    [conditionFilter createSubView];
    [conditionFilter setupData];
    return conditionFilter;
}

- (void)createSubView {
    self.backgroundColor=[UIColor whiteColor];
    self.isShow = NO;
    
    if (self.listCount <= 0) {
        return;
    }
    
    self.filterButtons = [NSMutableArray array];
    
    NSInteger middleLineCount = self.listCount - 1;
    CGFloat middleLineWidth = 0.5;
    CGFloat filterButtonWidth = (QZ_SCREEN_WIDTH - middleLineCount * middleLineWidth) / self.listCount;
    CGFloat coupleWidth = filterButtonWidth + middleLineWidth;
    
    for (NSInteger i = 0; i<self.listCount; i++) {
        UIButton *filterButton = [self buttonWithLeftTitle:@"" titleColor:UIColorFromRGB(0x333333) Font:DefaultFont backgroundColor:[UIColor whiteColor] RightImageName:@"PR_filter_choice" Frame:CGRectMake(coupleWidth * i, 0, filterButtonWidth, 40)];
        [filterButton setTitleColor:UIColorFromRGB(0x00a0ff) forState:UIControlStateSelected];
        [filterButton setImage:[UIImage imageNamed:@"PR_filter_choice_top"] forState:UIControlStateSelected];
        [filterButton addTarget:self action:@selector(filterWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:filterButton];
        [self.filterButtons addObject:filterButton];
        
        if (i != self.listCount -1) {
            // 最后一个不用竖线
            UILabel *middleLine = [[UILabel alloc] initWithFrame:CGRectMake(filterButton.right, 8 , middleLineWidth, 24)];
            middleLine.backgroundColor=UIColorFromRGB(0xe6e6e6);
            [self addSubview:middleLine];
        }
        
    }
    
    UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 39.5, QZ_SCREEN_WIDTH, 0.5)];
    bottomLine.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self addSubview:bottomLine];
}

- (void)setupData {
    // 占位
    self.choosedTableItems = [NSMutableArray array];
    for (NSInteger i = 0; i<self.listCount; i++) {
        [self.choosedTableItems addObject:@""];
    }
}

- (UIButton *)buttonWithLeftTitle:(NSString *)title titleColor:(UIColor *)titleColor Font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor RightImageName:(NSString *)imageName Frame:(CGRect)frame {
    
    titleColor = titleColor? : [UIColor blackColor];
    font = font ? : DefaultFont;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.backgroundColor = backgroundColor;
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:font}];
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat space = 5;
    
    CGFloat edgeSpace = (btn.width-(titleSize.width+image.size.width+space))/2+titleSize.width+space;
    
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, -edgeSpace)];
    [btn setImage:image forState:UIControlStateNormal];
    
    CGFloat titleSpace = -image.size.width - space;
    if((int)QZ_SCREEN_HEIGHT % 736 != 0) {
        titleSpace = -image.size.width-  DefaultFilterNum *space;
    }
    
    [btn.titleLabel setContentMode:UIViewContentModeCenter];
    [btn.titleLabel setFont:font];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, titleSpace, 0, 0)];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

- (void)filterWithBtn:(UIButton *)btn {
    btn.selected =! btn.selected;
    if (btn.selected) {
        [self showTableView:btn];
        _selectBtn = btn;
    }else{
        [self dismiss];
    }
}

- (void)showTableView:(UIButton *)btn {
    
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottom , self.width, QZ_SCREEN_HEIGHT - self.bottom)];
        _bgView.backgroundColor = [UIColor colorWithDisplayP3Red:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_bgView addGestureRecognizer:tap];
        [[UIApplication sharedApplication].keyWindow addSubview:_bgView];
    }
    
    for (NSInteger i = 0; i<self.filterButtons.count; i++) {
        UIButton *filterButton = self.filterButtons[i];
        if (btn == filterButton) {
            [self.filterTableView dismiss];
            self.filterTableView.frame = CGRectMake(0, self.bottom, self.width, 0);
            self.filterTableView.chooseDelegate = self;
            self.filterTableView.dataArray = self.dataArrays[i];
            self.filterTableView.selectedItem = self.choosedTableItems[i];
            [[UIApplication sharedApplication].keyWindow addSubview:self.filterTableView];
        }
    }

    _isShow = YES;
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    if (_selectBtn && _selectBtn != btn) {
        _selectBtn.selected = NO;
    }
    
}

- (void)updateFilterTableTitleWithTitleArray:(NSArray<NSString*> *)titleArray {
    if (titleArray.count < self.listCount) {
        NSLog(@"数据源不足，请检查显示在筛选框上的标题数据");
        return;
    }
    // 改变 按键 值
    for (NSInteger i = 0; i<self.filterButtons.count; i++) {
        UIButton *filterButton = self.filterButtons[i];
        [self changeBtn:filterButton Text:titleArray[i] Font:DefaultFont ImageName:@"PR_filter_choice"];
    }
    [self dismiss];
    
    if(self.filterBlock) {
        self.filterBlock(titleArray);
    }
    
}

#pragma mark - QZFilterTableViewDelegate 选择筛选项
- (void)chooseFilterItem:(NSString *)item {
    for (UIButton *filterButton in self.filterButtons) {
        if (filterButton.selected) {
            [self changeBtn:filterButton Text:item Font:DefaultFont ImageName:@"PR_filter_choice"];
            NSInteger index = [self.filterButtons indexOfObject:filterButton];
            self.choosedTableItems[index] = item;
        }
    }
    [self dismiss];
    if (self.filterBlock) {
        self.filterBlock(self.choosedTableItems);
    }
}

#pragma mark - 改按钮文字重新排列
- (void)changeBtn:(UIButton *)btn Text:(NSString *)title Font:(UIFont *)font ImageName:(NSString *)imageName {
    btn.width = (QZ_SCREEN_WIDTH - 1) / DefaultFilterNum;
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:font}];
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat space = 5;
    
    CGFloat edgeSpace = (btn.width-(titleSize.width+image.size.width+space))+titleSize.width+space;
    
    // 90 - 60
    // 78 - 50
    CGFloat edge = -edgeSpace;
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, edge)];
    [btn setImage:image forState:UIControlStateNormal];
    
    CGFloat titleSpace = -image.size.width - space;
    if((int)QZ_SCREEN_HEIGHT % 736 != 0) {
        titleSpace = -image.size.width - 4 * space;
    }
    
    [btn.titleLabel setContentMode:UIViewContentModeCenter];
    [btn.titleLabel setFont:font];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, titleSpace, 0, 0)];
    [btn setTitle:title forState:UIControlStateNormal];
}

- (void)dismiss {
    [self.filterTableView dismiss];
    
    for (UIButton *filterButton in self.filterButtons) {
        filterButton.selected = NO;
    }
    _selectBtn=nil;
    _isShow=NO;
    [_bgView removeFromSuperview];
    _bgView=nil;
}

- (QZFilterTableView *)filterTableView {
    if (!_filterTableView) {
        _filterTableView = [[QZFilterTableView alloc] initWithFrame:CGRectZero];
    }
    return _filterTableView;
}

@end
