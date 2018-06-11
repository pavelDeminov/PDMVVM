//
//  PDDataSource.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDItem.h"
#import "PDSectionInfo.h"

@protocol PDDataSourceDelegate

- (void)itemUpdated:(nullable id <PDItemInfo>)item atIndexPath:(nullable NSIndexPath *)indexPath;
- (void)itemRemoved:(nullable id <PDItemInfo>)item atIndexPath:(nullable NSIndexPath *)indexPath;
- (void)itemInserted:(nullable id <PDItemInfo>)item atIndexPath:(nullable NSIndexPath *)indexPath;

@end

@interface PDDataSource : NSObject

@property (nullable, nonatomic, strong) NSArray <PDSectionInfo> *sections;
@property (nullable, nonatomic, strong) id <PDSectionInfo> errorContainer;
@property (nonatomic) ValidationState state;
@property (nullable, nonatomic) id <PDDataSourceDelegate> delegate;


- (void)setup;
- (nullable NSDictionary *)dictionary;
- (void)validate;
- (void)invalidate;
- (void)appendData:(nullable id)data;
- (nullable NSIndexPath *)errorIndexPath;
- (nullable NSIndexPath *)indexPathForItemInfo:(nullable id <PDItemInfo>)itemInfo;
- (BOOL)isEmpty;

- (nullable id <PDItemInfo>)updateItemAtIndexPath:(nullable NSIndexPath *)indexPath;
- (nullable id <PDItemInfo>)removeItemAtIndexPath:(nullable NSIndexPath *)indexPath;
- (nullable id <PDItemInfo>)insertItem:(nullable id <PDItemInfo>)itemInfo atIndexPath:(nullable NSIndexPath *)indexPath;
- (nullable id <PDItemInfo>)moveItemAtIndexPath:(nullable NSIndexPath *)indexPath toIndexPath:(nonnull NSIndexPath *)newIndexPath;

@end
