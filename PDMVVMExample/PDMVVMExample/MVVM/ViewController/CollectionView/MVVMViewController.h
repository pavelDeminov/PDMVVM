//
//  BaseMVVMViewController.h
//  Commerce
//
//  Created by Pavel Deminov on 24/08/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVVMViewModel.h"

@interface MVVMViewController : UIViewController <ViewModelDelegate>

@property (nonatomic, strong) MVVMViewModel *viewModel;
@property (nonatomic) BOOL refreshEnabled;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

+ (NSString*)segueIdentifier;
- (void)setupViewModel;
- (void)updateUI;
- (void)refresh;
#pragma mark PDViewModelDelegate

- (void)viewModelUpdated:(MVVMViewModel *)viewModel;

@end




