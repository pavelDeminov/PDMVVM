//
//  PDCellInfo.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDItemInfo.h"

typedef void (^ReloadCellBlock)(void);

@protocol PDCellInfo <NSObject>

@property (nonatomic, readwrite) ReloadCellBlock reloadCellBlock;
@property (nonatomic, readwrite) id <PDItemInfo> itemInfo;

@end

