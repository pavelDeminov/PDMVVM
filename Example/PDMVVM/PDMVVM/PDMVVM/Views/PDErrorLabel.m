//
//  PDErrorLabel.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDErrorLabel.h"

@implementation PDErrorLabel

- (void)setup {
    [super setup];
    self.font = [UIFont systemFontOfSize:12];
    self.textColor = [UIColor redColor];
    self.numberOfLines = 0;
}

@end
