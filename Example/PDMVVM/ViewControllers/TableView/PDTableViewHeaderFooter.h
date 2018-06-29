//
//  PDTableViewHeaderFooter.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDMVVM.h"

@interface PDTableViewHeaderFooter : UITableViewHeaderFooterView <PDHeaderFooterInfo>

@property (nonatomic, strong) id <PDSectionInfo> sectionInfo;

- (void)updateUI;
- (void)setup;

@end
