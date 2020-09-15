//
//  MVVMModelInfo.h
//  Commerce
//
//  Created by Pavel Deminov on 12/09/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@protocol MVVMModelInfo;

@protocol MVVMModelDelegate

- (void)modelUpdated:(id <MVVMModelInfo>)model;

@end

@class MVVMRule;

@protocol MVVMModelInfo <NSObject>

@optional

@property (nonatomic, readwrite) NSString *mvvmApiKey;
@property (nonatomic, readwrite) NSString *mvvmTitle;
@property (nonatomic, readwrite) NSString *mvvmImageName;
@property (nonatomic, readwrite) NSString *mvvmPlaceholder;
@property (nonatomic, readwrite) NSDate *mvvmDate;
@property (nonatomic, readwrite) id mvvmValue;
@property (nonatomic, readwrite) id mvvmObject;
@property (nonatomic, readwrite) UIImage *mvvmImage;
@property (nonatomic, readwrite) NSURL *mvvmImageUrl;
@property (nonatomic, readonly) NSString *mvvmError;
@property (nonatomic, readwrite) NSString *apiKey;
@property (nonatomic, weak) id <MVVMModelDelegate> modelDelegate;

@property (nonatomic, readwrite) NSString *mvvmAPIError;
@property (nonatomic, readwrite) MVVMRule *errorRule;
@property (nonatomic, readwrite) NSArray <MVVMRule *> *rules;

- (void)validate;
- (void)invalidate;
@end
