//
//  BaseMVVMViewModel.h
//  Commerce
//
//  Created by Pavel Deminov on 24/08/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVVMModelInfo.h"

@class MVVMViewModel, MVVMModel;

@protocol ViewModelDelegate

- (void)viewModelUpdated:(MVVMViewModel *)viewModel;

@end

@interface MVVMViewModel : NSObject <MVVMModelDelegate>

@property (nonatomic, weak) id <ViewModelDelegate> viewModelDelegate;
@property (nonatomic, strong) id model;
@property (nonatomic, strong) NSString *reuseIdentifier;
@property (nonatomic, strong) NSString *notNib;
@property (nonatomic) NSInteger type;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic) BOOL cacheExists;


+ (MVVMViewModel *)viewModelWithModel:(id)model;
+ (MVVMViewModel *)viewModelWithModel:(id)model type:(NSInteger)type;
+ (MVVMViewModel *)viewModelWithModel:(id)model withReuseIdentifier:(NSString *)reuseIdentifier;
+ (MVVMViewModel *)viewModelWithModel:(id)model withReuseIdentifier:(NSString *)reuseIdentifier type:(NSInteger)type;
- (MVVMViewModel *)viewModelWithModel:(id)model withReuseIdentifier:(NSString *)reuseIdentifier type:(NSInteger)type;

+ (NSArray <MVVMViewModel*>*)viewModelArrayFromArrayOfModels:(NSArray*)models withReuseIdentifier:(NSString *)reuseIdentifier;
+ (NSArray <MVVMViewModel*>*)viewModelArrayFromArrayOfModels:(NSArray*)models;

- (instancetype)initWithModel:(id)model;
- (instancetype)initWithModel:(id)model type:(NSInteger)type;
- (instancetype)initWithModel:(id)model params:(NSDictionary *)params;
- (void)setup;

@end
