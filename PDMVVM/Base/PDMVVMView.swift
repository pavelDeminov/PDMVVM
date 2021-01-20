//
//  PDMVVMView.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 15.09.2020.
//  Copyright © 2020 Pavel Deminov. All rights reserved.
//

import UIKit

open class PDMVVMView: UIView {
    
    public static var useViewModelForCalculateMinimalSize = false
    
    static var minimalSafeSizesCollection: [AnyHashable : Any]? = {
        var minimalSafeSizesCollection =  [AnyHashable : Any]()
        return minimalSafeSizesCollection
    }()

    open class func minimalSelfSize() -> CGSize? {
        
        if let size = minimalSafeSizesCollection?[reuseIdentifier] as? CGSize {
            return size
        } else {
            let prototype = (Bundle.main.loadNibNamed(self.reuseIdentifier ?? "", owner: nil, options: nil))?[0] as? PDMVVMView
            prototype?.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue)
            
            prototype?.viewModel = nil;
            prototype?.layoutSubviews()
            let size = prototype?.systemLayoutSizeFitting(layoutFittingCompressedSize)
            minimalSafeSizesCollection?[reuseIdentifier] = size
            return size;
        }
       
    }
    
    open class func minimalSelfSizeWithViewModel(viewModel: PDMVVMViewModel) -> CGSize? {
        
        if let size = minimalSafeSizesCollection?[reuseIdentifier] as? CGSize {
            return size
        } else {
            let prototype = (Bundle.main.loadNibNamed(self.reuseIdentifier ?? "", owner: nil, options: nil))?[0] as? PDMVVMView
            prototype?.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue)
            
            prototype?.viewModel = viewModel;
            prototype?.layoutSubviews()
            let size = prototype?.systemLayoutSizeFitting(layoutFittingCompressedSize)
            minimalSafeSizesCollection?[reuseIdentifier] = size
            return size;
        }
       
    }
    
    open var beginEditingHandler: ((PDMVVMView) -> ())?
    open var endEditingHandler: ((PDMVVMView) -> ())?
    open var valueChangedHandler: ((PDMVVMView) -> ())?
    
    public var viewModel: PDMVVMViewModel? {
        didSet {
            updateUI()
        }
    }
           
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
