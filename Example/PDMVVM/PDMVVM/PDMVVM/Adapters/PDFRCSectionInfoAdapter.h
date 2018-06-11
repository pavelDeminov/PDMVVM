//
//  PDFRCSectionInfoAdapter.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDSectionInfo.h"
@import CoreData;

@interface PDFRCSectionInfoAdapter : NSObject <PDSectionInfo>

@property (nonatomic, strong) id <NSFetchedResultsSectionInfo> frcSectionInfo;

+ (instancetype)adapterWith:(id <NSFetchedResultsSectionInfo>)sectionInfo;
- (instancetype)initWithFRCSectionInfo:(id <NSFetchedResultsSectionInfo>)sectionInfo;

@end
