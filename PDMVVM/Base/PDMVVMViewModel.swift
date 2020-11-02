//
//  PDMVVMViewModel.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 03/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

protocol PDMVVMViewModelDelegate {
    func viewModelUpdated(viewModel: PDMVVMViewModel)
}

class PDMVVMViewModel: NSObject {

    var model: Any? {
        didSet {
            if let model = model as? PDMVVMModel {
                model.updatedDelegate = self
            }
        }
    }
    var viewModeldDelegate: PDMVVMViewModelDelegate?
    var title: String? {
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
    
    required init(withModel model: Any?) {
        super.init()
        self.model = model
         setup()
    }
    
    internal func setup() {
        
    }
    
}

extension PDMVVMViewModel: PDMVVMModelUpdated {
    func modelUpdated(model: Any) {
        if let viewModeldDelegate = viewModeldDelegate {
            viewModeldDelegate.viewModelUpdated(viewModel: self)
        }
    }
}
