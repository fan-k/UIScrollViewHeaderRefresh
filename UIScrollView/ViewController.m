//
//  ViewController.m
//  UIScrollView
//
//  Created by 樊康鹏 on 2019/11/11.
//  Copyright © 2019 iOS Team. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+PullRefresh.h"


@interface ViewController ()

@property (nonatomic ,strong) UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    
    
    // Do any additional setup after loading the view.
}


- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _scrollView.frame.size.height + 1);
        [_scrollView headerRefreshWithCompleter:^{
            NSLog(@"__刷新中");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self->_scrollView endHeaderRefresh];
            });
        }];
    }return _scrollView;
}

@end
