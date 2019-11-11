//
//  PullRefreshHeaderView.m
//  UIScrollView
//
//  Created by 樊康鹏 on 2019/11/11.
//  Copyright © 2019 iOS Team. All rights reserved.
//

#import "PullRefreshHeaderView.h"
#define PullRefreshMinOffSetY     100

@implementation PullRefreshHeaderView

- (instancetype)init{
    if (self = [super init]){
        [self addSubview:self.updateLabel];
        self.refreshStatus = PullRefreshStatus_Normal;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.updateLabel.frame = CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 20);
}
- (void)beginHeaderRefresh{
    self.refreshStatus = PullRefreshStatus_Refreshing;
}
- (void)endHeaderRefresh{
    [self isAdjustToNormal:YES];
    self.refreshStatus = PullRefreshStatus_Normal;
}

- (void)adjustY:(CGFloat)y{
    if (self.parentView.isDragging){
        if (y>PullRefreshMinOffSetY){
            self.refreshStatus = PullRefreshStatus_BeginRefresh;
        }
        else{
            self.refreshStatus = PullRefreshStatus_Normal;
        }
    }else {
        if (y>PullRefreshMinOffSetY) {
            self.refreshStatus = PullRefreshStatus_Refreshing;
        }
    }
}

- (void)isAdjustToNormal:(BOOL)normal{
    CGFloat y = 0;
    if (!normal){
        y = 50;
    }
    __weak PullRefreshHeaderView *weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.parentView.contentInset = UIEdgeInsetsMake(y, 0, 0, 0);
    }];
}
- (void)doNormalRefresh{
    self.updateLabel.text = @"下拉刷新...";
}
- (void)doBeginRefresh{
    self.updateLabel.text = @"释放加载...";
}
- (void)doRefreshing{
    self.updateLabel.text = @"正在努力加载...";
    [self isAdjustToNormal:NO];
    [self performSelector:@selector(loadAction) withObject:nil afterDelay:0];
}
- (void)loadAction{
    if (self.completer) {
        self.completer();
    }
}


- (void)setRefreshStatus:(PullRefreshStatus)refreshStatus{
    if(_refreshStatus == refreshStatus)
        return;
    
    switch (refreshStatus){
        case PullRefreshStatus_Normal:
            [self doNormalRefresh];
            break;
        case PullRefreshStatus_BeginRefresh:
        {
            [self doBeginRefresh];
            break;
        }
        case PullRefreshStatus_Refreshing:
        {
            [self doRefreshing];
            break;
        }
        default:
            break;
    }
    _refreshStatus = refreshStatus;
}

- (UILabel *)updateLabel{
    if (!_updateLabel){
        _updateLabel = [[UILabel alloc] init];
        _updateLabel.textAlignment = NSTextAlignmentCenter;
        _updateLabel.font = [UIFont systemFontOfSize:13];
        _updateLabel.textColor = [UIColor grayColor];
    }
    return _updateLabel;
}


@end
