//
//  PageViewController2.h
//  BWComponents
//
//  Created by bairdweng on 2021/3/8.
//

#import <UIKit/UIKit.h>
#import "BWPageView.h"
NS_ASSUME_NONNULL_BEGIN

@interface PageViewController2 : UIViewController<BWPageViewDelegate>
@property(nonatomic, strong)UIScrollView *scrollView;
@end

NS_ASSUME_NONNULL_END
