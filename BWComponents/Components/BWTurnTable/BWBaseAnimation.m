//
//  BWTurnTable.m
//  BWComponents
//
//  Created by bairdweng on 2021/3/6.
//

#import "BWBaseAnimation.h"

@implementation BWBaseAnimation

+ (void)rotatingView:(UIView *)view {    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = 0;
    animation.duration = 1;
    animation.cumulative = YES;
    //    animation.delegate = self.basicAnimationDelegate;
    animation.timingFunction = nil;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.repeatCount = UINT32_MAX;
    //    [view.layer addAnimation:1 forKey:@"HELLOANIMAITION"];
}

+ (void)shake:(UIView *)view {
    CGFloat duration = 0.3f;
    CGAffineTransform translateRight = CGAffineTransformMakeRotation(M_PI*0.1);
    CGAffineTransform translateLeft = CGAffineTransformMakeRotation(- M_PI*0.1);
    [UIView animateWithDuration:duration animations:^{
        view.transform = translateLeft;
    }completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
                [UIView setAnimationRepeatCount:INT32_MAX];
                view.transform = translateRight;
            } completion:NULL];
        }
    }];
}
@end
