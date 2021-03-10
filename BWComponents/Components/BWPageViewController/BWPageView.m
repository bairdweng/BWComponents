//
//  BWPageViewController.m
//  BWComponents
//
//  Created by bairdweng on 2021/3/8.
//

#import "BWPageView.h"
#import <Masonry.h>
@interface BWPageView ()<UIScrollViewDelegate>
/// 主的视图控制器
@property(nonatomic, strong)UIScrollView *mainScrollView;
/// 修改了啊我是ken
/// ken第二次修改
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


- (void)layoutSubviews {
    [super layoutSubviews];
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / CGRectGetWidth(self.bounds);
    self.currentIndex = page;
    [self loadSubViewIndex:page];
}
- (void)loadSubViewIndex:(NSInteger)page {
    NSString *pageKey = [NSString stringWithFormat:@"view_key_%ld",page];
    if ([self.items containsObject:pageKey]) {
        return;
    }
    if ([self.dataSources respondsToSelector:@selector(pageViewIndex:)]) {
        id<BWPageViewDelegate>delegate =  [self.dataSources pageViewIndex:page];
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
            [scro addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
            // 将高度传给子视图控制器。
            [delegate mainHeaderHeight:self.headerHeight];
            [self.scroViews addObject:scro];
            
        } else {
            NSLog(@"回传的控制器不正确");
        }
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)dealloc {
    
}

@end
