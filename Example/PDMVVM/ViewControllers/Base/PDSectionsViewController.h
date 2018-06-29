//
//  PDSectionsViewController.h
//  PDStrategy
//
//  Created by Pavel Deminov on 11/06/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "PDViewController.h"
#import "PDSectionsViewModel.h"

@interface PDSectionsViewController : PDViewController <PDSectionsViewModelDelegate>

@property (nullable, nonatomic, readonly) PDSectionsViewModel *sectionsViewModel;
@property (nonatomic) BOOL refreshEnabled;
@property (nullable, nonatomic, strong) UIRefreshControl *refreshControl;

- (void)refresh;

#pragma mark PDSectionsViewModelDelegate

- (void)sectionUpdated:(nullable id <PDSectionInfo>)section atIndexPath:(nullable NSIndexPath *)indexPath;
- (void)sectionRemoved:(nullable id <PDSectionInfo>)section atIndexPath:(nullable NSIndexPath *)indexPath;
- (void)sectionInserted:(nullable id <PDSectionInfo>)section atIndexPath:(nullable NSIndexPath *)indexPath;

- (void)itemUpdated:(nullable id <PDItemInfo>)item atIndexPath:(nullable NSIndexPath *)indexPath;
- (void)itemRemoved:(nullable id <PDItemInfo>)item atIndexPath:(nullable NSIndexPath *)indexPath;
- (void)itemInserted:(nullable id <PDItemInfo>)item atIndexPath:(nullable NSIndexPath *)indexPath;

@end
