//
//  UIScrollView+PullRefresh.m
//  UIScrollView
//
//  Created by 樊康鹏 on 2019/11/11.
//  Copyright © 2019 iOS Team. All rights reserved.
//

#import "UIScrollView+PullRefresh.h"
#import <objc/runtime.h>


static NSString *pullRefreshObservePath = @"contentOffset";
static NSString *pullRefreshViewKey = @"pullRefreshViewKey";

@implementation UIScrollView (PullRefresh)


-(void)headerRefreshWithCompleter:(void (^)())completer{
    if (!self.refreshHeaderView){
        self.refreshHeaderView = [PullRefreshHeaderView new];
    }
    self.refreshHeaderView.frame = CGRectMake(0, - 100, self.frame.size.width, 100);
    self.refreshHeaderView.parentView = self;
    self.refreshHeaderView.completer = completer;
    [self addSubview:self.refreshHeaderView];
    [self sendSubviewToBack:self.refreshHeaderView];
    //兼听滚动偏移
    [self addObserver:self forKeyPath:pullRefreshObservePath options:NSKeyValueObservingOptionNew context:nil];
}

-(void)beginHeaderRefresh{
    [self.refreshHeaderView beginHeaderRefresh];
}
-(void)endHeaderRefresh{
    [self.refreshHeaderView endHeaderRefresh];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([pullRefreshObservePath isEqualToString:keyPath]){
        NSValue *point = (NSValue *)[change objectForKey:@"new"];
        CGPoint p = [point CGPointValue];
        [self.refreshHeaderView adjustY:-p.y];
    }
    
    
}
- (PullRefreshHeaderView *)refreshHeaderView{
    return objc_getAssociatedObject(self, &pullRefreshViewKey);
}
- (void)setRefreshHeaderView:(PullRefreshHeaderView *)refreshHeaderView{
    objc_setAssociatedObject(self, &pullRefreshViewKey, refreshHeaderView, OBJC_ASSOCIATION_RETAIN);
    
}

-(void)dealloc{
    if (self.refreshHeaderView)//注册过刷新的必须要除移开监听
    {
        [self removeObserver:self forKeyPath:pullRefreshObservePath context:nil];
    }
}


@end
