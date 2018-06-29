//
//  MainViewModel.m
//  PDMVVMExample
//
//  Created by Pavel Deminov on 12/06/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "MainViewModel.h"

@implementation MainViewModel

- (void)setup {
    PDSection *section = [PDSection new];
    NSMutableArray <PDSectionInfo> *sections = [NSMutableArray <PDSectionInfo> new];
    NSMutableArray <PDItemInfo> *items = [NSMutableArray <PDItemInfo> new];
    
    PDItem *first = [PDItem new];
    first.title = @"ViewController";
    first.type = @(MainViewModelItemTypeSimple);
    [items addObject:first];
    
    PDItem *second = [PDItem new];
    second.title = @"ScrollView";
    [items addObject:second];
    
    PDItem *third = [PDItem new];
    third.title = @"TableView";
    [items addObject:third];
    
    PDItem *fourth = [PDItem new];
    fourth.title = @"CollectionView";
    [items addObject:fourth];
    
    
    section.items = items;
    [sections addObject:section];
    self.sections = sections;
}

@end
