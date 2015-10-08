//
//  ExampleBanner.h
//  CLBanner
//
//  Created by Yeung Yiu Hung on 8/10/15.
//  Copyright (c) 2015 Yeung Yiu Hung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CLBanner/CLBanner.h>

@interface ExampleBanner : UIView<CLBannerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
