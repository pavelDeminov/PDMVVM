//
//  PDMVVMViewController.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 06/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

class PDMVVMViewController: UIViewController {
    
    var viewModel: PDMVVMViewModel?
    var fromCode = false
    private(set) var titleLabel: UILabel?

    
    class func create() -> Self {
        let vc = self.init()
        vc.fromCode = true
        return vc
    }
    
    override func loadView() {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewModel == nil {
            setupViewModel()
        }
        
        updateUI()
        
    }
    
    func setupViewModel() {
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
    
    internal func setup() {
        
    }
    
    internal func updateUI() {
        self.titleLabel?.text = self.viewModel?.title
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PDMVVMViewController : PDMVVMViewModelDelegate {
    
    @objc func viewModelUpdated(viewModel: PDMVVMViewModel) {
         updateUI()
    }
}
