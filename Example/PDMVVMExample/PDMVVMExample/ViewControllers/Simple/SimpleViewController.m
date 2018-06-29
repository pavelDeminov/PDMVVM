//
//  ViewController.m
//  PDMVVMExample
//
//  Created by Pavel Deminov on 16/06/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "SimpleViewController.h"
#import "SimpleModel.h"
#import "SimpleViewModel.h"

@interface SimpleViewController ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *valueLabel;
@property (nonatomic, weak) IBOutlet UITextField *textField;

@end

@implementation SimpleViewController

- (SimpleViewModel *)simpleViewModel {
    return (SimpleViewModel *)self.viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateUI {
    self.titleLabel.text = [self simpleViewModel].title;
    self.valueLabel.text = [self simpleViewModel].value;
}

- (IBAction)save:(id)sender {
    [self simpleViewModel].savingValue = self.textField.text;
    UIAlertController *alert = [UIAlertController con]
    NSLog(@"%@",[self simpleViewModel].dictionary);
}

@end
