//
//  CollectionMVVMViewModel.m
//  Commerce
//
//  Created by Pavel Deminov on 24/08/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import "CollectionMVVMViewModel.h"
#import "MVVMSection.h"

@implementation CollectionMVVMViewModel

- (NSArray <NSString *> *)cellIdentifiers {
    return nil;
}

- (NSArray <NSString *> *)cellIdentifiersFromNib {
    return nil;
}

- (NSArray <NSString *> *)headerIdentifiers {
    return nil;
}

- (NSArray <NSString *> *)headerIdentifiersFromNib {
    return nil;
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(0, 0);
}

- (NSInteger)numberOfItemsInRowForSection:(NSInteger)section {
    return 1;
}

- (CGFloat)minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

- (UIEdgeInsets)insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)referenceSizeForHeaderInSection:(NSInteger)section {
     return CGSizeZero;
}

- (BOOL)shouldShowSeparatorForIndexPath:(NSIndexPath *)indexPath {
    id sectionInfo = [self sectionInfoForSection:indexPath.section];
    BOOL show = NO;
    if ([sectionInfo conformsToProtocol:@protocol(MVVMSectionInfo) ]) {
        id <MVVMSectionInfo> sectionInfoMVVM = sectionInfo;
        id  viewModel = [self viewModelAtIndexPath:indexPath];
        show = sectionInfoMVVM.viewModels.lastObject != viewModel;
    }

    return show;
}

- (UIRectCorner)cornersForIndexPath:(NSIndexPath *)indexPath {
    id sectionInfo = [self sectionInfoForSection:indexPath.section];
    if ([sectionInfo conformsToProtocol:@protocol(MVVMSectionInfo) ]) {
        id <MVVMSectionInfo> sectionInfoMVVM = sectionInfo;
        id  viewModel = [self viewModelAtIndexPath:indexPath];
        
        if (sectionInfoMVVM.viewModels.firstObject == viewModel && sectionInfoMVVM.viewModels.count == 1) {
            return UIRectCornerAllCorners;
        }  else if  (sectionInfoMVVM.viewModels.lastObject == viewModel) {
            return UIRectCornerBottomLeft | UIRectCornerBottomRight;
        } else if  (sectionInfoMVVM.viewModels.firstObject == viewModel) {
            return UIRectCornerTopLeft | UIRectCornerTopRight;
        } else {
            return 0;
        }
        
    }
    
    return 0;
}

- (BOOL)shouldShowShadowForIndexPath:(NSIndexPath *)indexPath {
    id sectionInfo = [self sectionInfoForSection:indexPath.section];
    if ([sectionInfo conformsToProtocol:@protocol(MVVMSectionInfo) ]) {
        id <MVVMSectionInfo> sectionInfoMVVM = sectionInfo;
        id  viewModel = [self viewModelAtIndexPath:indexPath];
        
        if  (sectionInfoMVVM.viewModels.lastObject == viewModel) {
            return YES;
        }  else {
            return NO;
        }
        
    }
    
    return NO;
}

- (BOOL)shouldHeightEqualWidth:(NSIndexPath *)indexPath {
    return NO;
}

- (NSArray <MVVMViewModel *> *)viewModelsInSection:(NSInteger)section {
    MVVMSection *mvvmSection = [self.sections objectAtIndex:section];
    return mvvmSection.viewModels;
}

- (void)validate {
    [self validateBackground:NO];
}

- (void)validateBackground:(BOOL)background {
    self.errorIndexPath = nil;
    for (MVVMSection *section in self.sections) {
        [section validateBackground:background];
        if (section.errorModel) {
            self.errorIndexPath = [self indexPathForModel:section.errorModel];
            break;
        }
    }
}

- (void)validateObjectWithApiKey:(NSString *)apiKey {
    [self validateObjectWithApiKey:apiKey background:NO];
}

- (void)validateObjectWithApiKey:(NSString *)apiKey background:(BOOL)background {
    self.errorIndexPath = nil;
    for (MVVMSection *section in self.sections) {
        [section validateObjectWithApiKey:apiKey background:background];
        if (section.errorModel) {
            self.errorIndexPath = [self indexPathForModel:section.errorModel];
            break;
        }
    }
}

- (BOOL)preValidateResult {
    BOOL result = YES;
    for (MVVMSection *section in self.sections) {
        result = [section preValidateResult];
        if (result == NO) {
            break;
        }
    }
    return result;
}

- (void)invalidate {
    self.errorIndexPath = nil;
}

@end
