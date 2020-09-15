//
//  MVVMModel.m
//  Commerce
//
//  Created by Pavel Deminov on 06/09/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import "MVVMModel.h"

@implementation MVVMModel

- (NSString *)mvvmError {
    NSString *error = self.errorRule.error ? self.errorRule.error : self.mvvmAPIError;
    return error;
}

+ (MVVMModel *)modelWithTitle:(NSString*)title{
    MVVMModel *model = [self new];
    model.mvvmTitle = title;
    return model;
}

+ (MVVMModel *)modelWithTitle:(NSString*)title image:(UIImage *)image {
    MVVMModel *model = [self new];
    model.mvvmTitle = title;
    model.mvvmImage = image;
    return model;
}

+ (MVVMModel *)modelWithTitle:(NSString*)title value:(id )value {
    MVVMModel *model = [self new];
    model.mvvmTitle = title;
    model.mvvmValue = value;
    
    return model;
}

+ (MVVMModel *)modelWithTitle:(NSString*)title value:(id )value error:(NSString *)error {
    MVVMModel *model = [self new];
    model.mvvmTitle = title;
    model.mvvmValue = value;
    model.mvvmAPIError = error;
    
    return model;
}

+ (MVVMModel *)modelWithTitle:(NSString*)title value:(id)value placeholder:(NSString *)placeholder error:(NSString *)error {
    MVVMModel *model = [self new];
    model.mvvmTitle = title;
    model.mvvmValue = value;
    model.mvvmPlaceholder = placeholder;
    model.mvvmAPIError = error;

    return model;
}

+ (MVVMModel *)modelWithTitle:(NSString*)title value:(id )value imageName:(NSString *)imageName {
    MVVMModel *model = [self new];
    model.mvvmTitle = title;
    model.mvvmValue = value;
    model.mvvmImageName = imageName;
    
    return model;
}

- (void)validate {
    [self validateBackground:NO];
    
}

- (void)validateBackground:(BOOL)background {
    self.errorRule = nil;
    
    for (MVVMRule *rule in self.rules) {
        [rule validate:self.mvvmValue];
        if (rule.state == MVVMValidationStateInvalid) {
            self.errorRule = rule;
            break;
        }
    }
    if (!background) {
        [self.modelDelegate modelUpdated:self];
    }
    
}

- (BOOL)preValidateResult {
    BOOL result = YES;
    for (MVVMRule *rule in self.rules) {
        [rule validate:self.mvvmValue];
        if (rule.state == MVVMValidationStateInvalid) {
            result = NO;
            break;
        }
    }
    return result;
}

- (void)invalidate {
    self.errorRule = nil;
    self.mvvmAPIError = nil;
    [self.modelDelegate modelUpdated:self];

}


@end
