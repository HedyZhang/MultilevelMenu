//
//  MenuCollectionViewCell.m
//  MultilevelMenu
//
//  Created by zhanghaidi on 2017/3/14.
//  Copyright © 2017年 yanshu. All rights reserved.
//

#import "MenuCollectionViewCell.h"

NSString * const MenuCollectionViewCellIdentifier = @"MenuCollectionViewCell";

@implementation MenuCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self configConstraints];
    }
    return self;
}

- (void)configConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}


#pragma mark - Getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor redColor];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

@end
