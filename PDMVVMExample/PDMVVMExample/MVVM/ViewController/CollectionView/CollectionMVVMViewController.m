//
//  CollectionMVVMViewController.m
//  Commerce
//
//  Created by Pavel Deminov on 24/08/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import "CollectionMVVMViewController.h"
#import "MVVMCollectionViewCell.h"
#import "MVVMCollectionReusableView.h"

@interface CollectionMVVMViewController ()

@property (nonatomic) BOOL fromCode;
@property (nonatomic, strong) NSMutableDictionary *reuseIdentifiersDict;

@end

@implementation CollectionMVVMViewController


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

- (CollectionMVVMViewModel *)collectionViewModel {
    return (CollectionMVVMViewModel *)self.viewModel;
}

+ (instancetype)create {
    CollectionMVVMViewController *vc = [self new];
    vc.fromCode = YES;
    return vc;
}

- (void)loadView {
    if (self.fromCode) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:view.frame collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor clearColor];
        [view addSubview:collectionView];
        self.view = view;
        self.collectionView = collectionView;
        collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *top = [collectionView.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor constant:0.0];
        NSLayoutConstraint *bottom = [collectionView.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor constant:0.0];
        NSLayoutConstraint *right = [collectionView.leftAnchor constraintEqualToAnchor:view.leftAnchor constant:0.0];
        NSLayoutConstraint *left = [collectionView.rightAnchor constraintEqualToAnchor:view.rightAnchor constant:0.0];
        [NSLayoutConstraint activateConstraints:@[top, bottom, right, left]];
        self.bottomConstraint = bottom;
       
    } else {
        [super loadView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self registerReusableElements];
}

- (void)registerReusableElements {
    self.reuseIdentifiersDict = [NSMutableDictionary new];
    
    for (NSString *cellIdentifier in self.collectionViewModel.cellIdentifiersFromNib) {
        [self.reuseIdentifiersDict setValue:cellIdentifier forKey:cellIdentifier];
        [self.collectionView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    }
    
    for (NSString *cellIdentifier in self.collectionViewModel.cellIdentifiers) {
        [self.reuseIdentifiersDict setValue:cellIdentifier forKey:cellIdentifier];
        [self.collectionView registerClass:NSClassFromString(cellIdentifier) forCellWithReuseIdentifier:cellIdentifier];
    }
    
    for (NSString *headerIdentifier in self.collectionViewModel.headerIdentifiersFromNib) {
        [self.reuseIdentifiersDict setValue:headerIdentifier forKey:headerIdentifier];
        [self.collectionView registerNib:[UINib nibWithNibName:headerIdentifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    }
    
    for (NSString *headerIdentifier in self.collectionViewModel.headerIdentifiers) {
        [self.reuseIdentifiersDict setValue:headerIdentifier forKey:headerIdentifier];
        [self.collectionView registerClass:NSClassFromString(headerIdentifier) forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    }
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.collectionViewModel numberOfSections];
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.collectionViewModel numberOfItemsInSection:section];
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MVVMViewModel *viewModel = [self.collectionViewModel viewModelAtIndexPath:indexPath];
    NSString *cellIdentifier = [self.collectionViewModel cellIdentifierForIndexPath:indexPath];

    if ([self.reuseIdentifiersDict objectForKey:cellIdentifier] == nil) {
        [self.reuseIdentifiersDict setValue:cellIdentifier forKey:cellIdentifier];
        if (viewModel.notNib) {
            [self.collectionView registerClass:NSClassFromString(cellIdentifier) forCellWithReuseIdentifier:cellIdentifier];
        } else {
            [self.collectionView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
        }
    }
    
    MVVMCollectionViewCell *cell = (MVVMCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (viewModel) {
        cell.viewModel = viewModel;
    }
    
    cell.separator.hidden = ![self.collectionViewModel shouldShowSeparatorForIndexPath:indexPath];
    
    [cell roundCorners:[self.collectionViewModel cornersForIndexPath:indexPath]];
    [cell showShadow:[self.collectionViewModel shouldShowShadowForIndexPath:indexPath]];

    
    [self prepareCell:cell forIndexPath:indexPath];
    
    return cell;
}


- (void)prepareCell:(MVVMCollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    CGSize size = [self sizeForHeaderFooterAtSection:section];
    return size;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    NSString *headerIdentifier = [self.collectionViewModel headerIdentifierForSection:indexPath.section];
    
     id sectionInfo = [self.collectionViewModel sectionInfoForSection:indexPath.section];
    
    if ([sectionInfo conformsToProtocol:@protocol(MVVMSectionInfo) ]) {
        id <MVVMSectionInfo> sectionInfoMVVM = sectionInfo;
        MVVMViewModel *viewModel = sectionInfoMVVM.viewModel;
        
        if ([self.reuseIdentifiersDict objectForKey:headerIdentifier] == nil) {
            [self.reuseIdentifiersDict setValue:headerIdentifier forKey:headerIdentifier];
            if (viewModel.notNib) {
                [self.collectionView registerClass:NSClassFromString(headerIdentifier) forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
            } else {
                [self.collectionView registerNib:[UINib nibWithNibName:headerIdentifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
            }
        }
    }
    
    MVVMCollectionReusableView *sectionHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
    
    if ([sectionInfo conformsToProtocol:@protocol(MVVMSectionInfo) ]) {
        id <MVVMSectionInfo> sectionInfoMVVM = sectionInfo;
        MVVMViewModel *viewModel = sectionInfoMVVM.viewModel;
        
        sectionHeaderView.viewModel = viewModel;
    } 
    
    [self prepareReusableView:sectionHeaderView forSection:indexPath.section];
    
    return sectionHeaderView;
}

- (void)prepareReusableView:(UICollectionReusableView *)reusableView forSection:(NSInteger)section {
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
#pragma mark -

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGSize size = [self sizeForItemAtIndexPath:indexPath];
    NSString *classString = [self.collectionViewModel cellIdentifierForIndexPath:indexPath];
    
    if ([classString isEqualToString:@"ExtraSpaceCollectionViewCell"]) {
        size.height = size.height > 0 ? size.height : [self freeContentViewSpace];
    }
    
    return size;
}

- (CGFloat)freeContentViewSpace {
    
    CGFloat contentHeight = 0;
    
    for (NSInteger s=0;s< self.collectionViewModel.sections.count;s++) {
        id <MVVMSectionInfo> sectionInfo = [self.collectionViewModel sectionInfoForSection:s];
        CGSize size = [self sizeForHeaderFooterAtSection:s];
        contentHeight+=size.height;
        
        for (NSInteger r=0;r< sectionInfo.viewModels.count;r++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:r inSection:s];
            CGSize size = [self sizeForItemAtIndexPath:indexPath];
            contentHeight+=size.height;
        }
        
        UIEdgeInsets insets = [self.collectionViewModel insetForSectionAtIndex:s];
        CGFloat minimumLineSpacing = [self.collectionViewModel minimumLineSpacingForSectionAtIndex:s];
        
        contentHeight+= insets.top + insets.bottom + minimumLineSpacing * (sectionInfo.viewModels.count - 1);
    }
    
    CGFloat height = self.collectionView.frame.size.height - contentHeight;
    
    return height > 0 ? height : 0;
}

- (CGSize)sizeForHeaderFooterAtSection:(NSInteger)section {
    
    CGSize size = [self.collectionViewModel referenceSizeForHeaderInSection:section];
    size.width =  self.collectionView.frame.size.width;
    
    NSString *classString = [self.collectionViewModel headerIdentifierForSection:section];
    
    classString = [[classString componentsSeparatedByString:@"."] lastObject];
    Class class = NSClassFromString(classString);
    if ([class respondsToSelector:@selector(sizeForViewWithViewModel:withViewWidth:)]) {
        id sectionInfo = [self.collectionViewModel sectionInfoForSection:section];
        
        if ([sectionInfo conformsToProtocol:@protocol(MVVMSectionInfo) ]) {
            id <MVVMSectionInfo> sectionInfoMVVM = sectionInfo;
            MVVMViewModel *viewModel = sectionInfoMVVM.viewModel;
            size.height = [class sizeForViewWithViewModel:viewModel withViewWidth:size.width];
        }
    }
    
    return size;
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger numberOfItemsItRow = [self.collectionViewModel numberOfItemsInRowForSection:indexPath.section];
    CGSize size = [self.collectionViewModel sizeForItemAtIndexPath:indexPath];
    
    CGFloat width = size.width;
    if (width == 0) {
        width = [self widthForCellForItemsCount:numberOfItemsItRow atIndexPath:indexPath];
    }
    
    CGFloat height = size.height;
    BOOL shouldHeightEqualToWidth = [self.collectionViewModel shouldHeightEqualWidth:indexPath];
    if (shouldHeightEqualToWidth) {
        height = width;
    } else if (height == 0) {
        NSString *classString = [self.collectionViewModel cellIdentifierForIndexPath:indexPath];
        classString = [[classString componentsSeparatedByString:@"."] lastObject];
        Class class = NSClassFromString(classString);
        
        MVVMViewModel *viewModel = [self.collectionViewModel viewModelAtIndexPath:indexPath];
        if (viewModel) {
            if ([class respondsToSelector:@selector(sizeForCellWithViewModel:withCellWidth:)]) {
                height = [class sizeForCellWithViewModel:viewModel withCellWidth:width];
            }
            
        } 
    }
    
    return CGSizeMake(width, height);
}


- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return [self.collectionViewModel minimumLineSpacingForSectionAtIndex:section];
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return [self.collectionViewModel minimumInteritemSpacingForSectionAtIndex:section];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return [self.collectionViewModel insetForSectionAtIndex:section];
}

- (CGFloat)widthForCellForItemsCount:(NSInteger)itemsCount atIndexPath:(NSIndexPath *)indexPath {
    if (![self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        NSAssert(NO, @"Not available");
    }
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    CGSize defaultSize = flowLayout.itemSize;
    
    if (itemsCount == 0) {
        return defaultSize.width;
    }
    
    UIEdgeInsets insets = [self.collectionViewModel insetForSectionAtIndex:indexPath.section];
    CGFloat minimumInteritemSpacing = [self.collectionViewModel minimumInteritemSpacingForSectionAtIndex:indexPath.section];
    CGFloat minimumLineSpacing = [self.collectionViewModel minimumLineSpacingForSectionAtIndex:indexPath.section];
    
    if (flowLayout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        CGFloat contentWidth = self.collectionView.frame.size.width - insets.left - insets.right - minimumInteritemSpacing * (itemsCount - 1);
        CGFloat width = itemsCount > 1 ? contentWidth / itemsCount  : contentWidth;
        return CGSizeMake(width, defaultSize.height).width;
        
    } else {
        CGFloat contentHeight = self.collectionView.frame.size.height - insets.top - insets.bottom - minimumLineSpacing * (itemsCount - 1);
        CGFloat height = itemsCount > 1 ? contentHeight / itemsCount  : contentHeight;
        return CGSizeMake(defaultSize.width, height).width;
    }
}

#pragma mark ViewModelDelegate

- (void)viewModelUpdated:(MVVMViewModel *)viewModel {
    [self updateUI];
    [self.collectionView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)viewModel:(MVVMViewModel *)viewModel didDeleteModel:(id)model atIndexPath:(NSIndexPath *)indexPath {
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

- (void)viewModel:(MVVMViewModel *)viewModel didUpdateModel:(id)model atIndexPath:(NSIndexPath *)indexPath {
    
    __block MVVMCollectionViewCell *cell = (MVVMCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [self.collectionView.collectionViewLayout invalidateLayout];
   
    [cell updateViewModelUI];
    [cell updateModelUI];
    [cell updateUI];
}

- (void)viewModelsUpdatedAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self.collectionView reloadItemsAtIndexPaths:indexPaths];
}

- (void)sectionViewModelDidInsertSectionsAtIndexSet:(NSIndexSet *)indexSet completion:(void (^)(BOOL))completion {
    __weak typeof(self)wSelf = self;
    [self.collectionView performBatchUpdates:^{
        [wSelf.collectionView insertSections:indexSet];
    } completion:completion];
}

- (void)sectionViewModelDidDeleteSectionsAtIndexSet:(NSIndexSet *)indexSet completion:(void (^)(BOOL))completion {
    __weak typeof(self)wSelf = self;
    [self.collectionView performBatchUpdates:^{
        [wSelf.collectionView deleteSections:indexSet];
    } completion:completion];
}

- (void)sectionReloadSections:(NSIndexSet *)indexSet {
    [self.collectionView reloadSections:indexSet];
}

@end
