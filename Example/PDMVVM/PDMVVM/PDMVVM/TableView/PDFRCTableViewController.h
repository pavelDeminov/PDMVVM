//
//  PDFRCTableViewController.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDTableViewController.h"
@import CoreData;

@interface PDFRCTableViewController : PDTableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *frc;

- (void)setupFRC;

@end





