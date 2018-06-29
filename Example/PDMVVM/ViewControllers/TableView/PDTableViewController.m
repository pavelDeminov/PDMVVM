//
//  PDTableViewController.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDTableViewController.h"
#import "PDMVVM.h"

@interface PDTableViewController ()

@end

@implementation PDTableViewController

- (void)setRefreshEnabled:(BOOL)refreshEnabled {
    [super setRefreshEnabled:refreshEnabled];
    
    if (@available(iOS 10.0, *)) {
        if (refreshEnabled) {
            [self.tableView setRefreshControl:self.refreshControl];
        } else {
            [self.tableView setRefreshControl:nil];
        }
    }
    else {
        if (refreshEnabled) {
            [self.tableView addSubview:self.refreshControl];
        } else {
            [self.refreshControl removeFromSuperview];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

}


- (void)prepareCell:(nonnull UITableViewCell *)cell forIndexPath:(nonnull NSIndexPath *)IndexPath {
    //override
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionsViewModel.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <PDSectionInfo> sectionInfo = [self.sectionsViewModel sectionInfoForSection:section];
    return sectionInfo.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id <PDItemInfo> itemInfo = [self.sectionsViewModel itemInfoForIndexPath:indexPath];
    
    NSString *cellIdentifier = [self.sectionsViewModel cellIdentifierForIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        Class cellClass = [self.sectionsViewModel classForRowAtIndexPath:indexPath];
        if (cellClass != nil) {
            [tableView registerClass:cellClass forCellReuseIdentifier:cellIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        }
    }
    
    id <PDCellInfo> cellInfo  = (id <PDCellInfo>)cell;
    if (!cellInfo.reloadCellBlock) {
        cellInfo.reloadCellBlock = ^{
            [tableView beginUpdates];
            [tableView endUpdates];
        };
    }
    
    cellInfo.itemInfo = itemInfo;
    [self prepareCell:cell forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    id <PDSectionInfo> sectionInfo = [self.sectionsViewModel sectionInfoForSection:section];
    
    if (sectionInfo.title == nil) {
        return nil;
    }
    
    NSString *headerIdentifier = [self.sectionsViewModel sectionIdentifierForSection:section];
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    
    if (header == nil) {
        Class headerClass = [self.sectionsViewModel headerFooterClassForSection:section];
        if (headerClass != nil) {
            [tableView registerClass:headerClass forHeaderFooterViewReuseIdentifier:headerIdentifier];
            header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
        }
    }
    
    id <PDHeaderFooterInfo> headerInfo  = (id <PDHeaderFooterInfo>)header;
    
    headerInfo.sectionInfo = sectionInfo;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return 22;
}

@end
