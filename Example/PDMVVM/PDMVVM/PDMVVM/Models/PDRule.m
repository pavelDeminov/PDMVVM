//
//  PDRule.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDRule.h"

@implementation PDRule

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
}

- (BOOL)validate:(id)value {
    if (self.validationBlock) {
        return self.validationBlock(value);
    } else {
        return true;
    }
}

@end
