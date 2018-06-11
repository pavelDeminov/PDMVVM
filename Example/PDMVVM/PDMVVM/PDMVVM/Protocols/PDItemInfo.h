//
//  PDItemInfo.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

@import UIKit;

typedef void (^UpdateBlock)(void);

@protocol PDItemInfo <NSObject>

@property (nullable, nonatomic, readwrite) NSString *pdTitle;
@property (nullable, nonatomic, readwrite) NSString *pdItemHash;
@property (nullable, nonatomic, readwrite) id pdValue;
@property (nullable, nonatomic, readwrite) NSDate *pdDate;
@property (nullable, nonatomic, readwrite) NSString *pdApiKey;
@property (nullable, nonatomic, readwrite) NSString *pdPlaceholder;
@property (nullable, nonatomic, readwrite) id pdType;
@property (nullable, nonatomic, readwrite) UIImage *pdImage;
@property (nullable, nonatomic, readwrite) NSURL *pdImageUrl;
@property (nonatomic, readwrite) BOOL pdLocked;

@optional

@property (nullable, nonatomic, readwrite) NSMutableArray <UpdateBlock> *updateBlocks;
- (nonnull UpdateBlock)addUpdateBlock:(nonnull UpdateBlock)updateBlock;
- (void)removeUpdateBlock:(nonnull UpdateBlock)updateBlock;

@end
