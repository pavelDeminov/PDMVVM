//
//  ViewModel.m
//  PDMVVMExample
//
//  Created by Pavel Deminov on 16/06/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "SimpleViewModel.h"
#import "SimpleModel.h"

@implementation SimpleViewModel

#pragma mark PDItemInfo

- (NSString *)title {
    return self.modelInfo.pdTitle;
}

- (NSString *)value {
    return self.modelInfo.pdValue;
}

- (NSString *)pdApiKey {
    return self.modelInfo.pdValue;
}

#pragma mark SimpleModel

- (SimpleModel *)simpleModel {
    return (SimpleModel *)self.modelInfo;
}

- (NSString *)savingValue {
    return [self simpleModel].savingValue;
}

- (void)setSavingValue:(NSString *)savingValue {
    [self simpleModel].savingValue = savingValue;
}

- (NSDictionary *)dictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    if (self.savingValue) {
        dict[@"apiKey"] = self.savingValue;
    }
    return dict;
}

@end
