//
//  PDSectionsViewModel.h
//  PDStrategy
//
//  Created by Pavel Deminov on 11/06/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "PDViewModel.h"
#import "PDSectionInfo.h"

@protocol PDSectionsViewModelDelegate

- (void)sectionUpdated:(nullable id <PDSectionInfo>)section atIndexPath:(nullable NSIndexPath *)indexPath;
- (void)sectionRemoved:(nullable id <PDSectionInfo>)section atIndexPath:(nullable NSIndexPath *)indexPath;
- (void)sectionInserted:(nullable id <PDSectionInfo>)section atIndexPath:(nullable NSIndexPath *)indexPath;

- (void)itemUpdated:(nullable id <PDItemInfo>)item atIndexPath:(nullable NSIndexPath *)indexPath;
- (void)itemRemoved:(nullable id <PDItemInfo>)item atIndexPath:(nullable NSIndexPath *)indexPath;
- (void)itemInserted:(nullable id <PDItemInfo>)item atIndexPath:(nullable NSIndexPath *)indexPath;

@end

@interface PDSectionsViewModel : PDViewModel

@property (nullable, nonatomic, strong) NSArray <PDSectionInfo> *sections;
@property (nullable, nonatomic, strong) id <PDSectionInfo> errorSectionInfo;
@property (nullable, nonatomic) id <PDSectionsViewModelDelegate> sectionsViewModelDelegate;
@property (nonatomic) ValidationState state;

- (void)validate;
- (void)invalidate;
- (void)appendData:(nullable id)data;
- (BOOL)isEmpty;

- (nullable NSIndexPath *)errorIndexPath;
- (nullable NSIndexPath *)indexPathForItemInfo:(nullable id <PDItemInfo>)itemInfo;

- (nullable NSArray *)sections;
- (nullable id <PDSectionInfo>)sectionInfoForSection:(NSInteger)section;
- (nullable id <PDItemInfo> )itemInfoForIndexPath:(nonnull NSIndexPath *)indexPath;
- (nonnull NSString *)cellIdentifierForIndexPath:(nonnull NSIndexPath *)indexPath;
- (nonnull NSString *)sectionIdentifierForSection:(NSInteger)section;
- (nullable Class)classForRowAtIndexPath:(nullable NSIndexPath *)indexPath;
- (nullable Class)headerFooterClassForSection:(NSInteger)section;

@end
