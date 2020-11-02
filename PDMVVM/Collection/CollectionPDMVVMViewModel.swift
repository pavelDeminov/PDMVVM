//
//  CollectionViewModel.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 15.09.2020.
//  Copyright © 2020 Pavel Deminov. All rights reserved.
//

import UIKit

class CollectionPDMVVMViewModel: SectionsPDMVVMViewModel {
    
    internal func scrollDirection() -> UICollectionView.ScrollDirection {
        return .vertical
    }
    
    internal func numberOfItemsInRow(forSection section: Int) -> Int {
        return 1
    }
    
    internal func minimumLineSpacingForSection(at section: Int) -> CGFloat {
        return 0.0
    }
    
    internal func minimumInteritemSpacingForSection(at section: Int) -> CGFloat {
        return 0.0
    }
    
    internal func insetForSection(at section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //enabled when automaticItemSize = false and shouldHeightEqualWidth=false
    internal func sizeForItem(at indexPath: IndexPath?) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
       
    //enabled when automaticItemSize = false, sizeForItem will be ignored
    internal func shouldHeightEqualWidth(_ indexPath: IndexPath?) -> Bool {
        return false
    }
    
    //enabled when automaticItemSize = false
    internal func sizeForHeader(inSection section: Int) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    // not work with autosizing, don't know why =/
    internal func sectionHeadersPinToVisibleBounds() -> Bool {
        return false
    }
    
    // not work with autosizing, don't know why =/
    internal func sectionFootersPinToVisibleBounds() -> Bool {
        return false
    }
}
