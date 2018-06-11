//
//  PDTableViewHeaderFooter.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDTableViewHeaderFooter.h"

@implementation PDTableViewHeaderFooter

- (void)setSectionInfo:(id<PDSectionInfo>)sectionInfo {
    _sectionInfo = sectionInfo;
    [self updateUI];
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    [self setup];
    return self;
}

- (void)updateUI {
    //override
}

- (void)setup {
    //override
}

- (void)setupForIB {
    //override
}

- (void)prepareForInterfaceBuilder {
    [self setup];
    [self setupForIB];
}

@end
