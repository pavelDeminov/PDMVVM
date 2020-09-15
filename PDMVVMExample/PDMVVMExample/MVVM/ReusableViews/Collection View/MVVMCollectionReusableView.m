//
//  MVVMCollectionReusableView.m
//  Commerce
//
//  Created by Pavel Deminov on 07/09/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import "MVVMCollectionReusableView.h"

@interface MVVMCollectionReusableView ()

@property (nonatomic, strong) NSLayoutConstraint *prototypeWidth;

@end

@implementation MVVMCollectionReusableView

+ (NSString*)reuseIdentifier {
    NSString *classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    return classString;
}

+ (CGFloat)sizeForViewWithViewModel:(MVVMViewModel *)viewModel withViewWidth:(CGFloat)cellWidth {
    MVVMCollectionReusableView *prototype = [self prototypeWithViewWidth:cellWidth];
    
    prototype.viewModel = viewModel;
    
    CGSize s = [prototype systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return s.height;
}

+ (MVVMCollectionReusableView *)prototypeWithViewWidth:(CGFloat)cellWidth {
    static NSMutableDictionary *prototypes;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        prototypes = [NSMutableDictionary new];
    });
    MVVMCollectionReusableView *prototype = [prototypes valueForKey:self.reuseIdentifier];
    
    if (!prototype) {
        prototype = [[[NSBundle mainBundle] loadNibNamed:self.reuseIdentifier owner:nil options:nil] objectAtIndex:0];
        
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:prototype attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:cellWidth];
        [NSLayoutConstraint activateConstraints:@[width]];
        prototype.prototypeWidth = width;
        [prototypes setValue:prototype forKey:self.reuseIdentifier];
    }
    
    prototype.prototypeWidth.constant = cellWidth;
    
    return prototype;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setItem:(id)item {
    _item = item;
    [self updateUI];
}

- (void)setViewModel:(MVVMViewModel *)viewModel {
    _viewModel = viewModel;
    [self updateViewModelUI];
    [self updateUI];
}

- (void)updateUI {
    
}

- (void)updateViewModelUI {
    
}

- (void)addShadow {
    self.plateView.layer.shadowOffset = CGSizeMake(0, 2);
    self.plateView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.plateView.layer.shadowRadius = 2;
    self.plateView.layer.shadowOpacity = 0.2f;
    self.plateView.layer.masksToBounds = NO;
}

@end
