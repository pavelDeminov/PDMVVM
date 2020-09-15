//
//  CellViewModel.h
//  Commerce
//
//  Created by Pavel Deminov on 12/09/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import "MVVMViewModel.h"
@import UIKit;

@interface CellViewModel : MVVMViewModel

//Constraints
@property (nonatomic) NSNumber *verticalGap;
@property (nonatomic) NSNumber *horizonatalGap;
@property (nonatomic) NSNumber *bottomGap;
@property (nonatomic) NSNumber *itemsSpacing;
@property (nonatomic) NSNumber *width;
@property (nonatomic) NSNumber *height;

//Fonts
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *valueFont;
@property (nonatomic, strong) UIFont *errorFont;
@property (nonatomic, strong) UIFont *titleImageFont;

//Aligment
@property (nonatomic, strong) NSNumber *titleTextAlignment;
@property (nonatomic, strong) NSNumber *valueTextAlignment;
@property (nonatomic, strong) NSNumber *errorTextAlignment;

//Spacing
@property (nonatomic) NSNumber *titleSpacing;
@property (nonatomic) NSNumber *valueSpacing;
@property (nonatomic) NSNumber *errorSpacing;

//Colors
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *valueColor;
@property (nonatomic, strong) UIColor *titleImageColor;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UIColor *errorColor;
@property (nonatomic, strong) UIColor *selectionCOlor;
@property (nonatomic, strong) UIColor *plateViewColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *bottomLineColor;
@property (nonatomic, strong) UIColor *arrowColor;

//Other
@property (nonatomic) NSNumber *cornersRadius;
@property (nonatomic) NSNumber *enabled;
@property (nonatomic) NSNumber *refreshing;
@property (nonatomic) NSNumber *valueEditingDisabled;
@property (nonatomic, strong) id dataFormatter;
@property (nonatomic) UIDatePickerMode datePickerMode;

//Text Format
@property (nonatomic, strong) NSString *mask;
@property (nonatomic, strong) NSNumber *keyboardType;
@property (nonatomic, strong) NSCharacterSet *charactersSet;
@property (nonatomic, strong) NSNumber *fractionalPartAllowed;
@property (nonatomic, strong) NSArray *checkers;

@end
