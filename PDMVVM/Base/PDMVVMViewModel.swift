//
//  PDMVVMViewModel.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 03/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

public protocol PDMVVMViewModelDelegate {
    func viewModelUpdated(viewModel: PDMVVMViewModel)
}

open class PDMVVMViewModel: NSObject {

    open var model: Any? {
        didSet {
            if let model = model as? PDMVVMModel {
                model.updatedDelegate = self
            }
        }
    }
    open var viewModeldDelegate: PDMVVMViewModelDelegate?
    open var title: String? {
        get {
            if let modelInfo = model as? PDMVVMModel {
                if (modelInfo.mvvmTitle != nil) {
                    return modelInfo.mvvmTitle
                } else {
                    return "Model with empty title"
                }
            } else {
                return "Model hasn't found"
            }
        }
    }
    
    class func viewModelsArray(fromArrayOfModels models: [Any]?) -> [PDMVVMViewModel]? {
        var array = [PDMVVMViewModel]()
        for model: Any? in models ?? [] {
            let viewModel = self.init(withModel: model)
            viewModel.model = model
            array.append(viewModel)
            
        }
        return array
    }
    
    required public init(withModel model: Any?) {
        super.init()
        self.model = model
        setup()
    }
    
    required public override init() {
        super.init()
        setup()
    }
    
    open func setup() {
        
    }
    
}

extension PDMVVMViewModel: PDMVVMModelUpdated {
    open func modelUpdated(model: Any) {
        if let viewModeldDelegate = viewModeldDelegate {
            viewModeldDelegate.viewModelUpdated(viewModel: self)
        }
    }
}
