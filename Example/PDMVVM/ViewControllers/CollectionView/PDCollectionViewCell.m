//
//  PDCollectionViewCell.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDCollectionViewCell.h"

@interface PDCollectionViewCell ()

@end

@implementation PDCollectionViewCell

+ (NSString*)reuseIdentifier {
    NSString *classString = NSStringFromClass(self);
    classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    return classString;
}

+ (PDCollectionViewCell *)prototype
{
    PDCollectionViewCell *prototype = [[self alloc] init];
    return prototype;
}

+ (CGSize)fitingSizeForItemInfo:(id <PDItemInfo>)itemInfo withSize:(CGSize)dynamicSize {
    PDCollectionViewCell *prototype = [self prototype];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:prototype.contentView attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:dynamicSize.width];
    [NSLayoutConstraint activateConstraints:@[width]];
    
    prototype.itemInfo = itemInfo;
    CGSize s = [prototype systemLayoutSizeFittingSize:dynamicSize];
    
    return s;
}

- (void)setItemInfo:(id<PDItemInfo>)itemInfo {
    _itemInfo = itemInfo;
    [self updateUI];
}

- (instancetype)init {
    self = [super init];
    [self setup];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
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
