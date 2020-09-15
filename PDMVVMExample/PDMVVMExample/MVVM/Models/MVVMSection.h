//
//  MVVMSection.h
//  Commerce
//
//  Created by Pavel Deminov on 07/09/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVVMSectionInfo.h"
#import "MVVMModel.h"

@interface MVVMSection : NSObject <MVVMSectionInfo>

@property (nonatomic, strong) NSArray <MVVMViewModel *> *viewModels;
@property (nonatomic, strong) MVVMViewModel *viewModel;
@property (nonatomic, strong) MVVMModel *errorModel;
@property (nonatomic, readonly) NSDictionary *apiParams;

- (void)validate;
- (void)validateBackground:(BOOL)background;
- (void)validateObjectWithApiKey:(NSString *)apiKey background:(BOOL)background;
- (BOOL)preValidateResult;
- (void)invalidate;

@end
