//
//  PDScrollViewCell.h
//  PDStrategy
//
//  Created by Pavel Deminov on 07/01/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDCellInfo.h"

@interface PDScrollViewCell : UIView  <PDCellInfo>

@property (nonatomic, strong) id <PDItemInfo> itemInfo;
@property (nonatomic, strong) ReloadCellBlock reloadCellBlock;

+ (NSString*)reuseIdentifier;

- (void)updateUI;
- (void)setup;

@end
