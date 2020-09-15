//
//  MVVMRule.m
//  Commerce
//
//  Created by Pavel Deminov on 24/09/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import "MVVMRule.h"

@implementation MVVMRule

+ (instancetype)ruleWithError:(NSString *)error validationBlock:(MVVMValidationBlock)validationBlock {
    MVVMRule *rule = [MVVMRule new];
    rule.validationBlock = validationBlock;
    rule.error = error;
    return rule;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
}

- (void)validate:(id)value {
    if (self.validationBlock) {
        self.state = self.validationBlock(value,self.error) ? MVVMValidationStateValid : MVVMValidationStateInvalid;
    }
}

- (void)invalidate {
    self.state = MVVMValidationStateNone;
}

@end
