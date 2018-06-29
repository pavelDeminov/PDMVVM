//
//  TitleTextFieldErrorBuilder.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "TitleTextFieldErrorBuilder.h"

@implementation TitleTextFieldErrorBuilder

+ (void)addTitleToView:(UIView *)view withBlock:(void (^)(PDTitleLabel *titleLabel, PDTextField *textField, PDErrorLabel *errorLabel))builderBlock {
    PDTitleLabel *titleLabel =  [PDTitleLabel new];
    [view addSubview:titleLabel];
    
    PDTextField *textField =  [PDTextField new];
    [view addSubview:textField];
    
    PDErrorLabel *errorLabel =  [PDErrorLabel new];
    [view addSubview:errorLabel];
    
    titleLabel.top = [NSLayoutConstraint constraintWithItem:titleLabel attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:titleLabel.superview attribute:(NSLayoutAttributeTop) multiplier:1 constant:15];
    
     titleLabel.leading = [NSLayoutConstraint constraintWithItem:titleLabel attribute:(NSLayoutAttributeLeading) relatedBy:(NSLayoutRelationEqual) toItem:titleLabel.superview attribute:(NSLayoutAttributeLeading) multiplier:1 constant:15];
    
    titleLabel.trailing = [NSLayoutConstraint constraintWithItem:titleLabel attribute:(NSLayoutAttributeTrailing) relatedBy:(NSLayoutRelationEqual) toItem:titleLabel.superview attribute:(NSLayoutAttributeTrailing) multiplier:1 constant:-15];
    
    
    textField.top = [NSLayoutConstraint constraintWithItem:textField attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:titleLabel attribute:(NSLayoutAttributeBottom) multiplier:1 constant:10];
    
    textField.leading = [NSLayoutConstraint constraintWithItem:textField attribute:(NSLayoutAttributeLeading) relatedBy:(NSLayoutRelationEqual) toItem:textField.superview attribute:(NSLayoutAttributeLeading) multiplier:1 constant:15];
    
    textField.trailing = [NSLayoutConstraint constraintWithItem:textField attribute:(NSLayoutAttributeTrailing) relatedBy:(NSLayoutRelationEqual) toItem:textField.superview attribute:(NSLayoutAttributeTrailing) multiplier:1 constant:-15];
    
    
    errorLabel.top = [NSLayoutConstraint constraintWithItem:errorLabel attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:textField attribute:(NSLayoutAttributeBottom) multiplier:1 constant:10];
    
    errorLabel.leading = [NSLayoutConstraint constraintWithItem:errorLabel attribute:(NSLayoutAttributeLeading) relatedBy:(NSLayoutRelationEqual) toItem:errorLabel.superview attribute:(NSLayoutAttributeLeading) multiplier:1 constant:15];
    
    errorLabel.trailing = [NSLayoutConstraint constraintWithItem:errorLabel attribute:(NSLayoutAttributeTrailing) relatedBy:(NSLayoutRelationEqual) toItem:errorLabel.superview attribute:(NSLayoutAttributeTrailing) multiplier:1 constant:-15];
    
    errorLabel.bottom = [NSLayoutConstraint constraintWithItem:errorLabel attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:errorLabel.superview attribute:(NSLayoutAttributeBottom) multiplier:1 constant:-15];
    
    
    [NSLayoutConstraint activateConstraints:@[titleLabel.top, titleLabel.leading, titleLabel.trailing,
                                              textField.top, textField.leading, textField.trailing,
                                              errorLabel.top, errorLabel.leading, errorLabel.bottom, errorLabel.trailing
                                              ]];
    
    builderBlock(titleLabel, textField, errorLabel);
}

@end
