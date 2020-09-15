//
//  MVVMSection.m
//  Commerce
//
//  Created by Pavel Deminov on 07/09/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import "MVVMSection.h"
#import "MVVMViewModel.h"
#import "MVVMModel.h"

@implementation MVVMSection

- (void)removeViewModelAtIndex:(NSInteger)index {
    NSMutableArray *viewModels = [NSMutableArray arrayWithArray:self.viewModels];
    [viewModels removeObjectAtIndex:index];
    self.viewModels = viewModels;
}

- (void)validate {
    [self validateBackground:NO];
}

- (void)validateBackground:(BOOL)background {
    self.errorModel = nil;
    for (MVVMViewModel *viewModel in self.viewModels) {
        if ([viewModel.model isKindOfClass:[MVVMModel class]]) {
            MVVMModel *model = (MVVMModel *)viewModel.model;
            [model validateBackground:background];
            if (model.errorRule) {
                self.errorModel = model;
                break;
            }
        }
        
    }
}

- (void)validateObjectWithApiKey:(NSString *)apiKey background:(BOOL)background {
    self.errorModel = nil;
    for (MVVMViewModel *viewModel in self.viewModels) {
        if ([viewModel.model isKindOfClass:[MVVMModel class]]) {
            MVVMModel *model = (MVVMModel *)viewModel.model;
            if ([model.apiKey isEqual:apiKey]) {
                [model validateBackground:background];
                if (model.errorRule) {
                    self.errorModel = model;
                    break;
                }
            }
        }
        
    }
}

- (BOOL)preValidateResult {
    BOOL result = YES;
    for (MVVMViewModel *viewModel in self.viewModels) {
        if ([viewModel.model isKindOfClass:[MVVMModel class]]) {
            MVVMModel *model = (MVVMModel *)viewModel.model;
            result = [model preValidateResult];
            if (result == NO) {
                break;
            }
        }
        
    }
    return result;
}

- (void)invalidate {
    self.errorModel = nil;
}

- (NSDictionary *)apiParams {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (MVVMViewModel *viewModel in self.viewModels) {
        if ([viewModel.model conformsToProtocol:@protocol(MVVMModelInfo)]) {
            id <MVVMModelInfo> modelInfo = viewModel.model;
            if (modelInfo.apiKey) {
                id value = modelInfo.mvvmValue;
                dict[modelInfo.apiKey] = value;
            }
        }
       
    }
    return dict;
}

@end
