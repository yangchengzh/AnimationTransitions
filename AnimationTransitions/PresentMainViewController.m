//
//  PresentMainViewController.m
//  AnimationTransitions
//
//  Created by 蓝云 on 2017/5/18.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import "PresentMainViewController.h"
#import "TransformPresentViewController.h"
#import "PresentTransformAnimation.h"
#import "SwipeUpInteractiveTransition.h"

@interface PresentMainViewController ()<TransformPresentViewControllerDelegate, UIViewControllerTransitioningDelegate> {
    PresentTransformAnimation *_presentAnimation;
    SwipeUpInteractiveTransition *_transitionController;
}

@end

@implementation PresentMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.title = @"presentTransform";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [button setTitle:@"点一下" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nextPage:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor grayColor];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.offset(100);
        make.height.offset(50);
    }];
    
}

- (void)nextPage:(UIButton *)button
{
    TransformPresentViewController *presentVC = [[TransformPresentViewController alloc] init];
    presentVC.delegate = self;
    presentVC.transitioningDelegate = self;
    [_transitionController wireToViewController:presentVC];
    [self presentViewController:presentVC animated:YES completion:nil];
}

- (void)TransformPresentViewControllerDlelegateDismissed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _presentAnimation = [PresentTransformAnimation new];
        _transitionController = [SwipeUpInteractiveTransition new];
    }
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return _presentAnimation;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [PresentTransformAnimation makeWithTransitionType:PresentTransformAnimationTypeDismissed];
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return _transitionController.interacting ? _transitionController : nil;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
