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

@interface QZConditionFilterView()<QZFilterTableViewDelegate> {
    // 下拉菜单按钮
    UIButton *_filterButton1;
    UIButton *_filterButton2;
    UIButton *_filterButton3;
    
    UIButton *_selectBtn; // 当前选中的按钮
    
    UIView *_bgView;
    
    // 对应三个下拉框
    QZFilterTableView *_filterTableView1;
    QZFilterTableView *_filterTableView2;
    QZFilterTableView *_filterTableView3;
    
    // 存储 tableView didSelected数据 数据来源：FilterDataTableView
    NSString *_choosedTableItem1;
    NSString *_choosedTableItem2;
    NSString *_choosedTableItem3;
    
    BOOL _isShow;
}

@property (nonatomic,strong) FilterBlock filterBlock;

@end


@implementation QZConditionFilterView

+ (instancetype)conditionFilterViewWithFilterBlock:(FilterBlock)filterBlock {
    QZConditionFilterView *conditionFilter = [[QZConditionFilterView alloc] initWithFrame:CGRectMake(0, 0, QZ_SCREEN_WIDTH, 40)];
    [conditionFilter createSubView];
    conditionFilter.filterBlock=filterBlock;
    return conditionFilter;
}

- (void)createSubView {
    self.backgroundColor=[UIColor whiteColor];
    _isShow = NO;
    
    // 不用设置默认显示数据，在外边设置 bindChoseArray重置就会刷新
    _filterButton1 = [self buttonWithLeftTitle:@"" titleColor:UIColorFromRGB(0x333333) Font:DefaultFont backgroundColor:[UIColor whiteColor] RightImageName:@"PR_filter_choice" Frame:CGRectMake(0, 0, (QZ_SCREEN_WIDTH-1) / DefaultFilterNum, 40)];
    [_filterButton1 setTitleColor:UIColorFromRGB(0x00a0ff) forState:UIControlStateSelected];
    [_filterButton1 setImage:[UIImage imageNamed:@"PR_filter_choice_top"] forState:UIControlStateSelected];
    [_filterButton1 addTarget:self action:@selector(filterWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_filterButton1];
    
    UILabel *middleLine = [[UILabel alloc] initWithFrame:CGRectMake(_filterButton1.x+_filterButton1.width, 8 , 0.5, 24)];
    middleLine.backgroundColor=UIColorFromRGB(0xe6e6e6);
    [self addSubview:middleLine];
    
    _filterButton2 = [self buttonWithLeftTitle:@"" titleColor:UIColorFromRGB(0x333333) Font:DefaultFont backgroundColor:[UIColor whiteColor] RightImageName:@"PR_filter_choice" Frame:CGRectMake(_filterButton1.x+_filterButton1.width+0.5, 0, _filterButton1.width, 40)];
    [_filterButton2 setTitleColor:UIColorFromRGB(0x00a0ff) forState:UIControlStateSelected];
    [_filterButton2 setImage:[UIImage imageNamed:@"PR_filter_choice_top"] forState:UIControlStateSelected];
    [_filterButton2 addTarget:self action:@selector(filterWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_filterButton2];
    
    
    UILabel *middleLine2 = [[UILabel alloc] initWithFrame:CGRectMake(_filterButton2.x+_filterButton2.width, 8 , 0.5, 24)];
    middleLine2.backgroundColor=UIColorFromRGB(0xe6e6e6);
    [self addSubview:middleLine2];
    
    _filterButton3 = [self buttonWithLeftTitle:@"" titleColor:UIColorFromRGB(0x333333) Font:DefaultFont backgroundColor:[UIColor whiteColor] RightImageName:@"PR_filter_choice" Frame:CGRectMake(_filterButton2.x+_filterButton2.width+0.5, 0, _filterButton1.width, 40)];
    [_filterButton3 setTitleColor:UIColorFromRGB(0x00a0ff) forState:UIControlStateSelected];
    [_filterButton3 setImage:[UIImage imageNamed:@"PR_filter_choice_top"] forState:UIControlStateSelected];
    [_filterButton3 addTarget:self action:@selector(filterWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_filterButton3];
    
    
    UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 39.5, QZ_SCREEN_WIDTH, 0.5)];
    bottomLine.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self addSubview:bottomLine];
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
    
    if (btn == _filterButton1) {
        _filterTableView1 = [[QZFilterTableView alloc] initWithFrame:CGRectMake(0, self.bottom, self.width, 0)];
        _filterTableView1.chooseDelegate = self;
        _filterTableView1.dataArray = self.dataArray1;
        _filterTableView1.selectedItem = _choosedTableItem1;
        [[UIApplication sharedApplication].keyWindow addSubview:_filterTableView1];
        [_filterTableView2 dismiss];
        [_filterTableView3 dismiss];
    } else if (btn == _filterButton2){
        _filterTableView2 = [[QZFilterTableView alloc] initWithFrame:CGRectMake(0, self.bottom, self.width, 0)];
        _filterTableView2.chooseDelegate = self;
        _filterTableView2.dataArray = self.dataArray2;
        _filterTableView2.selectedItem = _choosedTableItem2;
        
        [[UIApplication sharedApplication].keyWindow addSubview:_filterTableView2];
        [_filterTableView1 dismiss];
        [_filterTableView3 dismiss];
        
    } else if (btn == _filterButton3){
        _filterTableView3 = [[QZFilterTableView alloc] initWithFrame:CGRectMake(0, self.bottom, self.width, 0)];
        _filterTableView3.chooseDelegate = self;
        _filterTableView3.dataArray = self.dataArray3;
        _filterTableView3.selectedItem = _choosedTableItem3;
        
        [[UIApplication sharedApplication].keyWindow addSubview:_filterTableView3];
        [_filterTableView1 dismiss];
        [_filterTableView2 dismiss];
    }
    
    _isShow = YES;
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    if (_selectBtn && _selectBtn != btn) {
        _selectBtn.selected = NO;
    }
    
}

- (void)updateFilterTableTitleWithTitleArray:(NSArray <NSString*> *)titleArray {
    if (titleArray.count < DefaultFilterNum) {
        NSLog(@"数据源不足，请检查显示在筛选框上的标题数据");
        return;
    }
    // 改变 按键 值
    [self changeBtn:_filterButton1 Text:titleArray[0] Font:DefaultFont ImageName:@"PR_filter_choice"];
    [self changeBtn:_filterButton2 Text:titleArray[1] Font:DefaultFont ImageName:@"PR_filter_choice"];
    [self changeBtn:_filterButton3 Text:titleArray[2] Font:DefaultFont ImageName:@"PR_filter_choice"];
    
    [self dismiss];
    
    if(self.filterBlock) {
        self.filterBlock(titleArray[0], titleArray[1], titleArray[2]);
    }
    
}

#pragma mark - QZFilterTableViewDelegate 选择筛选项
- (void)chooseFilterItem:(NSString *)item {
    if (_filterButton1.selected) {
        [self changeBtn:_filterButton1 Text:item Font:DefaultFont ImageName:@"PR_filter_choice"];
        _choosedTableItem1 = item;
    }else if (_filterButton2.selected){
        [self changeBtn:_filterButton2 Text:item Font:DefaultFont ImageName:@"PR_filter_choice"];
        _choosedTableItem2 = item;
    }else if (_filterButton3.selected){
        [self changeBtn:_filterButton3 Text:item Font:DefaultFont ImageName:@"PR_filter_choice"];
        _choosedTableItem3 = item;
    }

    [self dismiss];
    if (self.filterBlock) {
        self.filterBlock(_choosedTableItem1, _choosedTableItem2, _choosedTableItem3);
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
    [_filterTableView1 dismiss];
    [_filterTableView2 dismiss];
    [_filterTableView3 dismiss];
    _filterButton1.selected=NO;
    _filterButton2.selected=NO;
    _filterButton3.selected=NO;
    _selectBtn=nil;
    _isShow=NO;
    [_bgView removeFromSuperview];
    _bgView=nil;
    _filterTableView1.chooseDelegate=nil;
    _filterTableView2.chooseDelegate=nil;
    _filterTableView3.chooseDelegate=nil;
    [_filterTableView1 removeFromSuperview];
    [_filterTableView2 removeFromSuperview];
    [_filterTableView3 removeFromSuperview];
    _filterTableView1=nil;
    _filterTableView2=nil;
    _filterTableView3=nil;
}

@end
