//
//  PDDateLabel.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDLabel.h"

@interface PDDateLabel : PDLabel

@property (nonatomic, strong) NSDateFormatter *dateInFormatter;
@property (nonatomic, strong) NSDateFormatter *dateOutFormatter;
@property (nonatomic, readwrite) NSDate *date;

@end
