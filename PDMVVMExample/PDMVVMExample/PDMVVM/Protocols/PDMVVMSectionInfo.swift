//
//  PDMVVMSectionInfo.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 06/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import Foundation

protocol PDMVVMSectionInfo {
    var sectionViewModels: [CellPDMVVMViewModel]? { get set }
    var viewModel: CellPDMVVMViewModel? { get set }

}

