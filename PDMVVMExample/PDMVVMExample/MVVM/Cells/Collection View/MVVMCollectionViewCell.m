//
//  MVVMCollectionViewCell.m
//  Commerce
//
//  Created by Pavel Deminov on 24/08/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import "MVVMCollectionViewCell.h"

@interface MVVMCollectionViewCell ()

@property (nonatomic, strong) NSLayoutConstraint *prototypeWidth;
@property (nonatomic) UIRectCorner corners;
@property (nonatomic, strong) CALayer *shadowLayer;
@property (nonatomic, strong) CALayer *cornersLayer;
@property (nonatomic) BOOL shouldUpdateCorners;

@end

@implementation MVVMCollectionViewCell

+ (NSString*)reuseIdentifier {
    NSString *classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    return classString;
}

+ (CGFloat)sizeForCellWithItem:(id)item withCellWidth:(CGFloat)cellWidth {
    MVVMCollectionViewCell *prototype = [self prototypeWithCellWidth:cellWidth];
    prototype.item = item;
    [prototype layoutSubviews];
    
    CGSize s = [prototype systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return s.height;
}

+ (CGFloat)sizeForCellWithViewModel:(MVVMViewModel *)viewModel withCellWidth:(CGFloat)cellWidth {
    MVVMCollectionViewCell *prototype = [self prototypeWithCellWidth:cellWidth];
    
    prototype.viewModel = viewModel;
    [prototype layoutSubviews];
    CGSize s = [prototype systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return s.height;
}

+ (MVVMCollectionViewCell *)prototypeWithCellWidth:(CGFloat)cellWidth {
    static NSMutableDictionary *prototypes;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        prototypes = [NSMutableDictionary new];
    });
    MVVMCollectionViewCell *prototype = [prototypes valueForKey:self.reuseIdentifier];
    
    if (!prototype) {
        prototype = [[[NSBundle mainBundle] loadNibNamed:self.reuseIdentifier owner:nil options:nil] objectAtIndex:0];
        prototype.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:prototype.contentView attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:cellWidth];
        [NSLayoutConstraint activateConstraints:@[width]];
        prototype.prototypeWidth = width;
        [prototypes setValue:prototype forKey:self.reuseIdentifier];
    }
    CGRect frame = prototype.frame;
    frame.size.width = cellWidth;
    prototype.frame = frame;
    prototype.prototypeWidth.constant = cellWidth;
    
    return prototype;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.separatorHeight.constant = 1.0 / UIScreen.mainScreen.scale;
    self.plateViewColor = self.plateView.backgroundColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateLayers];
}

- (void)layoutIfNeeded {
    [super layoutIfNeeded];
    [self updateLayers];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    [self updateLayers];
}

- (void)setViewModel:(MVVMViewModel *)viewModel {
    _viewModel = viewModel;
    [self updateModelUI];
    [self updateViewModelUI];
    [self updateUI];
}

- (void)setItem:(id)item {
    _item = item;
     [self updateUI];
}

- (void)updateUI {
    
}

- (void)updateModelUI {
    
}

- (void)updateViewModelUI {
    
}

- (void)roundCorners:(UIRectCorner)corners {
    self.corners = corners;
    
    if (self.corners == 0) {
        self.plateView.backgroundColor = self.plateViewColor;
        self.plateView.layer.cornerRadius = self.corners;
        [self.cornersLayer removeFromSuperlayer];
        self.clipsToBounds = YES;
        return;
    }
    
    if (!self.cornersLayer && !self.shadowLayer) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.plateView.bounds byRoundingCorners:self.corners cornerRadii:CGSizeMake(15.0, 15.0)];
        
        CALayer *roundedLayer = [CALayer layer];
        [roundedLayer setFrame:self.plateView.bounds];
        roundedLayer.masksToBounds = NO;
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        [maskLayer setFrame:self.plateView.bounds];
        [maskLayer setPath:maskPath.CGPath];
        
        roundedLayer.mask = maskLayer;
        self.cornersLayer = roundedLayer;
    }
    
    [self.cornersLayer setBackgroundColor:self.plateViewColor.CGColor];
    
    self.clipsToBounds = NO;
    self.plateView.layer.cornerRadius = self.corners;
    self.plateView.backgroundColor = [UIColor clearColor];
    
    [self.plateView.layer insertSublayer:self.cornersLayer atIndex:0];
    
    [self updateLayers];
    
}

- (void)showShadow:(BOOL)showShadow {
    
    if (!showShadow) {
        [self.shadowLayer removeFromSuperlayer];
        return;
    }
    
    if (self.plateViewColor == [UIColor clearColor]) {
        return;
    }
    
    if (!self.shadowLayer) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.plateView.bounds byRoundingCorners:self.corners cornerRadii:CGSizeMake(5.0, 5.0)];
        
        CAShapeLayer *shadowLayer = [CAShapeLayer layer];
        shadowLayer.frame = self.plateView.frame;
        shadowLayer.masksToBounds = NO;
        shadowLayer.shadowPath = maskPath.CGPath;
        
        shadowLayer.shadowOffset = CGSizeMake(0, 2);
        shadowLayer.shadowColor = [UIColor blackColor].CGColor;
        shadowLayer.shadowRadius = 0;
        shadowLayer.shadowOpacity = 0.1f;
    
        self.shadowLayer = shadowLayer;
    }
    
    self.clipsToBounds = NO;
    [self.layer insertSublayer:self.shadowLayer atIndex:0];
    
    [self updateLayers];
}

- (void)updateLayers {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.plateView.bounds byRoundingCorners:self.corners cornerRadii:CGSizeMake(5.0, 5.0)];
    
    CAShapeLayer *maskLayer = (CAShapeLayer *)self.cornersLayer.mask;
    CGRect bounds = self.plateView.bounds;
    [maskLayer setFrame:bounds];
    [maskLayer setPath:maskPath.CGPath];
    self.cornersLayer.frame = bounds;
    
    self.shadowLayer.shadowPath = maskPath.CGPath;
    self.shadowLayer.frame  = bounds;
}

@end
