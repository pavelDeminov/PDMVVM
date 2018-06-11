//
//  PDDataSource.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDDataSource.h"
#import "PDSection.h"

@implementation PDDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)dealloc {
    
}

- (void)setup {
    
}

- (void)appendData:(nullable id)data {
    
}

- (BOOL)isEmpty {
    BOOL isEmpty = YES;
    for (id <PDSectionInfo> sectionInfo in self.sections) {
        if (sectionInfo.items.count) {
            isEmpty = NO;
            break;
        }
    }
    return isEmpty;
}

- (void)validate {
    ValidationState state = ValidationStateNone;
    for (PDSection *section in self.sections) {
        [section validate];
        state = section.state;
        if (state == ValidationStateInvalid) {
            self.errorContainer = section;
            break;
        }
    }
    self.state = state;
}

- (void)invalidate {
    self.state = ValidationStateNone;
    self.errorContainer = nil;
}

- (NSDictionary *)dictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (PDSection *container in self.sections) {
        NSDictionary *containerDict = [container dictionary];
        [dict addEntriesFromDictionary:containerDict];
    }
    return dict;
}

- (nullable NSIndexPath *)errorIndexPath {
    if (!self.errorContainer) {
        return nil;
    }
    
    NSInteger sectionIndex = [self.sections indexOfObject:self.errorContainer];
    PDSection *section = self.errorContainer;
    NSInteger rowindex = [self.errorContainer.items indexOfObject:section.errorItem];
    
    return [NSIndexPath indexPathForRow:rowindex inSection:sectionIndex];
}

- (nullable NSIndexPath *)indexPathForItemInfo:(id <PDItemInfo>)itemInfo {
    
    for (id <PDSectionInfo> sectionInfo in self.sections) {
        for (id <PDItemInfo> item in sectionInfo.items) {
            if (itemInfo == item) {
                NSInteger section = [self.sections indexOfObject:sectionInfo];
                NSInteger row = [sectionInfo.items indexOfObject:item];
                return [NSIndexPath indexPathForRow:row inSection:section];
            }
        }
    }
    
    return nil;
}

- (nullable id <PDItemInfo>)itemAtIndexPath:(nullable NSIndexPath *)indexPath {
    
    for (id <PDSectionInfo> sectionInfo in self.sections) {
        for (id <PDItemInfo> item in sectionInfo.items) {
            NSInteger s = [self.sections indexOfObject:sectionInfo];
            NSInteger r = [sectionInfo.items indexOfObject:item];
            NSIndexPath *ip = [NSIndexPath indexPathForRow:r inSection:s];
            if ([indexPath isEqual:ip]) {
                return item;
            }
        }
    }
    
    return nil;
}

- (nullable id <PDItemInfo>)updateItemAtIndexPath:(nullable NSIndexPath *)indexPath {
    id <PDItemInfo> item = [self itemAtIndexPath:indexPath];
    for (UpdateBlock block in item.updateBlocks) {
        block();
    }
    [self.delegate itemUpdated:item atIndexPath:indexPath];
    return item;
}

- (nullable id <PDItemInfo>)removeItemAtIndexPath:(nullable NSIndexPath *)indexPath {
    id <PDItemInfo> item = [self itemAtIndexPath:indexPath];
    
    id <PDSectionInfo> sectionInfoWithItem;
    for (id <PDSectionInfo> sectionInfo in self.sections) {
        if ([sectionInfo.items containsObject:item]) {
            sectionInfoWithItem = sectionInfo;
            break;
        }
    }
    
    if (sectionInfoWithItem) {
        NSMutableArray <PDItemInfo> *items = [NSMutableArray <PDItemInfo> arrayWithArray:sectionInfoWithItem.items];
        [items removeObject:item];
        sectionInfoWithItem.items = items;
    }
    [self.delegate itemRemoved:item atIndexPath:indexPath];
    return item;
}

- (nullable id <PDItemInfo>)insertItem:(nullable id <PDItemInfo>)itemInfo atIndexPath:(nullable NSIndexPath *)indexPath {
    
    id <PDSectionInfo> sectionInfoWithItem;
    for (id <PDSectionInfo> sectionInfo in self.sections) {
        NSInteger s = [self.sections indexOfObject:sectionInfo];
        if (s == indexPath.section) {
            sectionInfoWithItem = sectionInfo;
            break;
        }
    }
    
    if (sectionInfoWithItem) {
        NSMutableArray <PDItemInfo> *items = [NSMutableArray <PDItemInfo> arrayWithArray:sectionInfoWithItem.items];
        [items insertObject:itemInfo atIndex:indexPath.row];
        sectionInfoWithItem.items = items;
    }
    [self.delegate itemInserted:itemInfo atIndexPath:indexPath];
    return itemInfo;
}

- (nullable id <PDItemInfo>)moveItemAtIndexPath:(nullable NSIndexPath *)indexPath toIndexPath:(nonnull NSIndexPath *)newIndexPath {
    id <PDItemInfo> item = [self itemAtIndexPath:indexPath];
    
    [self insertItem:item atIndexPath:newIndexPath];
    [self removeItemAtIndexPath:indexPath];
    
    return item;
}

@end
