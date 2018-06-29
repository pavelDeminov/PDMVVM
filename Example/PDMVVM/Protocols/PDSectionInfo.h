//
//  PDSectionInfo.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

@import UIKit;
#import "PDItemInfo.h"

@protocol PDSectionInfo <NSObject>

@optional
@property (nonatomic, readwrite) id type;
@property (nonatomic, readwrite) UIImage *image;
@property (nonatomic, readwrite) NSURL *imageUrl;
@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, strong) id value;
@property (nonatomic, readwrite) NSArray <PDItemInfo> *items;
@property (nonatomic, readwrite) id <PDItemInfo> errorItemInfo;
@property (nonatomic) ValidationState state;

- (void)validate;
- (void)invalidate;
- (nullable NSDictionary *)dictionary;

@end
