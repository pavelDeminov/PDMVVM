//
//  TitleTextFieldErrorBuilder.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDTitleLabel.h"
#import "PDTextField.h"
#import "PDErrorLabel.h"

@interface TitleTextFieldErrorBuilder : NSObject

+ (void)addTitleToView:(UIView *)view withBlock:(void (^)(PDTitleLabel *titleLabel, PDTextField *textField, PDErrorLabel *errorLabel))builderBlock;

@end
