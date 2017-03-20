//
//  MultileveMenu.m
//  MultilevelMenu
//
//  Created by zhanghaidi on 2017/3/13.
//  Copyright © 2017年 yanshu. All rights reserved.
//

#import "MultileveMenu.h"
#import "MenuLeftTableViewCell.h"
#import "MenuCollectionViewCell.h"
#import "MenuCollectionSupplementaryView.h"
#import "MenuHeaderImageReusableView.h"

#define kPrimaryColumnWidth 100

@interface MultileveMenu ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UICollectionView *rightCollectionView;
@property (nonatomic, assign) NSInteger selectedMasterRow;

@end


@implementation MultileveMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        /**
         左边的视图
         */
        [self addSubview:self.leftTableView];
        [self addSubview:self.rightCollectionView];
        self.selectedMasterRow = 0;
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    return self;
}

- (void)configConstraints {
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(self);
        make.width.mas_equalTo(kPrimaryColumnWidth);
    }];
    [self.rightCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.left.equalTo(self.leftTableView.mas_right);
    }];
}

#pragma mark - TableView Delegate 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MenuLeftTableViewCellIdentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedMasterRow == indexPath.row) {
        return;
    }
    self.selectedMasterRow = indexPath.row;
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    [self.rightCollectionView setContentOffset:CGPointZero animated:NO];
    [self.rightCollectionView reloadData];
}

#pragma mark - CollectionView  Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(floorf((self.frame.size.width - kPrimaryColumnWidth - 20 - 10) / 3), 100);
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(self.frame.size.width - kPrimaryColumnWidth - 20 - 10, 100);
    }
    return CGSizeMake(self.frame.size.width - kPrimaryColumnWidth - 20 - 10, 30);
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    MenuCollectionSupplementaryView *header = nil;
    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 0) {
              header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MenuHeaderImageReusableViewIdentifier forIndexPath:indexPath];
        } else {
            __weak typeof (self) weakSelf = self;
            header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MenuCollectionSupplementaryViewIdentifier forIndexPath:indexPath];
            [header setSectionText:[NSString stringWithFormat:@"Section %d", (int)indexPath.section]];
            header.buttonActionBlock = ^{
                [weakSelf pushMoreProductsWithIndexPath:indexPath];
            };
        }
    }
    return header;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 10;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MenuCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [self randomColor];
    cell.titleLabel.text = [[NSString alloc] initWithFormat:@"T:%d\nC:S->%d\nR->%d", (int)self.selectedMasterRow, (int)indexPath.section, (int)indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(multileveMenu:didSelectedItemWithMenuIndexPath:)]) {
        MultileveMenuIndexPath *menuIndexPath = [self menuIndexPathWithSecondaryIndexPath:indexPath];
        [self.delegate multileveMenu:self didSelectedItemWithMenuIndexPath:menuIndexPath];
    }
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (MultileveMenuIndexPath *)menuIndexPathWithSecondaryIndexPath:(NSIndexPath *)indexPath {
     MultileveMenuIndexPath *menuIndexPath = [MultileveMenuIndexPath indexPathForSecondaryItem:indexPath inMaster:self.selectedMasterRow];
    return menuIndexPath;
}

#pragma mark - Action

- (void)pushMoreProductsWithIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(multileveMenu:didSelectedMoreWithMenuIndexPath:)]) {
        MultileveMenuIndexPath *menuIndexPath = [self menuIndexPathWithSecondaryIndexPath:indexPath];
        [self.delegate multileveMenu:self didSelectedMoreWithMenuIndexPath:menuIndexPath];
    }
}

#pragma mark - Getter 

- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kPrimaryColumnWidth, self.frame.size.height)];
       _leftTableView.dataSource = self;
       _leftTableView.delegate = self;
       _leftTableView.tableFooterView = [[UIView alloc] init];
        if ([_leftTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            _leftTableView.layoutMargins=UIEdgeInsetsZero;
        }
        if ([_leftTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            _leftTableView.separatorInset=UIEdgeInsetsZero;
        }
        [_leftTableView registerClass:[MenuLeftTableViewCell class] forCellReuseIdentifier:MenuLeftTableViewCellIdentifier];
    }
    return _leftTableView;
}

- (UICollectionView *)rightCollectionView {
    if (!_rightCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _rightCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kPrimaryColumnWidth, 0, self.frame.size.width - kPrimaryColumnWidth, self.frame.size.height) collectionViewLayout:flowLayout];
        _rightCollectionView.backgroundColor = [UIColor clearColor];
        _rightCollectionView.delegate = self;
        _rightCollectionView.dataSource = self;
        [_rightCollectionView registerClass:[MenuCollectionViewCell class] forCellWithReuseIdentifier:MenuCollectionViewCellIdentifier];
        
        [_rightCollectionView registerClass:[MenuCollectionSupplementaryView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:MenuCollectionSupplementaryViewIdentifier];
        
        [_rightCollectionView registerClass:[MenuHeaderImageReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MenuHeaderImageReusableViewIdentifier];
        
    }
    return _rightCollectionView;
}

@end

@interface MultileveMenuIndexPath ()

@property (nonatomic, assign) NSInteger masterIndex;
@property (nonatomic, strong) NSIndexPath *secondaryPath;

@end

@implementation MultileveMenuIndexPath

- (instancetype)initWithMasterRow:(NSInteger)masterRow secondaryIndexPath:(NSIndexPath *)secondaryIndexPath {
    self = [super init];
    if (self) {
        self.masterIndex = masterRow;
        self.secondaryPath = secondaryIndexPath;
    }
    return self;
}

+ (instancetype)indexPathForSecondaryItem:(NSIndexPath *)secondaryIndexPath inMaster:(NSInteger)masterRow {
    MultileveMenuIndexPath *indexPath = [[MultileveMenuIndexPath alloc] initWithMasterRow:masterRow secondaryIndexPath:secondaryIndexPath];
    return indexPath;
}

- (NSInteger)masterRow {
    return self.masterIndex;
}

- (NSIndexPath *)secondaryIndexPath {
    return self.secondaryPath;
}

@end
