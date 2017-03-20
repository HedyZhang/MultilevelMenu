//
//  MenuLeftTableViewCell.m
//  MultilevelMenu
//
//  Created by zhanghaidi on 2017/3/13.
//  Copyright © 2017年 yanshu. All rights reserved.
//

#import "MenuLeftTableViewCell.h"

 NSString * const MenuLeftTableViewCellIdentifier = @"MenuLeftTableViewCell";

@implementation MenuLeftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor redColor];
    }
    return _titleLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
