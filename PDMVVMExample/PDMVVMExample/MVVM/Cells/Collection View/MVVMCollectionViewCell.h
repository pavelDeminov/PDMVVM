//
//  MVVMCollectionViewCell.h
//  Commerce
//
//  Created by Pavel Deminov on 24/08/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MVVMViewModel;

@interface MVVMCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) id item;
@property (nonatomic, strong) MVVMViewModel *viewModel;

@property (nonatomic, weak) IBOutlet UIView *plateView;
@property (nonatomic, weak) IBOutlet UIView *separator;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *separatorHeight;
@property (nonatomic) UIColor *plateViewColor;

+ (NSString*)reuseIdentifier;
+ (CGFloat)sizeForCellWithItem:(id)item withCellWidth:(CGFloat)cellWidth;
+ (CGFloat)sizeForCellWithViewModel:(MVVMViewModel *)viewModel withCellWidth:(CGFloat)cellWidth;

- (void)updateUI;
- (void)updateModelUI;
- (void)updateViewModelUI;

- (void)roundCorners:(UIRectCorner)corners;
- (void)showShadow:(BOOL)showShadow;

@end
