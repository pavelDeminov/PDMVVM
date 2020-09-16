//
//  CollectionMVVMViewController.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 06/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

class SectionsPDMVVMViewController: PDMVVMViewController {
    
    internal var sectionsViewModel: SectionsPDMVVMViewModel? {
        get {
            return super.viewModel as? SectionsPDMVVMViewModel
        }
    }
    internal var reuseIdentifiersDict: [AnyHashable : Any] = [:]
    
    internal func nibExists(name: String) -> Bool {
        let mainBundle = Bundle.main
        let path = mainBundle.path(forResource: name, ofType: "nib")
        return path != nil;
    }
    
    internal func classExists(name: String) -> Bool {

        var cls: AnyClass? = NSClassFromString(name)
        
        if cls == nil {
            //Not objc
            let moduleName = NSStringFromClass(type(of: self)).components(separatedBy: ".").first
            let identifier = "\(moduleName ?? "").\(name)"
            cls = NSClassFromString(identifier)
        }
        
        return cls != nil
    }
    
}


