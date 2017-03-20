//
//  MenuCollectionSupplementView.h
//  MultilevelMenu
//
//  Created by zhanghaidi on 2017/3/14.
//  Copyright © 2017年 yanshu. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const MenuCollectionSupplementaryViewIdentifier;

typedef void (^MenuCollectionMoreButtonActionBlock)();
@interface MenuCollectionSupplementaryView : UICollectionReusableView

@property (nonatomic, retain) UILabel  *sectionTitle;
@property (nonatomic, retain) UIButton *moreButton;
@property (nonatomic, retain) UILabel  *tipLabel;

@property (nonatomic, copy) MenuCollectionMoreButtonActionBlock buttonActionBlock;

- (void)setSectionText:(NSString *)text;

@end
