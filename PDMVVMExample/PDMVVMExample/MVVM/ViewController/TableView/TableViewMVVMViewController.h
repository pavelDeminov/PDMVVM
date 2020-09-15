//
//  TableViewMVVMViewController.h
//  Commerce
//
//  Created by Pavel Deminov on 10/09/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import "MVVMViewController.h"
#import "TableViewViewModel.h"

@interface TableViewMVVMViewController : MVVMViewController

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, readonly) TableViewViewModel * tableViewModel;

- (void)prepareCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;
- (void)prepareReusableView:(UITableViewHeaderFooterView *)reusableView forSection:(NSInteger)section;

@end
