//
//  PDSectionsViewModel.h
//  PDStrategy
//
//  Created by Pavel Deminov on 11/06/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "PDViewModel.h"
#import "PDSectionInfo.h"
#import "PDItemInfo.h"

@protocol PDSectionsViewModelDelegate

- (void)itemUpdated:(nullable id <PDItemInfo>)item atIndexPath:(nullable NSIndexPath *)indexPath;
- (void)itemRemoved:(nullable id <PDItemInfo>)item atIndexPath:(nullable NSIndexPath *)indexPath;
- (void)itemInserted:(nullable id <PDItemInfo>)item atIndexPath:(nullable NSIndexPath *)indexPath;

@end

@interface PDSectionsViewModel : PDViewModel

@property (nullable, nonatomic, strong) NSArray <PDSectionInfo> *sections;
@property (nullable, nonatomic, strong) id <PDSectionInfo> errorContainer;
@property (nullable, nonatomic) id <PDSectionsViewModelDelegate> delegate;

- (nullable NSArray *)sections;
- (nullable id <PDSectionInfo>)sectionInfoForSection:(NSInteger)section;
- (nullable id <PDItemInfo> )itemInfoForIndexPath:(nonnull NSIndexPath *)indexPath;
- (nonnull NSString *)cellIdentifierForIndexPath:(nonnull NSIndexPath *)indexPath;
- (nonnull NSString *)sectionIdentifierForSection:(NSInteger)section;
- (nullable Class)classForRowAtIndexPath:(nullable NSIndexPath *)indexPath;
- (nullable Class)headerFooterClassForSection:(NSInteger)section;

@end
