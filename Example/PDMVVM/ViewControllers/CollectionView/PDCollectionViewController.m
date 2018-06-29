//
//  PDCollectionViewController.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDCollectionViewController.h"
#import "PDCellInfo.h"

@interface PDCollectionViewController ()


@end

@implementation PDCollectionViewController

+ (nonnull NSString*)segueIdentifier {
    NSString *classString = NSStringFromClass(self);
    classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    classString = [classString stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
    NSString *identifier = [NSString stringWithFormat:@"%@Segue",classString];
    return identifier;
}

- (void)setRefreshEnabled:(BOOL)refreshEnabled {
    [super setRefreshEnabled:refreshEnabled];
    
    if (@available(iOS 10.0, *)) {
        if (refreshEnabled) {
            [self.collectionView setRefreshControl:self.refreshControl];
        } else {
            [self.collectionView setRefreshControl:nil];
        }
    }
    else {
        if (refreshEnabled) {
            [self.collectionView addSubview:self.refreshControl];
        } else {
            [self.refreshControl removeFromSuperview];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.registeredCells = [NSMutableArray new];
    self.registeredPrototypes = [NSMutableDictionary new];
}

- (void)prepareCell:(UICollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGSize )cellSizeForItemAt:(nonnull NSIndexPath *)indexPath {
    return [self defaultCellSize];
}

- (CGSize )dynamicCellSizeForItem:(nonnull NSIndexPath *)indexPath itemsCount:(NSInteger)itemsCount {
    CGSize defaultSize = [self defaultCellSize];
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    if (itemsCount == 0) {
        return defaultSize;
    }
    
    UIEdgeInsets insets = flowLayout.sectionInset;
    if ([self respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        insets = [self collectionView:self.collectionView layout:flowLayout insetForSectionAtIndex:indexPath.section];
    }
    
    if (flowLayout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        CGFloat contentWidth = self.collectionView.frame.size.width - insets.left - insets.right - flowLayout.minimumInteritemSpacing * (itemsCount - 1);
        CGFloat width = itemsCount > 1 ? contentWidth / itemsCount  : contentWidth;
        return CGSizeMake(width, defaultSize.height);
        
    } else {
        CGFloat contentHeight = self.collectionView.frame.size.height - insets.top - insets.bottom - flowLayout.minimumLineSpacing * (itemsCount - 1);
        CGFloat height = itemsCount > 1 ? contentHeight / itemsCount  : contentHeight;
        return CGSizeMake(defaultSize.width, height);
    }
}

- (CGSize)defaultCellSize {
    return CGSizeMake(100, 100);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionsViewModel.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id <PDSectionInfo> sectionInfo = [self.sectionsViewModel sectionInfoForSection:section];
    return sectionInfo.items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id <PDItemInfo> itemInfo = [self.sectionsViewModel itemInfoForIndexPath:indexPath];
    
    NSString *cellIdentifier = [self.sectionsViewModel cellIdentifierForIndexPath:indexPath];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", cellIdentifier];
    NSArray <NSString *> *filtered = [self.registeredCells filteredArrayUsingPredicate:predicate];
    if (!filtered.count) {
        Class cellClass = [self.sectionsViewModel classForRowAtIndexPath:indexPath];
        [collectionView registerClass:cellClass forCellWithReuseIdentifier:cellIdentifier];
        [self.registeredCells addObject:cellIdentifier];
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    id <PDCellInfo> cellInfo  = (id <PDCellInfo>)cell;
    cellInfo.itemInfo = itemInfo;
    
    cellInfo.reloadCellBlock = ^{
        [collectionView.collectionViewLayout invalidateLayout];
        [collectionView performBatchUpdates:^{
            
        } completion:^(BOOL finished) {
            
        }];
    };
    
    [self prepareCell:cell forIndexPath:indexPath];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self cellSizeForItemAt:indexPath];
}

- (CGSize)fitingSizeForIndexPath:(NSIndexPath *)indexPath withSize:(CGSize)dynamicSize {
    
    id <PDItemInfo> itemInfo = [self.sectionsViewModel itemInfoForIndexPath:indexPath];
    
    NSString *cellIdentifier = [self.sectionsViewModel cellIdentifierForIndexPath:indexPath];
    UICollectionViewCell *prototype = self.registeredPrototypes[cellIdentifier];
    if (!prototype) {
        prototype = [[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:nil options:nil] objectAtIndex:0];
        
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:prototype.contentView attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:dynamicSize.width];
        [NSLayoutConstraint activateConstraints:@[width]];
        
        self.registeredPrototypes[cellIdentifier] = prototype;
    }
    
    id <PDCellInfo> cellInfo  = (id <PDCellInfo>)prototype;
    
    cellInfo.itemInfo = itemInfo;
    CGSize s = [prototype systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return s;
}

@end
