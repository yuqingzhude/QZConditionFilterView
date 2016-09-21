//
//  QZSortCell.m
//  circle_iphone
//
//  Created by MrYu on 16/8/2.
//  Copyright © 2016年 ctquan. All rights reserved.
//

#import "QZSortCell.h"
#import "UIView+Extension.h"
@interface QZSortCell ()

@end

@implementation QZSortCell

+ (instancetype)sortCell
{
    return [[self alloc] init];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeSubViews];
        self.width = SCREEN_WIDTH;
    }
    return self;
}

- (void)makeSubViews
{
    // 添加对勾
    self.markView.frame = CGRectMake(SCREEN_WIDTH - 11 - 25, 0, 11, 7);
    self.markView.image = [UIImage imageNamed:@"PR_project_ok"];
    [self addSubview:self.markView];
    // 默认不显示
    self.markView.hidden = YES;
    // 设置居中
    self.markView.y = self.height/2;
    
    // 添加线条
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, self.height - 1, SCREEN_WIDTH - 20, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xe6e6e6);
    lineView.alpha = 0.5;
    [self addSubview:lineView];
    
}

#pragma mark - lazyload
- (UIImageView*)markView
{
    if (!_markView) {
        UIImageView *markView=[[UIImageView alloc] init];
        _markView = markView;
    }
    return _markView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
