//
//  ScrollViewModel.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 27.02.2021.
//  Copyright © 2021 Pavel Deminov. All rights reserved.
//

import UIKit

class ScrollViewModel: ScrollViewPDMVVMViewModel {

    override func setup() {
        
        var sections = [PDMVVMSection]()
        
        let section = PDMVVMSection()
        
        var viewModels = [CellPDMVVMViewModel]()
        
        var model = PDMVVMModel(withTitle:"one")
        var viewModel = CellPDMVVMViewModel(withModel: model, withReuseidentifier: "ViewCell")
        viewModels.append(viewModel)
        
        model = PDMVVMModel(withTitle:"One one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one ")
        viewModel = CellPDMVVMViewModel(withModel: model, withReuseidentifier: "ViewCell")
        viewModels.append(viewModel)
        
        sections.append(section)
        section.sectionViewModels = viewModels
        
        self.sections = sections
    }
    
    override func numberOfItemsInRow(forSection section: Int) -> Int {
        return 1
    }
    
    override func minimumLineSpacingForSection(at section: Int) -> CGFloat {
        return 10.0
    }
    
    override func minimumInteritemSpacingForSection(at section: Int) -> CGFloat {
        return 10.0
    }
    
    override func insetForSection(at section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    override func automaticItemSize() -> Bool {
           return true
    }
    
}
