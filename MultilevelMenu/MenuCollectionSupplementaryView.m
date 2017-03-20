//
//  MenuCollectionSupplementView.m
//  MultilevelMenu
//
//  Created by zhanghaidi on 2017/3/14.
//  Copyright © 2017年 yanshu. All rights reserved.
//

#import "MenuCollectionSupplementaryView.h"

NSString * const MenuCollectionSupplementaryViewIdentifier = @"MenuCollectionSupplementaryView";

@implementation MenuCollectionSupplementaryView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.sectionTitle];
        [self addSubview:self.moreButton];
    }
    return self;
}

- (void)setSectionText:(NSString *)text {
    self.sectionTitle.text = text;
    CGFloat sectionTitleBestWidth = self.sectionTitle.intrinsicContentSize.width;
    self.sectionTitle.frame = CGRectMake(10, 0, sectionTitleBestWidth, self.frame.size.height);
    
    self.moreButton.frame = CGRectMake(self.frame.size.width - 80, 0, 80, self.frame.size.height);
}

- (void)clickedMore:(UIButton *)sender {
    if (self.buttonActionBlock) {
        self.buttonActionBlock();
    }
}

#pragma mark - Getter

- (UILabel *)sectionTitle {
    if (!_sectionTitle) {
        _sectionTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        _sectionTitle.font = [UIFont systemFontOfSize:15];
    }
    return _sectionTitle;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setTitle:@"更多" forState:UIControlStateNormal];
        [_moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_moreButton addTarget:self action:@selector(clickedMore:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

@end
