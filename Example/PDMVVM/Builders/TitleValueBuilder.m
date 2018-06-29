//
//  TitleValueBuilder.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "TitleValueBuilder.h"

@implementation TitleValueBuilder

+ (void)addTitleToView:(UIView *)view withBlock:(void (^)(PDTitleLabel *titleLabel, PDValueLabel *valueLabel))builderBlock {
    PDTitleLabel *titleLabel =  [PDTitleLabel new];
    [view addSubview:titleLabel];
    
    PDValueLabel *valueLabel =  [PDValueLabel new];
    [view addSubview:valueLabel];
    
    [titleLabel setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    [titleLabel setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    
    [valueLabel setContentHuggingPriority:(UILayoutPriorityDefaultLow) forAxis:(UILayoutConstraintAxisHorizontal)];
    [valueLabel setContentHuggingPriority:(UILayoutPriorityDefaultLow) forAxis:(UILayoutConstraintAxisVertical)];
    
    titleLabel.top = [NSLayoutConstraint constraintWithItem:titleLabel attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:titleLabel.superview attribute:NSLayoutAttributeTop multiplier:1 constant:15];
    
    titleLabel.leading = [NSLayoutConstraint constraintWithItem:titleLabel attribute:(NSLayoutAttributeLeading) relatedBy:(NSLayoutRelationEqual) toItem:titleLabel.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:15];
    
    titleLabel.bottom = [NSLayoutConstraint constraintWithItem:titleLabel attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationLessThanOrEqual) toItem:titleLabel.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:-15];
    
    
    valueLabel.top = [NSLayoutConstraint constraintWithItem:valueLabel attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:valueLabel.superview attribute:NSLayoutAttributeTop multiplier:1 constant:15];
    
    valueLabel.leading = [NSLayoutConstraint constraintWithItem:valueLabel attribute:(NSLayoutAttributeLeading) relatedBy:(NSLayoutRelationEqual) toItem:titleLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:10];
    
    valueLabel.trailing = [NSLayoutConstraint constraintWithItem:valueLabel attribute:(NSLayoutAttributeTrailing) relatedBy:(NSLayoutRelationEqual) toItem:valueLabel.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:-15];
    
    valueLabel.bottom = [NSLayoutConstraint constraintWithItem:valueLabel attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationLessThanOrEqual) toItem:valueLabel.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:-15];
    
    [NSLayoutConstraint activateConstraints:@[titleLabel.top, titleLabel.leading, titleLabel.bottom,
                                              valueLabel.top, valueLabel.leading, valueLabel.bottom, valueLabel.trailing
                                              ]];
    
    builderBlock(titleLabel, valueLabel);
}

+ (void)addTitle2ToView:(UIView *)view withBlock:(void (^)(PDTitleLabel *titleLabel, PDValueLabel *valueLabel))builderBlock {
    PDTitleLabel *titleLabel =  [PDTitleLabel new];
    [view addSubview:titleLabel];
    
    PDValueLabel *valueLabel =  [PDValueLabel new];
    [view addSubview:valueLabel];
    
    
    titleLabel.top = [NSLayoutConstraint constraintWithItem:titleLabel attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:titleLabel.superview attribute:NSLayoutAttributeTop multiplier:1 constant:15];
    
    titleLabel.leading = [NSLayoutConstraint constraintWithItem:titleLabel attribute:(NSLayoutAttributeLeading) relatedBy:(NSLayoutRelationEqual) toItem:titleLabel.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:15];
    
    titleLabel.trailing = [NSLayoutConstraint constraintWithItem:titleLabel attribute:(NSLayoutAttributeTrailing) relatedBy:(NSLayoutRelationEqual) toItem:titleLabel.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:-15];
    
    
    valueLabel.top = [NSLayoutConstraint constraintWithItem:valueLabel attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:titleLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
    
    valueLabel.leading = [NSLayoutConstraint constraintWithItem:valueLabel attribute:(NSLayoutAttributeLeading) relatedBy:(NSLayoutRelationEqual) toItem:valueLabel.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:15];
    
    valueLabel.trailing = [NSLayoutConstraint constraintWithItem:valueLabel attribute:(NSLayoutAttributeTrailing) relatedBy:(NSLayoutRelationEqual) toItem:valueLabel.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:-15];
    
    valueLabel.bottom = [NSLayoutConstraint constraintWithItem:valueLabel attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationLessThanOrEqual) toItem:valueLabel.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:-15];
    
    [NSLayoutConstraint activateConstraints:@[titleLabel.top, titleLabel.leading, titleLabel.trailing,
                                              valueLabel.top, valueLabel.leading, valueLabel.bottom, valueLabel.trailing,
                                              ]];
    
    builderBlock(titleLabel, valueLabel);
}

@end
