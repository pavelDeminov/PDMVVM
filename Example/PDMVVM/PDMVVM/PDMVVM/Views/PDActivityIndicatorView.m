//
//  PDActivityIndicatorView.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDActivityIndicatorView.h"

@implementation PDActivityIndicatorView

- (instancetype)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style {
    self = [super initWithActivityIndicatorStyle:style];
    [self setup];
    return self;
}

- (void)setup {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.hidesWhenStopped = YES;
}

@end
