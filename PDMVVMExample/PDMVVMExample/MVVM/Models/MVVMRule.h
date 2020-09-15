//
//  MVVMRule.h
//  Commerce
//
//  Created by Pavel Deminov on 24/09/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MVVMValidationState) {
    MVVMValidationStateNone,
    MVVMValidationStateValid,
    MVVMValidationStateInvalid,
};

typedef BOOL (^MVVMValidationBlock)(id value, NSString *error);

@interface MVVMRule : NSObject

@property (nonatomic, copy) MVVMValidationBlock validationBlock;
@property (nonatomic, strong) NSString *error;
@property (nonatomic) MVVMValidationState state;

+ (instancetype)ruleWithError:(NSString *)error validationBlock:(MVVMValidationBlock)validationBlock;
- (void)invalidate;
- (void)validate:(id)value;

@end
