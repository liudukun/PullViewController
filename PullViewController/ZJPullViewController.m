//
//  ZJPullViewController.m
//  GSProject
//
//  Created by liudukun on 2017/9/4.
//  Copyright © 2017年 chinaexpresscard. All rights reserved.
//

#import "ZJPullViewController.h"

@interface ZJPullViewController ()



@end

@implementation ZJPullViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initPullView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initPullView{
    self.view = [[UIView alloc]initWithFrame:CGRectMake(-200, 0, 200, self.view.frame.size.height)];
    self.view.backgroundColor = [UIColor grayColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 100, 100)];
    label.text = @"test button";
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
    
}




@end
