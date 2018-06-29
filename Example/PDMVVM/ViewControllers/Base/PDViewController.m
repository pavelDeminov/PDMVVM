//
//  PDBaseViewController.m
//  PDStrategy
//
//  Created by Pavel Deminov on 07/01/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "PDViewController.h"

@interface PDViewController ()

@end

@implementation PDViewController

+ (nonnull NSString*)segueIdentifier {
    NSString *classString = NSStringFromClass(self);
    classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    classString = [classString stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
    NSString *identifier = [NSString stringWithFormat:@"%@Segue",classString];
    return identifier;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewModel];
    [self updateUI];
}

- (void)setupViewModel {
    NSString *classString = NSStringFromClass([self class]);
    classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    classString = [classString stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
    NSString *identifier = [NSString stringWithFormat:@"%@ViewModel",classString];
    Class class = NSClassFromString(identifier);
    
    if (!class) {
        //Not objc
        NSString *moduleName = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] firstObject];
        identifier = [NSString stringWithFormat:@"%@.%@",moduleName, identifier];
        class = NSClassFromString(identifier);
    }
    
    PDViewModel *viewModel = [class new];
    self.viewModel = viewModel;
    viewModel.viewModelDelegate= self;
}

- (void)updateUI {
    
}

#pragma mark PDViewModelDelegate

- (void)viewModelUpdated:(PDViewModel *)viewModel {
    [self updateUI];
}

@end
