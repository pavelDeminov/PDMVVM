//
//  PDMVVMSection.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 08/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

class PDMVVMSection: NSObject {
    
    var sectionViewModels: [CellPDMVVMViewModel]?
    var viewModel: CellPDMVVMViewModel?
    
}

extension PDMVVMSection: PDMVVMSectionInfo {
    
}
