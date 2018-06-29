//
//  PDViewModel.m
//  PDStrategy
//
//  Created by Pavel Deminov on 11/06/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "PDViewModel.h"

@implementation PDViewModel

- (void)setModelInfo:(id<PDItemInfo>)modelInfo {
    if (_modelInfo.pdDelegate == self) {
        _modelInfo.pdDelegate = nil;
    }
    _modelInfo = modelInfo;
    modelInfo.pdDelegate= self;
    
    [self update];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    NSString *classString = NSStringFromClass([self class]);
    classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    classString = [classString stringByReplacingOccurrencesOfString:@"View" withString:@""];
    NSString *identifier = [NSString stringWithFormat:@"%@",classString];
    Class class = NSClassFromString(identifier);
    
    if (!class) {
        //Not objc
        NSString *moduleName = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] firstObject];
        identifier = [NSString stringWithFormat:@"%@.%@",moduleName, identifier];
        class = NSClassFromString(identifier);
    }
    
    PDModel *model = [class fromTextFile:identifier];
    self.modelInfo = model;
}


- (void)dealloc {
    
}

- (void)update {
    
}

- (NSDictionary *)dictionary {
    return nil;
}

#pragma mark PDItemInfoDelegate

- (void)itemInfoDidUpdate:(id <PDItemInfo>)itemInfo {
    [self update];
}

- (void)itemInfoWillUpdate:(id <PDItemInfo>)itemInfo {
    
}

@end
