//
//  PDRule.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^ValidationBlock)(id value);

@interface PDRule : NSObject

@property (nonatomic, strong) ValidationBlock validationBlock;
@property (nonatomic, strong) NSString *error;

- (BOOL)validate:(id)value;

@end

