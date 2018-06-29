//
//  PDItem.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDItem.h"

@implementation PDItem

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
    [self invalidate];
    ValidationState state = ValidationStateValid;
    
    for (PDRule *rule in self.rules) {
        BOOL valid = [rule validate:self.value];
        if (!valid) {
            self.errorRule = rule;
            state = ValidationStateInvalid;
            break;
        }
    }
    self.state = state;
}

- (void)invalidate {
    self.state = ValidationStateNone;
    self.errorRule = nil;
}

- (UpdateBlock)addUpdateBlock:(UpdateBlock)updateBlock {
    if (!self.updateBlocks) {
        self.updateBlocks = [NSMutableArray new];
    }
    [self.updateBlocks addObject:updateBlock];
    return updateBlock;
}

- (void)removeUpdateBlock:(UpdateBlock)updateBlock {
    [self.updateBlocks removeObject:updateBlock];
}

#pragma mark PDItemInfo

@synthesize pdApiKey;

@synthesize pdDate;

@synthesize pdImage;

@synthesize pdImageUrl;

@synthesize pdItemHash;

@synthesize pdLocked;

@synthesize pdPlaceholder;

@synthesize pdTitle;

@synthesize pdType;

@synthesize pdApiRequred;

@synthesize pdState;

- (NSString *)pdTitle {
    return self.title;
}

- (id)pdValue {
    return self.value;
}

- (void)setPdValue:(id)pdValue {
    self.value = pdValue;
}

- (NSString *)pdItemHash {
    return self.itemHash;
}

- (NSDate *)pdDate {
    return self.date;
}

- (NSString *)pdApiKey {
    return self.apiKey;
}

- (NSString *)pdPlaceholder {
    return self.placeholder;
}

- (id)pdType {
    return self.type;
}

- (UIImage *)pdImage {
    return self.image;
}

- (NSURL *)pdImageUrl {
    return self.imageUrl;
}

- (BOOL)pdLocked {
    return self.locked;
}

- (BOOL)pdApiRequred {
    return self.apiRequred;
}

- (ValidationState)pdState {
    return self.state;
}

@end
