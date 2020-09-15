//
//  MVVMModel.h
//  Commerce
//
//  Created by Pavel Deminov on 06/09/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVVMModelInfo.h"
#import "MVVMRule.h"
@import UIKit;

@interface MVVMModel : NSObject <MVVMModelInfo>

@property (nonatomic, strong) NSString *mvvmApiKey;
@property (nonatomic, strong) NSString *mvvmTitle;
@property (nonatomic, strong) NSString *mvvmImageName;
@property (nonatomic, strong) NSDate *mvvmDate;
@property (nonatomic, strong) id mvvmValue;
@property (nonatomic, strong) id mvvmObject;
@property (nonatomic, strong) NSString *mvvmPlaceholder;
@property (nonatomic, strong) UIImage *mvvmImage;
@property (nonatomic, strong) NSURL *mvvmImageUrl;
@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, readonly) NSString *mvvmError;
@property (nonatomic, strong) NSString *mvvmAPIError;
@property (nonatomic, weak) id <MVVMModelDelegate> modelDelegate;
@property (nonatomic) NSInteger type;

@property (nonatomic, strong) NSString *mask;
@property (nonatomic, strong) NSArray *checkers;
@property (nonatomic, strong) MVVMRule *errorRule;
@property (nonatomic, strong) NSArray <MVVMRule *> *rules;

+ (MVVMModel *)modelWithTitle:(NSString*)title;
+ (MVVMModel *)modelWithTitle:(NSString*)title image:(UIImage *)image;
+ (MVVMModel *)modelWithTitle:(NSString*)title value:(id )value;
+ (MVVMModel *)modelWithTitle:(NSString*)title value:(id )value error:(NSString *)error;
+ (MVVMModel *)modelWithTitle:(NSString*)title value:(id)value placeholder:(NSString *)placeholder error:(NSString *)error;
+ (MVVMModel *)modelWithTitle:(NSString*)title value:(id )value imageName:(NSString *)imageName;

- (void)validate;
- (void)validateBackground:(BOOL)background;
- (BOOL)preValidateResult;
- (void)invalidate;

@end
