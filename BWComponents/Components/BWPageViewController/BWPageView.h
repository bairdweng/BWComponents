//
//  BWPageViewController.h
//  BWComponents
//
//  Created by bairdweng on 2021/3/8.
//

#import <UIKit/UIKit.h>
#import "BWBasePageViewController.h"
NS_ASSUME_NONNULL_BEGIN


@protocol BWPageViewDelegate <NSObject>

/// 返回ScrollView。
- (UIScrollView *)subScrollView;
/// 主页面头部高度。
- (void)mainHeaderHeight:(CGFloat)height;

@end


@protocol BWPageViewDataSources <NSObject>

// 遵循这个协议即可，可以返回UIViewController.
- (id<BWPageViewDelegate>)pageViewIndex:(NSInteger)index;

/// 页面数。
- (NSInteger)pageCount;

/// HeadrView的高度
- (CGFloat)headerViewHeight;

/// 设置HeaderView
- (UIView *)headerView;

@end



@interface BWPageView : UIView

- (void)reloadData;
@property(nonatomic, weak)id<BWPageViewDataSources>dataSources;

@end

NS_ASSUME_NONNULL_END
