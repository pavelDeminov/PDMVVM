//
//  PDMVVMViewController.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 06/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

open class PDMVVMViewController: UIViewController {
    
    open var viewModel: PDMVVMViewModel?
    public var fromCode = false
    private(set) var titleLabel: UILabel?

    open class func create() -> Self {
        let vc = self.init()
        vc.fromCode = true
        return vc
    }
    
    public override func loadView() {
        if fromCode {
            let view = UIView()
            view.backgroundColor = UIColor.white
            let label = UILabel(frame: CGRect.zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            self.titleLabel = label
            self.view = view
            
            let x: NSLayoutConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0)
            let y: NSLayoutConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0)
            NSLayoutConstraint.activate([x,y])
            
        } else {
            super.loadView()
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewModel == nil {
            setupViewModel()
        }
        
        updateUI()
        
    }
    
    open func setupViewModel() {
        var classString = NSStringFromClass(type(of: self)).components(separatedBy: ".").last
        classString = classString?.replacingOccurrences(of: "ViewController", with: "")
        var identifier = "\(classString ?? "")ViewModel"
        var viewModelClass: AnyClass? = NSClassFromString(identifier)
        
        if viewModelClass == nil {
            //Not objc
            let moduleName = NSStringFromClass(type(of: self)).components(separatedBy: ".").first
            identifier = "\(moduleName ?? "").\(identifier)"
            viewModelClass = NSClassFromString(identifier)
        }
        
        if let cls = viewModelClass as? PDMVVMViewModel.Type {
            viewModel = cls.init(withModel: nil)
            viewModel?.viewModeldDelegate = self
        }
        
    }
    
    open func setup() {
        
    }
    
    open func updateUI() {
        self.titleLabel?.text = self.viewModel?.title
    }

}

extension PDMVVMViewController : PDMVVMViewModelDelegate {
    
    @objc open func viewModelUpdated(viewModel: PDMVVMViewModel) {
         updateUI()
    }
}
