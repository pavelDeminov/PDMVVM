//
//  ViewModel.h
//  PDMVVMExample
//
//  Created by Pavel Deminov on 16/06/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "PDViewModel.h"

@interface SimpleViewModel : PDViewModel

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *value;
@property (nonatomic, readwrite) NSString *savingValue;

@end
