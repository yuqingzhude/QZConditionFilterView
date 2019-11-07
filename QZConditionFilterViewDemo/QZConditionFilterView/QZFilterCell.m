//
//  QZFilterCell.m
//  circle_iphone
//
//  Created by MrYu on 16/8/2.
//  Copyright © 2016年 ctquan. All rights reserved.
//

#import "QZFilterCell.h"
#import "UIView+QZExtension.h"

@interface QZFilterCell ()

@end

@implementation QZFilterCell

+ (instancetype)filterCell {
    return [[self alloc] init];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeSubViews];
        self.width = QZ_SCREEN_WIDTH;
    }
    return self;
}

- (void)makeSubViews {
    // 添加对勾
    self.markView.frame = CGRectMake(QZ_SCREEN_WIDTH - 11 - 25, 0, 11, 7);
    self.markView.image = [UIImage imageNamed:@"PR_project_ok"];
    [self addSubview:self.markView];
    self.markView.hidden = YES;
    self.markView.y = self.height / 2;
    
    // 添加线条
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, self.height - 1, QZ_SCREEN_WIDTH - 20, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xe6e6e6);
    lineView.alpha = 0.5;
    [self addSubview:lineView];
    
}

#pragma mark - lazyload
- (UIImageView*)markView {
    if (!_markView) {
        UIImageView *markView=[[UIImageView alloc] init];
        _markView = markView;
    }
    return _markView;
}

@end
