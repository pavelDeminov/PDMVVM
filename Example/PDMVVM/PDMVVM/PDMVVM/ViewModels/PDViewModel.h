//
//  PDViewModel.h
//  PDStrategy
//
//  Created by Pavel Deminov on 11/06/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDItem.h"

@interface PDViewModel : NSObject

@property (nonatomic) ValidationState state;

- (void)setup;
- (nullable NSDictionary *)dictionary;
- (void)validate;
- (void)invalidate;
- (void)appendData:(nullable id)data;
- (nullable NSIndexPath *)errorIndexPath;
- (nullable NSIndexPath *)indexPathForItemInfo:(nullable id <PDItemInfo>)itemInfo;
- (BOOL)isEmpty;

@end
