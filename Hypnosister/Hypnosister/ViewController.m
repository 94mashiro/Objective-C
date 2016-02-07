//
//  ViewController.m
//  Hypnosister
//
//  Created by Shiina Mashiro on 16/1/25.
//  Copyright © 2016年 Shiina Mashiro. All rights reserved.
//

#import "ViewController.h"
#include "HypnosisView.h"

@interface ViewController ()
@property (nonatomic, strong) HypnosisView *hypnosisView;
@property (nonatomic, strong) HypnosisView *anotherView;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGRect firstFrame = self.view.bounds;
//    HypnosisView *firstView = [[HypnosisView alloc] initWithFrame:firstFrame];
//    firstView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:firstView];
    
    CGRect screenRect = self.view.bounds;
    CGRect bigRect = screenRect;
    bigRect.size.width *= 2.0;
    bigRect.size.height *= 2.0;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    [scrollView setPagingEnabled:NO];
    [self.view addSubview:scrollView];
    
    self.hypnosisView = [[HypnosisView alloc] initWithFrame:screenRect];
    [scrollView addSubview:self.hypnosisView];
    screenRect.origin.x += screenRect.size.width;
    self.anotherView = [[HypnosisView alloc] initWithFrame:screenRect];
    [scrollView addSubview:self.anotherView];
    scrollView.contentSize = bigRect.size;
    self.view.backgroundColor = [UIColor whiteColor];
    scrollView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.hypnosisView;
}



@end
