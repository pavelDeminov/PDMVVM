//
//  MVVMSectionInfo.h
//  Commerce
//
//  Created by Pavel Deminov on 07/09/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MVVMViewModel;

@protocol MVVMSectionInfo <NSObject>

- (NSArray <MVVMViewModel *> *)viewModels;
- (MVVMViewModel *)viewModel;

@optional
- (void)removeViewModelAtIndex:(NSInteger)index;

@end
