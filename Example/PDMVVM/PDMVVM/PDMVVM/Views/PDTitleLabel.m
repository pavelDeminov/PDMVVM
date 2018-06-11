//
//  PDTitleLabel.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDTitleLabel.h"

@implementation PDTitleLabel

- (void)setup {
    [super setup];
    self.font = [UIFont boldSystemFontOfSize:16];
    self.textColor = [UIColor blackColor];
    self.numberOfLines = 0;
}

@end
