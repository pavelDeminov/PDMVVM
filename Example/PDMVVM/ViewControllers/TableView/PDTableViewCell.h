//
//  PDTableViewCell.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDMVVM.h"

@interface PDTableViewCell : UITableViewCell <PDCellInfo>

@property (nonatomic, strong) ReloadCellBlock reloadCellBlock;
@property (nonatomic, strong) id <PDItemInfo> itemInfo;

+ (NSString*)reuseIdentifier;
- (void)updateUI;
- (void)setup;
- (void)setupForIB;

@end
