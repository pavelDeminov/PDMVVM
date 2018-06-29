//
//  PDSectionsViewModel.m
//  PDStrategy
//
//  Created by Pavel Deminov on 11/06/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "PDSectionsViewModel.h"

@implementation PDSectionsViewModel

- (nullable id <PDSectionInfo>)sectionInfoForSection:(NSInteger)section {
    return self.sections[section];
}

- (nullable id <PDItemInfo> )itemInfoForIndexPath:(nonnull NSIndexPath *)indexPath {
    id <PDSectionInfo> sectionInfo = [self sectionInfoForSection:indexPath.section];
    if (indexPath.row < sectionInfo.items.count) {
        id <PDItemInfo> itemInfo = sectionInfo.items[indexPath.row];
        return itemInfo;
    } else {
        return nil;
    }
}

- (nonnull NSString *)cellIdentifierForIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *classString = NSStringFromClass([self class]);
    classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    classString = [classString stringByReplacingOccurrencesOfString:@"ViewModel" withString:@""];
    NSString *identifier = [NSString stringWithFormat:@"%@Cell",classString];
    return identifier;
}

- (nonnull NSString *)sectionIdentifierForSection:(NSInteger)section {
    NSString *classString = NSStringFromClass([self class]);
    classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    classString = [classString stringByReplacingOccurrencesOfString:@"ViewModel" withString:@""];
    NSString *identifier = [NSString stringWithFormat:@"%@Header",classString];
    return identifier;
}

- (nullable Class)classForIdentifier:(NSString *)identifier {
    
    Class cellClass = NSClassFromString(identifier);
    if (!cellClass) {
        //Not objc
        NSString *moduleName = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] firstObject];
        identifier = [NSString stringWithFormat:@"%@.%@",moduleName, identifier];
        cellClass = NSClassFromString(identifier);
    }
    
    return cellClass;
}

- (nullable Class)classForRowAtIndexPath:(nullable NSIndexPath *)indexPath {
    NSString *identifier = [self cellIdentifierForIndexPath:indexPath];
    return [self classForIdentifier:identifier];
}

- (nullable Class)headerFooterClassForSection:(NSInteger)section {
    NSString *identifier = [self sectionIdentifierForSection:section];
    return [self classForIdentifier:identifier];
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
    for (id <PDSectionInfo> sectionInfo in self.sections) {
        [sectionInfo validate];
        state = sectionInfo.state;
        if (state == ValidationStateInvalid) {
            self.errorSectionInfo = sectionInfo;
            break;
        }
    }
    self.state = state;
}

- (void)invalidate {
    self.state = ValidationStateNone;
    self.errorSectionInfo = nil;
}

- (nullable NSIndexPath *)errorIndexPath {
    if (!self.errorSectionInfo) {
        return nil;
    }
    
    NSInteger sectionIndex = [self.sections indexOfObject:self.errorSectionInfo];
    id <PDSectionInfo> sectionInfo = self.errorSectionInfo;
    NSInteger rowindex = [self.errorSectionInfo.items indexOfObject:sectionInfo.errorItemInfo];
    
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

- (NSDictionary *)dictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (id <PDSectionInfo> sectionInfo in self.sections) {
        NSDictionary *containerDict = [sectionInfo dictionary];
        [dict addEntriesFromDictionary:containerDict];
    }
    return dict;
}

@end
