//
//  ViewController.m
//  PDMVVMExample
//
//  Created by Pavel Deminov on 11/06/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewModel.h"
#import "SimpleViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollView:(UIScrollView *)scrollView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id <PDItemInfo> itemInfo = [self.sectionsViewModel itemInfoForIndexPath:indexPath];
    NSNumber *type = itemInfo.pdType;
    MainViewModelItemType itemType = type.integerValue;
    
    switch (itemType) {
        case MainViewModelItemTypeSimple:
            [self performSegueWithIdentifier:SimpleViewController.segueIdentifier sender:self];
            break;
            
        default:
            break;
    }
}


@end
