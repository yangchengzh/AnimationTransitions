//
//  PresentTransformAnimation.h
//  AnimationTransitions
//
//  Created by 蓝云 on 2017/5/18.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PresentTransformAnimationType) {
    PresentTransformAnimationTypePresent,
    PresentTransformAnimationTypeDismissed
};

@interface PresentTransformAnimation : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)makeWithTransitionType:(PresentTransformAnimationType)type;
- (instancetype)initWithTransitionType:(PresentTransformAnimationType)type;

@end
