//
//  PDSection.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDItem.h"
#import "PDSectionInfo.h"

@interface PDSection : NSObject <PDSectionInfo>

@property (nullable, nonatomic, strong) id type;
@property (nullable, nonatomic, strong) UIImage *image;
@property (nullable, nonatomic, strong) NSURL *imageUrl;
@property (nullable, nonatomic, strong) NSString *title;
@property (nullable, nonatomic, strong) id value;
@property (nullable, nonatomic, strong) NSArray <PDItemInfo> *items;

@property (nonatomic) ValidationState state;
@property (nullable, nonatomic, strong) PDItem *errorItem;

- (void)setup;
- (void)validate;
- (void)invalidate;
- (nullable NSDictionary *)dictionary;
+ (nonnull PDSection *)instantiate;

@end
