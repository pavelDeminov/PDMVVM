//
//  PDDateLabel.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDDateLabel.h"

@implementation PDDateLabel

- (void)setup {
    [super setup];
    self.font = [UIFont systemFontOfSize:12];
    self.textColor = [UIColor lightGrayColor];
    self.numberOfLines = 0;
}

- (void)setDate:(NSDate *)date {
    self.text = [self.dateInFormatter stringFromDate:date];
}

- (NSDate *)date {
    return [self.dateOutFormatter dateFromString:self.text];
}

@end
