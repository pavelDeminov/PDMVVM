//
//  PDSectionsViewController.m
//  PDStrategy
//
//  Created by Pavel Deminov on 11/06/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "PDSectionsViewController.h"

@interface PDSectionsViewController ()

@end

@implementation PDSectionsViewController

- (PDSectionsViewModel *)sectionsViewModel {
    return (PDSectionsViewModel *)self.viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
}

- (void)refresh {
    
    UIRefreshControl *refreshControl = self.refreshControl;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [refreshControl endRefreshing];
    });
}

- (void)dealloc {
    
}

#pragma mark PDSectionsViewModelDelegate

- (void)sectionUpdated:(nullable id <PDSectionInfo>)section atIndexPath:(nullable NSIndexPath *)indexPath {
    
}

- (void)sectionRemoved:(nullable id <PDSectionInfo>)section atIndexPath:(nullable NSIndexPath *)indexPath {
    
}

- (void)sectionInserted:(nullable id <PDSectionInfo>)section atIndexPath:(nullable NSIndexPath *)indexPath {
    
}


- (void)itemUpdated:(nullable id <PDItemInfo>)item atIndexPath:(nullable NSIndexPath *)indexPath {
    
}

- (void)itemRemoved:(nullable id <PDItemInfo>)item atIndexPath:(nullable NSIndexPath *)indexPath {
    
}

- (void)itemInserted:(nullable id <PDItemInfo>)item atIndexPath:(nullable NSIndexPath *)indexPath {
    
}

@end
