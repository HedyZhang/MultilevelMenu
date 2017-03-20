//
//  MultileveMenu.h
//  MultilevelMenu
//
//  Created by zhanghaidi on 2017/3/13.
//  Copyright © 2017年 yanshu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MultileveMenuIndexPath, MultileveMenu;
@protocol MultileveMenuDelegate <NSObject>

@optional

- (UICollectionViewCell *)multileveMenu:(MultileveMenu *)menu cellForItemAtMenuIndexPath:(MultileveMenuIndexPath *)indexPath;
- (BOOL)multileveMenu:(MultileveMenu *)menu shouldShowItemHeaderAtMasterRow:(NSInteger)row;
- (void)multileveMenu:(MultileveMenu *)menu didSelectedItemWithMenuIndexPath:(MultileveMenuIndexPath *)indexPath;
- (void)multileveMenu:(MultileveMenu *)menu didSelectedMoreWithMenuIndexPath:(MultileveMenuIndexPath *)indexPath;

@end

@interface MultileveMenu : UIView

@property (nonatomic, weak) id<MultileveMenuDelegate> delegate;

@end


@interface MultileveMenuIndexPath : NSObject

+ (instancetype)indexPathForSecondaryItem:(NSIndexPath *)secondaryIndexPath inMaster:(NSInteger)masterRow;

@property (nonatomic, readonly) NSInteger masterRow;
@property (nonatomic, readonly) NSIndexPath *secondaryIndexPath;

@end
