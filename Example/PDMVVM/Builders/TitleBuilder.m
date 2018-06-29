//
//  TitleBuilder.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "TitleBuilder.h"

@implementation TitleBuilder

+ (void)addTitleToView:(UIView *)view withBlock:(void (^)(PDTitleLabel *titleLabel))builderBlock {
    PDTitleLabel *titleLabel =  [PDTitleLabel new];
    [view addSubview:titleLabel];
    
    titleLabel.top = [NSLayoutConstraint constraintWithItem:titleLabel attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:titleLabel.superview attribute:NSLayoutAttributeTop multiplier:1 constant:15];
    
    titleLabel.leading = [NSLayoutConstraint constraintWithItem:titleLabel attribute:(NSLayoutAttributeLeading) relatedBy:(NSLayoutRelationEqual) toItem:titleLabel.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:15];
    
   titleLabel.trailing = [NSLayoutConstraint constraintWithItem:titleLabel attribute:(NSLayoutAttributeTrailing) relatedBy:(NSLayoutRelationEqual) toItem:titleLabel.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:-15];
    
    titleLabel.bottom = [NSLayoutConstraint constraintWithItem:titleLabel attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:titleLabel.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:-15];
    
    [NSLayoutConstraint activateConstraints:@[titleLabel.top, titleLabel.leading, titleLabel.bottom, titleLabel.trailing]];
    
    builderBlock(titleLabel);
}

@end
