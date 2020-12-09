//
//  ScrollViewPDMVVMViewModel.swift
//  TelcellBusiness
//
//  Created by Pavel Deminov on 16.11.2020.
//  Copyright © 2020 Telcell CJSC. All rights reserved.
//

import UIKit

class ScrollViewPDMVVMViewModel: SectionsPDMVVMViewModel {
    
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
    
}
