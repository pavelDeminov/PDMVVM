//
//  CollectionViewModel.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 15.09.2020.
//  Copyright © 2020 Pavel Deminov. All rights reserved.
//

import UIKit

open class CollectionPDMVVMViewModel: SectionsPDMVVMViewModel {
    
    open func scrollDirection() -> UICollectionView.ScrollDirection {
        return .vertical
    }
    
    open func numberOfItemsInRow(forSection section: Int) -> Int {
        return 1
    }
    
    open func minimumLineSpacingForSection(at section: Int) -> CGFloat {
        return 0.0
    }
    
    open func minimumInteritemSpacingForSection(at section: Int) -> CGFloat {
        return 0.0
    }
    
    open func insetForSection(at section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //enabled when automaticItemSize = false and shouldHeightEqualWidth=false
    open func sizeForItem(at indexPath: IndexPath?) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
       
    //enabled when automaticItemSize = false, sizeForItem will be ignored
    open func shouldHeightEqualWidth(_ indexPath: IndexPath?) -> Bool {
        return false
    }
    
    //enabled when automaticItemSize = false
    open func sizeForHeader(inSection section: Int) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    // not work with autosizing, don't know why =/
    open func sectionHeadersPinToVisibleBounds() -> Bool {
        return false
    }
    
    // not work with autosizing, don't know why =/
    open func sectionFootersPinToVisibleBounds() -> Bool {
        return false
    }
}
