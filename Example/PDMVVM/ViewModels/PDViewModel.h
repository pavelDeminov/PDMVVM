//
//  PDViewModel.h
//  PDStrategy
//
//  Created by Pavel Deminov on 11/06/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDModel.h"
#import "PDItemInfo.h"

@class PDViewModel;

@protocol PDViewModelDelegate

- (void)viewModelUpdated:(PDViewModel *)viewModel;

@end

@interface PDViewModel : NSObject <PDItemInfoDelegate>

@property (nullable, nonatomic) id <PDViewModelDelegate> viewModelDelegate;
@property (nullable, nonatomic) id <PDItemInfo> modelInfo;
@property (nullable, nonatomic, readonly) NSDictionary *dictionary;

- (void)update;

@end
