//
//  DYScrollTextLabel.h
//  BWVoiceLive
//
//  Created by bairdweng on 2021/3/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYScrollTextLabel : UIView

@property(nonatomic, assign)NSTimeInterval betweenTime; // 播放时间，默认是3s;
@property(nonatomic,   copy)NSArray<NSMutableAttributedString *> *texts; // 富文本
// 开始执行
- (void)start;

@end

NS_ASSUME_NONNULL_END
