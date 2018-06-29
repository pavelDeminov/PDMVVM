//
//  PDBaseViewController.h
//  PDStrategy
//
//  Created by Pavel Deminov on 07/01/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDViewModel.h"

@interface PDViewController : UIViewController <PDViewModelDelegate>

@property (nullable, nonatomic, strong) PDViewModel *viewModel;

+ (nonnull NSString*)segueIdentifier;
- (void)setupViewModel;
- (void)updateUI;


#pragma mark PDViewModelDelegate

- (void)viewModelUpdated:(PDViewModel *)viewModel;

@end
