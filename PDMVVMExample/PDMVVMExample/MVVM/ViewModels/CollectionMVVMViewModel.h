//
//  CollectionMVVMViewModel.h
//  Commerce
//
//  Created by Pavel Deminov on 24/08/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import "SectionsMVVMViewModel.h"
@import UIKit;
@import CoreGraphics;

@interface CollectionMVVMViewModel : SectionsMVVMViewModel

@property (nonatomic, strong) NSIndexPath *errorIndexPath;

- (NSArray <NSString *> *)cellIdentifiers;
- (NSArray <NSString *> *)cellIdentifiersFromNib;

- (NSArray <NSString *> *)headerIdentifiers;
- (NSArray <NSString *> *)headerIdentifiersFromNib;

- (NSInteger)numberOfItemsInRowForSection:(NSInteger)section;
- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)shouldHeightEqualWidth:(NSIndexPath *)indexPath;

- (CGFloat)minimumLineSpacingForSectionAtIndex:(NSInteger)section;
- (CGFloat)minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
- (UIEdgeInsets)insetForSectionAtIndex:(NSInteger)section;

- (CGSize)referenceSizeForHeaderInSection:(NSInteger)section;

- (BOOL)shouldShowSeparatorForIndexPath:(NSIndexPath *)indexPath;
- (UIRectCorner)cornersForIndexPath:(NSIndexPath *)indexPath;
- (BOOL)shouldShowShadowForIndexPath:(NSIndexPath *)indexPath;

- (NSArray <MVVMViewModel *> *)viewModelsInSection:(NSInteger)section;

- (void)validate;
- (void)validateBackground:(BOOL)background;
- (void)validateObjectWithApiKey:(NSString *)apiKey;
- (BOOL)preValidateResult;

- (void)invalidate;

@end
