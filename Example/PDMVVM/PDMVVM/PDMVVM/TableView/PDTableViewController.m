//
//  PDTableViewController.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDTableViewController.h"
#import "PDCellInfo.h"
#import "PDHeaderFooterInfo.h"

@interface PDTableViewController ()

@end

@implementation PDTableViewController

- (void)setRefreshEnabled:(BOOL)refreshEnabled {
    _refreshEnabled = refreshEnabled;
    
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

    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self setupController];
}

- (void)refresh {
    
    UIRefreshControl *refreshControl = self.refreshControl;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [refreshControl endRefreshing];
    });
}

- (void)loadNextPage {
    
}

- (void)prepareCell:(nonnull UITableViewCell *)cell forIndexPath:(nonnull NSIndexPath *)IndexPath {
    //override
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <PDSectionInfo> sectionInfo = [self sectionInfoForSection:section];
    return sectionInfo.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id <PDItemInfo> itemInfo = [self itemInfoForIndexPath:indexPath];
    
    NSString *cellIdentifier = [self cellIdentifierForIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        Class cellClass = [self classForRowAtIndexPath:indexPath];
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
    id <PDSectionInfo> sectionInfo = [self sectionInfoForSection:section];
    
    if (sectionInfo.title == nil) {
        return nil;
    }
    
    NSString *headerIdentifier = [self sectionIdentifierForSection:section];
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    
    if (header == nil) {
        Class headerClass = [self headerFooterClassForSection:section];
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
