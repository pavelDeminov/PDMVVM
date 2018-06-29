//
//  PDTableViewCell.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDTableViewCell.h"

@implementation PDTableViewCell

+ (NSString*)reuseIdentifier {
    NSString *classString = NSStringFromClass(self);
    classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    return classString;
}

- (void)setItemInfo:(id<PDItemInfo>)itemInfo {
    _itemInfo = itemInfo;
    [self updateUI];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
