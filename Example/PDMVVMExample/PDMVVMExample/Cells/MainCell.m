//
//  MainCell.m
//  PDMVVMExample
//
//  Created by Pavel Deminov on 16/06/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "MainCell.h"

@implementation MainCell

- (void)updateUI {
    self.titleLabel.text = self.itemInfo.pdTitle;
}

@end
