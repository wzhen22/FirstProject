//
//  RefreshHeaderView.m
//  shiyan3
//
//  Created by 传晟 on 14-4-14.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "RefreshHeaderView.h"
#import "WZRefrshConst.h"

@interface RefreshHeaderView ()
@property (nonatomic,strong) NSDate *lastUpdateTime;
@end

@implementation RefreshHeaderView

+(instancetype)header{
    return [[RefreshHeaderView alloc]init];
}
#pragma mark - UIScrollView相关
#pragma mark 重写设置ScrollView
- (void)setScrollView:(UIScrollView *)scrollView
{
    [super setScrollView:scrollView];
    
    // 1.设置边框
    self.frame = CGRectMake(0, - WZRefreshViewHeight, scrollView.frame.size.width, WZRefreshViewHeight);
    
    // 2.加载时间
    self.lastUpdateTime = [[NSUserDefaults standardUserDefaults] objectForKey:WZRefreshHeaderTimeKey];
}

#pragma mark - 状态相关
#pragma mark 设置最后的更新时间
- (void)setLastUpdateTime:(NSDate *)lastUpdateTime
{
    _lastUpdateTime = lastUpdateTime;
    
    // 1.归档
    [[NSUserDefaults standardUserDefaults] setObject:_lastUpdateTime forKey:WZRefreshHeaderTimeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 2.更新时间
    [self updateTimeLabel];
}

#pragma mark 更新时间字符串
- (void)updateTimeLabel
{
    if (!_lastUpdateTime) return;
    
    // 1.获得年月日
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:_lastUpdateTime];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    // 2.格式化日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if ([cmp1 day] == [cmp2 day]) { // 今天
        formatter.dateFormat = @"今天 HH:mm";
    } else if ([cmp1 year] == [cmp2 year]) { // 今年
        formatter.dateFormat = @"MM-dd HH:mm";
    } else {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    NSString *time = [formatter stringFromDate:_lastUpdateTime];
    
    // 3.显示日期
    _lastUpdateTimeLabel.text = [NSString stringWithFormat:@"最后更新：%@", time];
}

#pragma mark 设置状态
- (void)setState:(WZRefreshState)state
{
    // 1.一样的就直接返回
    if (_state == state) return;
    
    // 2.保存旧状态
    WZRefreshState oldState = _state;
    
    // 3.调用父类方法
    [super setState:state];
    
    // 4.根据状态执行不同的操作
	switch (state) {
		case WZRefreshStatePulling: // 松开可立即刷新
        {
            // 设置文字
            _statusLabel.text = WZRefreshHeaderReleaseToRefresh;
            // 执行动画
            [UIView animateWithDuration:WZRefreshAnimationDuration animations:^{
                _arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                UIEdgeInsets inset = _scrollView.contentInset;
                inset.top = _scrollViewInitInset.top;
                _scrollView.contentInset = inset;
            }];
			break;
        }
            
		case WZRefreshStateNormal: // 下拉可以刷新
        {
            // 设置文字
			_statusLabel.text = WZRefreshHeaderPullToRefresh;
            // 执行动画
            [UIView animateWithDuration:WZRefreshAnimationDuration animations:^{
                _arrowImage.transform = CGAffineTransformIdentity;
                UIEdgeInsets inset = _scrollView.contentInset;
                inset.top = _scrollViewInitInset.top;
                _scrollView.contentInset = inset;
            }];
            
            // 刷新完毕
            if (WZRefreshStateDidRefreshing == oldState) {
                // 保存刷新时间
                self.lastUpdateTime = [NSDate date];
            }
			break;
        }
            
		case WZRefreshStateDidRefreshing: // 正在刷新中
        {
            // 设置文字
            _statusLabel.text = WZRefreshHeaderRefreshing;
            // 执行动画
            [UIView animateWithDuration:WZRefreshAnimationDuration animations:^{
                _arrowImage.transform = CGAffineTransformIdentity;
                // 1.增加65的滚动区域
                UIEdgeInsets inset = _scrollView.contentInset;
                inset.top = _scrollViewInitInset.top + WZRefreshViewHeight;
                _scrollView.contentInset = inset;
                // 2.设置滚动位置
                _scrollView.contentOffset = CGPointMake(0, - _scrollViewInitInset.top - WZRefreshViewHeight);
            }];
			break;
        }
            
        default:
            break;
	}
}

#pragma mark - 在父类中用得上
// 合理的Y值(刚好看到下拉刷新控件时的contentOffset.y，取相反数)
- (CGFloat)validY
{
    return _scrollViewInitInset.top;
}

// view的类型
- (int)viewType
{
    return WZRefreshViewTypeHeader;
}

@end
