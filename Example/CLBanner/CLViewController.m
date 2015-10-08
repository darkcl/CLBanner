//
//  CLViewController.m
//  CLBanner
//
//  Created by Yeung Yiu Hung on 10/08/2015.
//  Copyright (c) 2015 Yeung Yiu Hung. All rights reserved.
//

#import "CLViewController.h"
#import "ExampleBanner.h"

@interface CLViewController ()

@end

@implementation CLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [CLBanner setDefaultViewController:self];
    [CLBanner showBannerWithViewClass:[ExampleBanner class]
                             userInfo:@{@"title":@"title",
                                        @"description": @"1234"}
                             duration:0.5
                             autoHide:NO
                         hideDuration:2.0
                         bannerHeight:200
                                  tap:^{
                                      NSLog(@"tap!");
                                      [CLBanner hideBanner];
                                  }
                           completion:^{
                               NSLog(@"show complete");
                           }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
