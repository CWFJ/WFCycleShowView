//
//  ViewController.m
//  WFCycleShowView
//
//  Created by 开发者 on 15/5/4.
//  Copyright (c) 2015年 Jason. All rights reserved.
//

#import "ViewController.h"
#import "WFCycleShowView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *arrayImage = [NSMutableArray array];
    for (int i = 1; i < 6; i++) {
        UIImage *image = [[UIImage alloc] init];
        [arrayImage addObject:image];
    }
    WFCycleShowView *cycleView = [WFCycleShowView cycleShowWithImages:arrayImage andSize:CGSizeMake(self.view.frame.size.width, 120)];
    cycleView.isAutoShow = YES;
    [self.view addSubview:cycleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
