//
//  MenuHeaderImageReusableView.m
//  MultilevelMenu
//
//  Created by zhanghaidi on 2017/3/15.
//  Copyright © 2017年 yanshu. All rights reserved.
//

#import "MenuHeaderImageReusableView.h"

NSString *const MenuHeaderImageReusableViewIdentifier = @"MenuHeaderImageReusableView";

@implementation MenuHeaderImageReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bannerImageView];
    }
    return self;
}

#pragma mark - Getter 

- (UIImageView *)bannerImageView {
    if (!_bannerImageView) {
        _bannerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width - 20, self.frame.size.height - 15)];
        _bannerImageView.backgroundColor = [UIColor redColor];
        _bannerImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bannerImageView;
}

@end
