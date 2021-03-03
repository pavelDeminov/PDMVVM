//
//  TableViewModel.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 27.02.2021.
//  Copyright © 2021 Pavel Deminov. All rights reserved.
//

import UIKit

class TableViewModel: PDMVVMTableViewModel {

    override func setup() {
        
        var sections = [PDMVVMSection]()
        
        var section = PDMVVMSection()
        //section.viewModel = CellPDMVVMViewModel(withModel:PDMVVMModel(withTitle:"Table cells" ), withReuseidentifier: "CollectionReusableView")
        
        var viewModels = [CellPDMVVMViewModel]()
        
        var model = PDMVVMModel(withTitle:"one")
        var viewModel = CellPDMVVMViewModel(withModel: model, withReuseidentifier: "ViewCell")
        viewModels.append(viewModel)
        
        model = PDMVVMModel(withTitle:"One one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one ")
        viewModel = CellPDMVVMViewModel(withModel: model, withReuseidentifier: "ViewCell")
        viewModels.append(viewModel)
        
        sections.append(section)
        section.sectionViewModels = viewModels
        
        
        section = PDMVVMSection()
        section.viewModel = CellPDMVVMViewModel(withModel:PDMVVMModel(withTitle:"View cells" ), withReuseidentifier: "CollectionReusableView")
        
        viewModels = [CellPDMVVMViewModel]()
        
        model = PDMVVMModel(withTitle:"two two two ")
        viewModel = CellPDMVVMViewModel(withModel: model, withReuseidentifier: "ViewCell")
        viewModels.append(viewModel)
        
        model = PDMVVMModel(withTitle:"two two two two two two two two two two two two two two two")
        viewModel = CellPDMVVMViewModel(withModel: model, withReuseidentifier: "ViewCell")
        viewModels.append(viewModel)
        
        sections.append(section)
        section.sectionViewModels = viewModels
        
        
        self.sections = sections
    }
}
