//
//  BWPageViewController.m
//  BWComponents
//
//  Created by bairdweng on 2021/3/8.
//

#import "BWPageView.h"
#import <Masonry.h>
@interface BWPageView ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *mainScrollView;
@property(nonatomic, strong)NSMutableArray *items;
@property(nonatomic, assign)CGFloat headerHeight;
@property(nonatomic, strong)UIView *headerView;
@property(nonatomic, strong)NSMutableArray<UIScrollView *> *scroViews;
@property(nonatomic, assign)NSInteger currentIndex;
@end

@implementation BWPageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
        [self reloadData];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"] &&
        [object isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scro = (UIScrollView *)object;
        CGFloat y = scro.contentOffset.y;
        CGRect frame = self.headerView.frame;
        frame.origin.y = [self offfsetY:y];
        self.headerView.frame = frame;
    }
}
#pragma mark 滚动同步
// 控制顶部视图。
- (CGFloat)offfsetY:(CGFloat)y {
    CGFloat ny = -y;
    if (ny > 0) {
        return 0;
    }
    if (ny < - self.headerHeight) {
        return - self.headerHeight;
    }
    return ny;
}

// 当主滚动视图滚动的时，同步scro
- (void)syncOffsetY:(UIScrollView *)scro {
    CGFloat y = (self.headerView.frame.origin.y) * -1;
    scro.contentOffset = CGPointMake(0, y);
}

// 当滚动区域小于SizeHeight时，自动滚动到0
- (void)friendlyScroIndex:(NSInteger)index {
    UIScrollView *scro = self.scroViews[index];
    if (scro.contentSize.height <= scro.frame.size.height) {
        [scro setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void)reloadData {
    self.scroViews = [[NSMutableArray alloc]init];
    self.items = [[NSMutableArray alloc]init];
    if ([self.dataSources respondsToSelector:@selector(pageCount)]) {
        [self layoutIfNeeded];
        NSInteger pageCount =  [self.dataSources pageCount];
        self.mainScrollView.contentSize = CGSizeMake(pageCount * CGRectGetWidth(self.bounds), 0);
    }
    
    if ([self.dataSources respondsToSelector:@selector(headerViewHeight)]) {
        self.headerHeight = [self.dataSources headerViewHeight];
    }
    
    if ([self.dataSources respondsToSelector:@selector(headerView)]) {
        self.headerView = [self.dataSources headerView];
        [self setHeaderView];
    }
    [self loadSubViewIndex:0];
    [self kvoScrollIndex:0];
}


- (void)setHeaderView {
    if (self.headerView) {
        [self addSubview:self.headerView];
        self.headerView.frame = CGRectMake(0, 0, self.frame.size.width, self.headerHeight);
    }
}

- (void)setUpView {
    [self addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _mainScrollView.delegate = self;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.bounces = NO;
    }
    return _mainScrollView;
}


#pragma mark scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / CGRectGetWidth(self.bounds);
    self.currentIndex = page;
    [self loadSubViewIndex:page];
    [self kvoScrollIndex:page];
    [self friendlyScroIndex:page];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.scroViews enumerateObjectsUsingBlock:^(UIScrollView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 同步Scroll
        if (idx != self.currentIndex) {
            [self syncOffsetY:obj];
        }
    }];
}

// 只kvo当前显示的
- (void)kvoScrollIndex:(NSInteger)index {
    [self.scroViews enumerateObjectsUsingBlock:^(UIScrollView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == index) {
            [obj addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        }
    }];
}

- (void)loadSubViewIndex:(NSInteger)page {
    NSString *pageKey = [NSString stringWithFormat:@"view_key_%ld",page];
    if ([self.items containsObject:pageKey]) {
        return;
    }
    if ([self.dataSources respondsToSelector:@selector(pageViewIndex:)]) {
        id<BWPageViewDelegate>delegate = [self.dataSources pageViewIndex:page];
        if ([delegate isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController *)delegate;
            [self.items addObject:pageKey];
            [_mainScrollView addSubview:vc.view];
            CGFloat left = CGRectGetWidth(self.frame) * page;
            [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(left);
                make.bottom.top.width.equalTo(self);
            }];
            UIScrollView *scro = [delegate subScrollView];
            // 将高度传给子视图控制器。
            [delegate mainHeaderHeight:self.headerHeight];
            [self.scroViews addObject:scro];
        } else {
            NSLog(@"回传的控制器不正确");
        }
    }
}
@end
