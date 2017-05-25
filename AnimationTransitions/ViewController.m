//
//  ViewController.m
//  AnimationTransitions
//
//  Created by 蓝云 on 2017/5/17.
//  Copyright © 2017年 yangzhi. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "AppDelegate.h"
#import "PresentMainViewController.h"


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation ViewController



- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"presentTransform"];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"转场动画";
    
    
    [self initTableView];
    
}

- (void)initTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.top.offset(0);
        make.height.offset(SCREEN_HEIGHT-64);
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%@", self.titleArray);
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PresentMainViewController *presentVC = [[PresentMainViewController alloc] init];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style: UIBarButtonItemStylePlain target:nil action: nil];
    [self.navigationItem setBackBarButtonItem:backButton];
    [self.navigationController pushViewController:presentVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
