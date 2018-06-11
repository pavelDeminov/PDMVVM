//
//  PDTableViewController.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDDataSource.h"
#import "PDSectionsViewController.h"

@interface PDTableViewController : PDSectionsViewController <UITableViewDelegate, UITableViewDataSource>

@property (null_unspecified, nonatomic, weak) IBOutlet UITableView *tableView;
@property (nullable, nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic) BOOL refreshEnabled;

- (void)prepareCell:(nonnull UITableViewCell *)cell forIndexPath:(nonnull NSIndexPath *)IndexPath;

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
- (CGFloat)tableView:(nonnull UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(nonnull UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section;

- (void)refresh;

@end
