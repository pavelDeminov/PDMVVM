//
//  MainViewModel.h
//  PDMVVMExample
//
//  Created by Pavel Deminov on 12/06/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "PDMVVM.h"

typedef NS_ENUM(NSUInteger, MainViewModelItemType) {
    MainViewModelItemTypeNone,
    MainViewModelItemTypeSimple,
};

@interface MainViewModel : PDSectionsViewModel

@end
