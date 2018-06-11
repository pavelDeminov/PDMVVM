//
//  PDButton.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDButton.h"

@implementation PDButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

- (void)setup {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.highlightedColor = [UIColor grayColor];
    self.normalColor = [UIColor whiteColor];
    
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    self.layer.cornerRadius = 6 / [UIScreen mainScreen].scale;
    [self setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [self setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];
    [self updateUI];
}

- (void)updateUI {
    self.backgroundColor = self.highlighted ? self.highlightedColor : self.normalColor;
}

@end
