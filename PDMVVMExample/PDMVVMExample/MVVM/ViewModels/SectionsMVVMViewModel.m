//
//  SectionsMVVMViewModel.m
//  Commerce
//
//  Created by Pavel Deminov on 06/09/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import "SectionsMVVMViewModel.h"
#import "MVVMSection.h"

@implementation SectionsMVVMViewModel
@dynamic viewModelDelegate;

- (void)setSections:(NSArray<MVVMSectionInfo> *)sections{
    _sections = sections;
    for (id <MVVMSectionInfo> sectionInfo in sections) {
        if ([sectionInfo conformsToProtocol:@protocol(MVVMSectionInfo)]) {
            for (MVVMViewModel *viewModel in sectionInfo.viewModels) {
                viewModel.viewModelDelegate = self;
            }
        }
    }
}

- (void)refreshData {
    [self setup];
    [self.viewModelDelegate viewModelUpdated:self];
}

- (NSInteger)numberOfSections {
    return self.sections.count;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    id sectionInfo = [self sectionInfoForSection:section];
    if ([sectionInfo conformsToProtocol:@protocol(MVVMSectionInfo) ]) {
        id <MVVMSectionInfo> sectionInfoMVVM = [self.sections objectAtIndex:section];
        return sectionInfoMVVM.viewModels.count;
    }  else {
        return 0;
    }
}

- (NSString *)cellIdentifierForIndexPath:(nonnull NSIndexPath *)indexPath {
    MVVMViewModel *viewModel = [self viewModelAtIndexPath:indexPath];
    if (viewModel.reuseIdentifier) {
        return viewModel.reuseIdentifier;
    } else {
        NSString *classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
        classString = [classString stringByReplacingOccurrencesOfString:@"ViewModel" withString:@""];
        NSString *identifier = [NSString stringWithFormat:@"%@Cell",classString];
        return identifier;
    }
}

- (NSString *)headerIdentifierForSection:(NSInteger)section {
    id <MVVMSectionInfo> sectionInfo = [self sectionInfoForSection:section];
    NSString *reuseIdentifier;
    if ([sectionInfo respondsToSelector:@selector(viewModel)]) {
        MVVMViewModel *viewModel = sectionInfo.viewModel;
        if (viewModel.reuseIdentifier) {
            reuseIdentifier = viewModel.reuseIdentifier;
        }
    }
    
    if (!reuseIdentifier) {
        NSString *classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
        classString = [classString stringByReplacingOccurrencesOfString:@"ViewModel" withString:@""];
        reuseIdentifier = [NSString stringWithFormat:@"%@Header",classString];
    }
    return reuseIdentifier;
}

- (MVVMViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath {
    id sectionInfo = [self sectionInfoForSection:indexPath.section];
    if ([sectionInfo conformsToProtocol:@protocol(MVVMSectionInfo) ]) {
        id <MVVMSectionInfo> sectionInfoMVVM = sectionInfo;
        id item = [sectionInfoMVVM.viewModels objectAtIndex:indexPath.row];
        return item;
    } else {
        return nil;
    }
}

- (id)modelAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath) {
        return nil;
    }
    MVVMViewModel *viewModel = [self viewModelAtIndexPath:indexPath];
    return viewModel.model;
}

- (id <MVVMSectionInfo>)sectionInfoForSection:(NSInteger)section {
    id <MVVMSectionInfo> sectionInfo = [self.sections objectAtIndex:section];
    return sectionInfo;
}

- (void)removeItemAtIndexPath:(NSIndexPath *)indexPath {
    id <MVVMSectionInfo> sectionInfo = [self sectionInfoForSection:indexPath.section];
     id model = [self modelAtIndexPath:indexPath];
    
    if ([sectionInfo respondsToSelector:@selector(removeViewModelAtIndex:)]) {
        [sectionInfo removeViewModelAtIndex:indexPath.row];
        id delegate = self.viewModelDelegate;
        if ([delegate respondsToSelector:@selector(viewModel:didDeleteModel:atIndexPath:)]) {
            [delegate viewModel:self didDeleteModel:model atIndexPath:indexPath];
        }
    } else {
        NSAssert(false, @"sectionInfo does not responds to removeObjectAtIndex:");
    }
}

- (void)insertItemObject:(id)obj atIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)updateObject:(id)obj atIndex:(int)index {
    
}

- (BOOL)isRefreshing {
    return NO;
}

- (BOOL)noData {
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id sectionInfo, NSDictionary<NSString *,id> * _Nullable bindings) {
        
        if ([sectionInfo conformsToProtocol:@protocol(MVVMSectionInfo) ]) {
            id <MVVMSectionInfo> sectionInfoMVVM = sectionInfo;
            return sectionInfoMVVM.viewModels.count > 0;
        } else{
            return false;
        }
        
        
    }];
    
    NSArray *filtered = [self.sections filteredArrayUsingPredicate:predicate];
    return filtered.count == 0;
}

- (NSInteger)typeForIndexPath:(NSIndexPath *)indexPath {
    MVVMViewModel *viewModel = [self viewModelAtIndexPath:indexPath];
    return viewModel.type;
}

- (NSIndexPath *)indexPathForViewModel:(MVVMViewModel *)viewModel {
    __block NSIndexPath *indexPath;
    [self.sections enumerateObjectsUsingBlock:^(MVVMSection *section, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([section.viewModels containsObject:viewModel]) {
            NSInteger row = [section.viewModels indexOfObject:viewModel];
            indexPath = [NSIndexPath indexPathForRow:row inSection:idx];
        }
    }];
    return indexPath;
}

- (NSIndexPath *)indexPathForModel:(id )model {
    
    __block NSIndexPath *indexPath;
    [self.sections enumerateObjectsUsingBlock:^(MVVMSection *section, NSUInteger ids, BOOL * _Nonnull stop) {
        [section.viewModels enumerateObjectsUsingBlock:^(MVVMViewModel * _Nonnull obj, NSUInteger idr, BOOL * _Nonnull stop) {
            if (obj.model == model) {
                indexPath = [NSIndexPath indexPathForRow:idr inSection:ids];
            }
        }];
    }];
    return indexPath;
}

- (void)viewModelUpdated:(MVVMViewModel *)viewModel {
    NSIndexPath *indexPath = [self indexPathForViewModel:viewModel];
    [self.viewModelDelegate viewModel:viewModel didUpdateModel:viewModel.model atIndexPath:indexPath];
}

- (BOOL)setError:(NSString *)error forAPIKey:(NSString *)apiKey {
    NSIndexPath *indexPath = [self indexPathModelForAPIKey:apiKey];
    return [self setError:error forIndexPath:indexPath];
}

- (BOOL)setError:(NSString *)error forIndexPath:(NSIndexPath *)indexPath {
    id model = [self modelAtIndexPath:indexPath];
    BOOL success = NO;
    if ([model conformsToProtocol:@protocol(MVVMModelInfo)]) {
        id <MVVMModelInfo> modelInfo = model;
        modelInfo.mvvmAPIError = error;
        [modelInfo validate];
        success = YES;
    }
    return success;
}

- (NSIndexPath *)indexPathModelForAPIKey:(NSString *)apiKey {
    __block NSIndexPath *indexPath;
    [self.sections enumerateObjectsUsingBlock:^(MVVMSection *section, NSUInteger ids, BOOL * _Nonnull stop) {
        [section.viewModels enumerateObjectsUsingBlock:^(MVVMViewModel * _Nonnull obj, NSUInteger idr, BOOL * _Nonnull stop) {
            if ([obj.model conformsToProtocol:@protocol(MVVMModelInfo)]) {
                id <MVVMModelInfo> modelInfo = obj.model;
                if ([modelInfo.apiKey isEqualToString:apiKey]) {
                    indexPath = [NSIndexPath indexPathForRow:idr inSection:ids];
                    *stop = YES;
                }
            }
        }];
        if (indexPath) {
            *stop = YES;
        }
    }];
    return indexPath;
}

- (NSDictionary *)apiParams {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [self.sections enumerateObjectsUsingBlock:^(MVVMSection *section, NSUInteger ids, BOOL * _Nonnull stop) {
        [dict addEntriesFromDictionary:section.apiParams];
    }];
    
    return dict;
}

@end
