//
//  TransformPresentViewController.h
//  AnimationTransitions
//
//  Created by 蓝云 on 2017/5/18.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TransformPresentViewControllerDelegate <NSObject>

- (void)TransformPresentViewControllerDlelegateDismissed;

@end

@interface TransformPresentViewController : UIViewController

@property (nonatomic, weak) id<TransformPresentViewControllerDelegate>delegate;

@end
