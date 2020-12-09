//
//  PDMVVMScrollView.swift
//  TelcellBusiness
//
//  Created by Pavel Deminov on 16.11.2020.
//  Copyright © 2020 Telcell CJSC. All rights reserved.
//

import UIKit

class PDMVVMScrollView: UIView {
    
    var beginEditingHandler: ((PDMVVMScrollView) -> ())?
    var endEditingHandler: ((PDMVVMScrollView) -> ())?
    var valueChangedHandler: ((PDMVVMScrollView) -> ())?
    
     public var viewModel: PDMVVMViewModel? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet public weak var plateView: UIView!
       
    class var reuseIdentifier: String? {
        let classString = NSStringFromClass(self.self).components(separatedBy: ".").last
        return classString
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
       
    open func setup() {
        
    }
       
    open func updateUI() {
           
    }
}
