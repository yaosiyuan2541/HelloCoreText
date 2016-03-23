//
//  ViewController.m
//  HelloCoreText
//
//  Created by 姚思远 on 16/2/17.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "CTView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CTView * ctView = [[CTView alloc]initWithFrame:CGRectMake(0, 20, 320, 548)];
    ctView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ctView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
