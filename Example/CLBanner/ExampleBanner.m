//
//  ExampleBanner.m
//  CLBanner
//
//  Created by Yeung Yiu Hung on 8/10/15.
//  Copyright (c) 2015 Yeung Yiu Hung. All rights reserved.
//

#import "ExampleBanner.h"

@implementation ExampleBanner

- (void)bannerWillShowWithInfo:(NSDictionary *)info{
    _titleLabel.text = info[@"title"];
    _descriptionLabel.text = info[@"description"];
}

- (id)init{
    if (self = [super init]) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class)   owner:self options:nil];
        self = [objects firstObject];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
