//
//  DYScrollTextLabel.m
//  BWVoiceLive
//
//  Created by bairdweng on 2021/3/4.
//

#import "DYScrollTextLabel.h"

@interface DYScrollTextLabel() {
    UIScrollView *_scrollView;
    UILabel      *_firstLabel;
    UILabel      *_lastLabel;
    NSTimer      *_timer;
    int32_t      _currentIndex;
    BOOL         _isRuning;
}
@end

@implementation DYScrollTextLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
        [self setDefaultValue];
    }
    return self;
}

- (void)setDefaultValue {
    _isRuning = NO;
    _currentIndex = 0;
    self.betweenTime = 3;
}

- (void)start {
    if (_isRuning == YES) {
        return;
    }
    if (self.texts.count == 0) {
        NSAssert(NO, @"请设置富文本");
        return;
    }
    _isRuning = YES;
    // 第一次加载不滚动
    _firstLabel.attributedText = _texts[_currentIndex];
    // 索引+1
    [self addIndex];
    // 启动定时器
    [self fire];
}

// 索引处理。
- (void)addIndex {
    if (_currentIndex ==  self.texts.count - 1) {
        _currentIndex = 0;
    } else {
        _currentIndex ++;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 兼容AutolayOut
    _scrollView.frame = self.bounds;
    _scrollView.contentSize = CGSizeMake(0, CGRectGetHeight(self.bounds) * 2);
    _firstLabel.frame = self.bounds;
    CGRect lastLabelFrame = self.bounds;
    lastLabelFrame.origin.y = CGRectGetHeight(self.bounds);
    _lastLabel.frame  = lastLabelFrame;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpView];
}

- (void)setUpView {
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(0, CGRectGetHeight(self.bounds) * 2);
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _firstLabel = [[UILabel alloc]initWithFrame:self.bounds];
    _firstLabel.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:_firstLabel];
    
    CGRect lastLabelFrame = self.bounds;
    lastLabelFrame.origin.y = CGRectGetHeight(self.bounds);
    _lastLabel = [[UILabel alloc]initWithFrame:lastLabelFrame];
    _lastLabel.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:_lastLabel];
}

- (void)fire {
    __weak typeof(self)weakSelf = self;
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.betweenTime repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf scroll];
        [weakSelf addIndex];
    }];
}

- (void)scroll {
    [self scrollIndex:_currentIndex];
}
- (void)scrollIndex:(int32_t)index {
    // 边界判断
    if (index > self.texts.count - 1) {
        return;
    }
    // 上一个索引
    int32_t   lastIndex = index ==  0 ? (int32_t)(self.texts.count - 1) : index - 1;
    NSAttributedString *lastText    = self.texts[lastIndex];
    NSAttributedString *currentText = self.texts[index];
    _firstLabel.attributedText      = lastText;
    _lastLabel.attributedText       = currentText;
    // 滚动到第二页。
    CGFloat offsetY = CGRectGetHeight(self.bounds);
    [_scrollView setContentOffset:CGPointMake(0, offsetY) animated:YES];
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf resetOffsetX:currentText];
    });
}

- (void)resetOffsetX:(NSAttributedString *)currentText {
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    _firstLabel.attributedText = currentText;
    _lastLabel.attributedText = currentText;
}

- (void)dealloc {
    NSLog(@"执行--------");
//    [_timer invalidate];
}

@end
