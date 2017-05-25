//
//  YNavigationViewController.m
//  AnimationTransitions
//
//  Created by 蓝云 on 2017/5/17.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import "YNavigationViewController.h"
#import "AppDelegate.h"

#define DISTANCETOPOP 80

@interface YNavigationViewController ()<UINavigationBarDelegate, UIGestureRecognizerDelegate> {
    
}

@property (nonatomic, weak) id PopDelegate;

@end

@implementation YNavigationViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

// 当该类第一次用到的时候就调用
+ (void)initialize
{
 //    NSLog(@"initialize");
    // 3.设置导航条的主题
    // 如果要同时设置很多UINavigationBar的样式, 可以通过设置UINavigationBar的主题的方式来设置以便简化代码
    UINavigationBar *navBar = [UINavigationBar appearance];
    // 3.1设置所有导航条的背景图片
    // 判断当前运行的操作系统的版本
    [navBar setBarTintColor:RGB(111, 170, 255, 1.0)];
    [navBar setTintColor:[UIColor whiteColor]];
    
    // 标题字体和颜色
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor], NSForegroundColorAttributeName,
                                [UIFont boldSystemFontOfSize:17], NSFontAttributeName,
                                nil];
    [navBar setTitleTextAttributes:attributes];
    
    //标题位置
    [navBar setTitleVerticalPositionAdjustment:1 forBarMetrics:UIBarMetricsDefault];
 
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithNavigationBarClass:[UINavigationBar class] toolbarClass:nil];
    if(self) {
        self.viewControllers = @[rootViewController];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = nil;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:panGesture];
    
}

- (void)panGesture:(UIPanGestureRecognizer *)gesture
{
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIViewController *rootVC = appdelegate.window.rootViewController;
    UIViewController *presentedVC = rootVC.presentedViewController;
    if (self.viewControllers.count == 1)
    {
        return;
    }
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        appdelegate.backView.transform = CGAffineTransformMakeScale(.9, .95);
        appdelegate.backView.hidden = NO;
    }
    else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint pt = [gesture translationInView:self.view];
        
        if (pt.x >= 10)
        {
            appdelegate.backView.transform = CGAffineTransformMakeScale(0.9 + (pt.x / SCREEN_WIDTH * 0.1), 0.95 + (pt.x / SCREEN_WIDTH * 0.05));
            rootVC.view.transform = CGAffineTransformMakeTranslation(pt.x - 10, 0);
            presentedVC.view.transform = CGAffineTransformMakeTranslation(pt.x - 10, 0);
        } 
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint pt = [gesture translationInView:self.view];
        if (pt.x >= DISTANCETOPOP)
        {
            [UIView animateWithDuration:0.3 animations:^{
                rootVC.view.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH, 0);
                appdelegate.backView.transform = CGAffineTransformIdentity;
                presentedVC.view.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH, 0);
            } completion:^(BOOL finished) {
                [self popViewControllerAnimated:NO];
                rootVC.view.transform = CGAffineTransformIdentity;
                presentedVC.view.transform = CGAffineTransformIdentity;
                appdelegate.backView.hidden = YES;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                rootVC.view.transform = CGAffineTransformIdentity;
                presentedVC.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                appdelegate.backView.hidden = YES;
            }];
        }
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIView *imgView = [super.view snapshotViewAfterScreenUpdates:YES];
    [app.backView addSubview:imgView];
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    
    UIViewController *viewC = [super popViewControllerAnimated:animated];
    return viewC;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = nil;
    }else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
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
