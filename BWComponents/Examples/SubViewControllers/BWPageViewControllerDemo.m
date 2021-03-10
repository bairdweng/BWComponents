//
//  BWPageViewControllerDemo.m
//  BWComponents
//
//  Created by bairdweng on 2021/3/8.
//

#import "BWPageViewControllerDemo.h"
#import "BWPageView.h"
#import <Masonry.h>
#import "PageViewController1.h"
#import "PageViewController2.h"
@interface BWPageViewControllerDemo ()<BWPageViewDataSources>
@property(nonatomic, strong)BWPageView *pageView;
@end

@implementation BWPageViewControllerDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 不伸到导航栏
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setUpView];
    // Do any additional setup after loading the view.
}

- (void)setUpView {
    [self.view addSubview:self.pageView];
    [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.pageView.backgroundColor = [UIColor redColor];
    [self.pageView reloadData];
}

- (BWPageView *)pageView {
    if (!_pageView) {
        _pageView = [BWPageView new];
        _pageView.dataSources = self;
    }
    return _pageView;
}

- (UIView *)headerView {
    UIView *mainHeader = [[UIView alloc]init];
    mainHeader.backgroundColor = [UIColor blueColor];
    return mainHeader;
}

- (CGFloat)headerViewHeight {
    return 150;
}

- (NSInteger)pageCount {
    return 2;
}

- (id<BWPageViewDelegate>)pageViewIndex:(NSInteger)index {
    if (index == 0) {
        PageViewController1 *vc1 = [PageViewController1 new];
        [self addChildViewController:vc1];
        return vc1;
    } else {
        PageViewController2 *vc2 = [PageViewController2 new];
        [self addChildViewController:vc2];
        return vc2;
    }
}



@end
