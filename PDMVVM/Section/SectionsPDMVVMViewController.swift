//
//  CollectionMVVMViewController.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 06/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

open class SectionsPDMVVMViewController: PDMVVMViewController {
    
    open var sectionsViewModel: SectionsPDMVVMViewModel? {
        get {
            return super.viewModel as? SectionsPDMVVMViewModel
        }
    }
    internal var reuseIdentifiersDict: [AnyHashable : Any] = [:]
    
    open func nibExists(name: String) -> Bool {
        let mainBundle = Bundle.main
        let path = mainBundle.path(forResource: name, ofType: "nib")
        return path != nil;
    }
    
    open func classFrom(name: String) -> AnyClass? {

        var cls: AnyClass? = NSClassFromString(name)
        
        if cls == nil {
            //Not objc
            let moduleName = NSStringFromClass(type(of: self)).components(separatedBy: ".").first
            let identifier = "\(moduleName ?? "").\(name)"
            cls = NSClassFromString(identifier)
        }
        
        return cls
    }
    
}


