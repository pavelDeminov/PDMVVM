//
//  PDHeaderFooterInfo.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDSectionInfo.h"

@protocol PDHeaderFooterInfo <NSObject>

@property (nonatomic, readwrite) id <PDSectionInfo> sectionInfo;

@end

