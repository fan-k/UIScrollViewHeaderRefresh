//
//  UIScrollView+PullRefresh.h
//  UIScrollView
//
//  Created by 樊康鹏 on 2019/11/11.
//  Copyright © 2019 iOS Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (PullRefresh)
@property (nonatomic ,strong) PullRefreshHeaderView *refreshHeaderView;


-(void)headerRefreshWithCompleter:(void(^)())completer;

-(void)beginHeaderRefresh;


-(void)endHeaderRefresh;
@end

NS_ASSUME_NONNULL_END
