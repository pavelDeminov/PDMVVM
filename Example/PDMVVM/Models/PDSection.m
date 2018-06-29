//
//  PDSection.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDSection.h"

@implementation PDSection

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
    for (id <PDItemInfo> itemInfo in self.items) {
        [itemInfo validate];
        state = itemInfo.pdState;
        if (state == ValidationStateInvalid) {
            self.errorItem = itemInfo;
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
    for (id <PDItemInfo> itemInfo in self.items) {
        if (itemInfo.pdApiKey) {
            id value = itemInfo.pdValue;
            dict[itemInfo.pdApiKey] = value;
            
        } else if (itemInfo.pdApiRequred){
            NSLog(@"Requred apiKey not found %@ in %@",itemInfo.pdApiKey, itemInfo.pdTitle);
        }
    }
    return dict;
}
@end
