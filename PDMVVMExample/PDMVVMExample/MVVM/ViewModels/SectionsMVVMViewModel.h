//
//  SectionsMVVMViewModel.h
//  Commerce
//
//  Created by Pavel Deminov on 06/09/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import "MVVMViewModel.h"
#import "MVVMSectionInfo.h"

@class SectionsMVVMViewModel;

@protocol SectionViewModelDelegate <ViewModelDelegate>

@optional

- (void)viewModel:(MVVMViewModel *)viewModel didDeleteModel:(id)model atIndexPath:(NSIndexPath *)indexPath;
- (void)viewModel:(MVVMViewModel *)viewModel didUpdateModel:(id)model atIndexPath:(NSIndexPath *)indexPath;
- (void)viewModelsUpdatedAtIndexPaths:(NSArray <NSIndexPath *> *)indexPaths;
- (void)viewModelRefreshStatusChanged:(BOOL)isRefreshing;
- (void)sectionReloadSections:(NSIndexSet *)indexSet;

- (void)sectionViewModelDidInsertSectionsAtIndexSet:(NSIndexSet *)indexSet completion:(void (^)(BOOL finished))completion;
- (void)sectionViewModelDidDeleteSectionsAtIndexSet:(NSIndexSet *)indexSet completion:(void (^)(BOOL finished))completion;

@end

@interface SectionsMVVMViewModel : MVVMViewModel <ViewModelDelegate>

@property (nonatomic, strong) NSArray <MVVMSectionInfo> *sections;
@property (nonatomic, weak) id <SectionViewModelDelegate, ViewModelDelegate> viewModelDelegate;
@property (nonatomic, readonly) NSDictionary *apiParams;

- (void)refreshData;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath;
- (NSString *)headerIdentifierForSection:(NSInteger)section;

- (MVVMViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath;
- (id)modelAtIndexPath:(NSIndexPath *)indexPath;

- (id <MVVMSectionInfo>)sectionInfoForSection:(NSInteger)section;

- (void)removeItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)insertItemObject:(id)obj atIndexPath:(NSIndexPath *)indexPath;
- (void)updateObject:(id)obj atIndex:(int)index;

- (BOOL)isRefreshing;
- (BOOL)noData;
- (NSInteger)typeForIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPathForViewModel:(MVVMViewModel *)viewModel;
- (NSIndexPath *)indexPathForModel:(id )model;
- (BOOL)setError:(NSString *)error forAPIKey:(NSString *)apiKey;
- (BOOL)setError:(NSString *)error forIndexPath:(NSIndexPath *)indexPath;

@end
