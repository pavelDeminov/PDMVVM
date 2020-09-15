//
//  BaseMVVMViewModel.m
//  Commerce
//
//  Created by Pavel Deminov on 24/08/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import "MVVMViewModel.h"


@interface MVVMViewModel ()

@end

@implementation MVVMViewModel


- (MVVMViewModel *)viewModelWithModel:(id)model withReuseIdentifier:(NSString *)reuseIdentifier type:(NSInteger)type {
    MVVMViewModel *viewModel = [self initWithModel:model type:type];
    viewModel.model = model;
    viewModel.reuseIdentifier = reuseIdentifier;
    return viewModel;
}

+ (MVVMViewModel *)viewModelWithModel:(id)model withReuseIdentifier:(NSString *)reuseIdentifier type:(NSInteger)type {
    MVVMViewModel *viewModel = [[self alloc] initWithModel:model type:type];
    viewModel.model = model;
    viewModel.reuseIdentifier = reuseIdentifier;
    return viewModel;
}

+ (MVVMViewModel *)viewModelWithModel:(id)model type:(NSInteger)type {
    MVVMViewModel *viewModel = [[self alloc] initWithModel:model type:type];
    viewModel.model = model;
    return viewModel;
}

+ (MVVMViewModel *)viewModelWithModel:(id)model withReuseIdentifier:(NSString *)reuseIdentifier {
   return [self viewModelWithModel:model withReuseIdentifier:reuseIdentifier type:0];
}

+ (MVVMViewModel *)viewModelWithModel:(id)model {
    return [self viewModelWithModel:model withReuseIdentifier:nil];
}

+ (NSArray <MVVMViewModel*>*)viewModelArrayFromArrayOfModels:(NSArray*)models withReuseIdentifier:(NSString *)reuseIdentifier {
    NSMutableArray <MVVMViewModel *> *array = [NSMutableArray new];
    for (id model in models) {
        MVVMViewModel *viewModel = [self new];
        viewModel.model = model;
        viewModel.reuseIdentifier = reuseIdentifier;
        [array addObject:viewModel];
    }
    return array;
}

+ (NSArray <MVVMViewModel*>*)viewModelArrayFromArrayOfModels:(NSArray*)models {
    return [self viewModelArrayFromArrayOfModels:models withReuseIdentifier:nil];
}

- (void)setModel:(id)model {
    
    id oldModel = _model;
    _model = model;
    
    if ([model conformsToProtocol:@protocol(MVVMModelInfo) ]) {
        id <MVVMModelInfo> modelInfo = model;
        if ([modelInfo respondsToSelector:@selector(setModelDelegate:)]) {
            modelInfo.modelDelegate = self;
        }
    } else {
        id <MVVMModelInfo> modelInfo = oldModel;
        if ([modelInfo respondsToSelector:@selector(setModelDelegate:)]) {
            if (modelInfo.modelDelegate == self) {
                modelInfo.modelDelegate = nil;
            }
        }
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithModel:(id)model type:(NSInteger)type {
    self = [super init];
    if (self) {
        self.model = model;
        self.type = type;
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithModel:(id)model {
    self = [super init];
    if (self) {
        self.model = model;
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithModel:(id)model params:(NSDictionary *)params {
    self = [super init];
    if (self) {
        self.model = model;
        self.params = params;
        [self setup];
    }
    return self;
}

- (void)setup {

}

#pragma mark ModelDelegate;

- (void)modelUpdated:(id <MVVMModelInfo>)model {
    [self.viewModelDelegate viewModelUpdated:self];
}

@end
