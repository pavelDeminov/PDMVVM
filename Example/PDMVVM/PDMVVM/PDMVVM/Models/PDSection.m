//
//  PDSection.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDSection.h"

@implementation PDSection

+ (nonnull PDSection *)instantiate {
    PDSection *section = [PDSection new];
    return section;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
}

- (void)validate {
    ValidationState state = ValidationStateNone;
    for (PDItem *item in self.items) {
        [item validate];
        state = item.state;
        if (state == ValidationStateInvalid) {
            self.errorItem = item;
            break;
        }
    }
    self.state = state;
}

- (void)invalidate {
    self.state = ValidationStateNone;
    self.errorItem = nil;
}

- (NSDictionary *)dictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (PDItem *item in self.items) {
        if (item.apiKey) {
            id value = item.value;
            dict[item.apiKey] = value;
            
        } else if (item.apiRequred){
            NSLog(@"Requred apiKey not found %@ in %@",item.apiKey, item.title);
        }
    }
    return dict;
}
@end
