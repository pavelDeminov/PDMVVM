//
//  BaseMVVMViewController.m
//  Commerce
//
//  Created by Pavel Deminov on 24/08/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import "MVVMViewController.h"

@interface MVVMViewController ()

@end

@implementation MVVMViewController

+ (nonnull NSString*)segueIdentifier {
    NSString *classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    classString = [classString stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
    NSString *identifier = [NSString stringWithFormat:@"%@Segue",classString];
    return identifier;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.viewModel) {
        [self setupViewModel];
    } else {
        self.viewModel.viewModelDelegate = self;
    }
    
    [self updateUI];
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
}

- (void)refresh {
    
    UIRefreshControl *refreshControl = self.refreshControl;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [refreshControl endRefreshing];
    });
}

- (void)setupViewModel {
    NSString *classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    classString = [classString stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
    NSString *identifier = [NSString stringWithFormat:@"%@ViewModel",classString];
    Class class = NSClassFromString(identifier);
    
    if (!class) {
        //Not objc
        NSString *moduleName = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] firstObject];
        identifier = [NSString stringWithFormat:@"%@.%@",moduleName, identifier];
        class = NSClassFromString(identifier);
    }
    
    MVVMViewModel *viewModel = [class new];
    self.viewModel = viewModel;
    viewModel.viewModelDelegate= self;
}

- (void)updateUI {
    
}

#pragma mark PDViewModelDelegate

- (void)viewModelUpdated:(MVVMViewModel *)viewModel {
    [self updateUI];
}

@end
