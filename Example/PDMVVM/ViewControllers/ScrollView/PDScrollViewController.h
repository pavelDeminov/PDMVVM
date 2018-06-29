//
//  PDScrollViewController.h
//  PDStrategy
//
//  Created by Pavel Deminov on 07/01/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "PDSectionsViewController.h"

@class PDScrollViewCell;

@interface PDScrollViewController : PDSectionsViewController <UIScrollViewDelegate>

@property (null_unspecified, nonatomic, weak) IBOutlet UIScrollView *scrollView;

- (void)scrollView:(nonnull UIScrollView *)scrollView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath;
- (void)reloadData;
- (void)prepareCell:(nonnull PDScrollViewCell *)cell forIndexPath:(nonnull NSIndexPath *)IndexPath;
- (nullable PDScrollViewCell *)cellForRowIndexPath:(nonnull NSIndexPath *)indexPath;

@end
