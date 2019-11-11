//
//  PullRefreshHeaderView.h
//  UIScrollView
//
//  Created by 樊康鹏 on 2019/11/11.
//  Copyright © 2019 iOS Team. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger,PullRefreshStatus){
    PullRefreshStatus_Normal = 1,
    PullRefreshStatus_BeginRefresh = 2,
    PullRefreshStatus_Refreshing = 3,
};


NS_ASSUME_NONNULL_BEGIN

@interface PullRefreshHeaderView : UIView
@property (nonatomic,strong)UILabel *updateLabel;
@property (nonatomic,copy) void (^completer)();
@property (nonatomic,strong) UIScrollView *parentView;
@property (nonatomic) PullRefreshStatus refreshStatus;

-(void)beginHeaderRefresh;
-(void)endHeaderRefresh;

-(void)adjustY:(CGFloat)y;

@end

NS_ASSUME_NONNULL_END
