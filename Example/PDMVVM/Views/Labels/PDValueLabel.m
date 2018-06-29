//
//  PDValueLabel.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDValueLabel.h"

@implementation PDValueLabel

- (void)setup {
    [super setup];
    self.font = [UIFont systemFontOfSize:14];
    self.textColor = [UIColor darkGrayColor];
    self.numberOfLines = 0;
}

@end
