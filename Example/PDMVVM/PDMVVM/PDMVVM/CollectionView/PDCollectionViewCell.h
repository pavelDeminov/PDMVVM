//
//  PDCollectionViewCell.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDCellInfo.h"
#import "PDItemInfo.h"

@interface PDCollectionViewCell : UICollectionViewCell <PDCellInfo>

@property (nonatomic, strong) ReloadCellBlock reloadCellBlock;
@property (nonatomic, strong) id <PDItemInfo> itemInfo;

+ (NSString*)reuseIdentifier;
+ (CGSize)fitingSizeForItemInfo:(id <PDItemInfo>)itemInfo withSize:(CGSize)size;

- (void)updateUI;
- (void)setup;

@end
