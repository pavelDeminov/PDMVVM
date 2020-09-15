//
//  CollectionMVVMViewController.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 06/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

class SectionsPDMVVMViewController: PDMVVMViewController {
    
    internal var sectionsViewModel: SectionsViewModel? {
        get {
            return super.viewModel as? SectionsViewModel
        }
    }
    internal var reuseIdentifiersDict: [AnyHashable : Any] = [:]
    
    internal func nibExists(name: String) -> Bool {
        let mainBundle = Bundle.main
        let path = mainBundle.path(forResource: name, ofType: "nib")
        return path != nil;
    }
    
}
