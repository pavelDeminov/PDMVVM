//
//  TitleValueBuilder.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDTitleLabel.h"
#import "PDValueLabel.h"

@interface TitleValueBuilder : NSObject

+ (void)addTitleToView:(UIView *)view withBlock:(void (^)(PDTitleLabel *titleLabel, PDValueLabel *valueLabel))builderBlock;
+ (void)addTitle2ToView:(UIView *)view withBlock:(void (^)(PDTitleLabel *titleLabel, PDValueLabel *valueLabel))builderBlock;

@end
