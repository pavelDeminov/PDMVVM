//
//  PDFRCSectionInfoAdapter.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDFRCSectionInfoAdapter.h"

@implementation PDFRCSectionInfoAdapter

+ (instancetype)adapterWith:(id <NSFetchedResultsSectionInfo>)sectionInfo {
    PDFRCSectionInfoAdapter *adapter = [[PDFRCSectionInfoAdapter alloc] initWithFRCSectionInfo:sectionInfo];
    return adapter;
}

- (instancetype)initWithFRCSectionInfo:(id <NSFetchedResultsSectionInfo>)sectionInfo {
    self = [super init];
    if (self) {
        self.frcSectionInfo = sectionInfo;
    }
    return self;
}

@end

/*
class PDFRCSectionInfoAdapter: NSObject, PDSectionInfo {
    var frcSectionInfo: NSFetchedResultsSectionInfo?
    var title: String? {
        get {
            return frcSectionInfo?.name
        }
    }
    var items: [PDItemInfo]? {
        get {
            return frcSectionInfo?.objects as? [PDItemInfo]
        }
    }
    
    init(frcSectionInfo sectionInfo: NSFetchedResultsSectionInfo) {
        super.init()
        self.frcSectionInfo = sectionInfo
        setup()
    }
    
    func setup() {
        
    }
    
}
*/
