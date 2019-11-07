//
//  UIView+Extension.h
//
//  Created by MrYu on 16/8/2.
//  Copyright © 2016年 ctquan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define QZ_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define QZ_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define NavBarHeight            44
#define TabBarHeight            49
#define StatusBarHeight         [UIApplication sharedApplication].statusBarFrame.size.height
#define SafeAreaTopHeight       (StatusBarHeight + NavBarHeight)
#define SafeAreaBottomHeight    (StatusBarHeight > 20 ? 34 : 0)
#define SafeAreaHeightWithNav   (SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight)


@interface UIView (QZExtension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign, readonly)  CGFloat bottom;
@property (nonatomic, assign, readonly)  CGFloat right;

@end
