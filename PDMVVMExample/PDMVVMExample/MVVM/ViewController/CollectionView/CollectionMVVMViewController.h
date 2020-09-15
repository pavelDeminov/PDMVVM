//
//  CollectionMVVMViewController.h
//  Commerce
//
//  Created by Pavel Deminov on 24/08/2018.
//  Copyright © 2018 Minimal Cafe. All rights reserved.
//

#import "MVVMViewController.h"
#import "CollectionMVVMViewModel.h"

@interface CollectionMVVMViewController : MVVMViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SectionViewModelDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, readonly) CollectionMVVMViewModel * collectionViewModel;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *bottomConstraint;

+ (instancetype)create;
- (void)prepareCell:(UICollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;
- (void)prepareReusableView:(UICollectionReusableView *)reusableView forSection:(NSInteger)section;

@end
