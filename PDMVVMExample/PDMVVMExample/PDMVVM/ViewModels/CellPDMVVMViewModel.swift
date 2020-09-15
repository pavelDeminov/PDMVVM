//
//  CellPDMVVMViewModel.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 06/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

class CellPDMVVMViewModel: PDMVVMViewModel {
    var reuseIdentifier: String!
    
    init(withModel model: Any?, withReuseidentifier reuseIdentifier: String) {
        super.init(withModel: model)
        self.reuseIdentifier = reuseIdentifier
    }
    
    required init(withModel model: Any?) {
        fatalError("init(withModel:) has not been implemented")
    }
}
