//
//  MVVMCollectionReusableView.h
//  Commerce
//
//  Created by Pavel Deminov on 07/09/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MVVMViewModel;

@interface MVVMCollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) MVVMViewModel *viewModel;
@property (nonatomic, strong) id item;
@property (nonatomic, weak) IBOutlet UIView *plateView;

+ (NSString*)reuseIdentifier;
+ (CGFloat)sizeForViewWithViewModel:(MVVMViewModel *)viewModel withViewWidth:(CGFloat)cellWidth;

- (void)updateUI;
- (void)updateViewModelUI;
- (void)addShadow;

@end
