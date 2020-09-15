//
//  SectionsPDMVVMViewModel.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 06/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

class SectionsViewModel: PDMVVMViewModel {
    
    internal var sections: [PDMVVMSectionInfo] = []
    
    internal var numberOfSections: Int {
        return sections.count
    }
    
    internal func sectionInfo(forSection section: Int) -> PDMVVMSectionInfo? {
        return sections[section]
    }
    
    internal func numberOfItems(inSection section: Int) -> Int {
        if let sectionInfo = self.sectionInfo(forSection: section), let viewModels = sectionInfo.sectionViewModels {
            return viewModels.count
        } else {
            return 0
        }
    }
    
    internal func viewModel(at indexPath: IndexPath?) -> CellPDMVVMViewModel? {
        if let indexPath = indexPath, let sectionInfo = self.sectionInfo(forSection: indexPath.section),
            let viewModels = sectionInfo.sectionViewModels {
            let item = viewModels[indexPath.row]
            return item
        } else {
            return nil
        }
    }
    
    internal func cellIdentifier(for indexPath: IndexPath) -> String? {
        if let viewModel = self.viewModel(at: indexPath) {
            return viewModel.reuseIdentifier
        } else {
            var classString = NSStringFromClass(type(of: self)).components(separatedBy: ".").last
            classString = classString?.replacingOccurrences(of: "ViewModel", with: "")
            let identifier = "\(classString ?? "")Cell"
            return identifier
        }
    }
    
    internal func headerIdentifier(forSection section: Int) -> String? {
        
        if let sectionInfo = self.sectionInfo(forSection: section),let viewModel = sectionInfo.viewModel {
            return viewModel.reuseIdentifier;
        }
        
        var classString = NSStringFromClass(type(of: self)).components(separatedBy: ".").last
        classString = classString?.replacingOccurrences(of: "ViewModel", with: "")
        let reuseIdentifier = "\(classString ?? "")Header"
        return reuseIdentifier
       
    }
    
    internal func model(at indexPath: IndexPath?) -> Any? {
        if let indexPath = indexPath, let sectionInfo = self.sectionInfo(forSection: indexPath.section),
            let viewModels = sectionInfo.sectionViewModels {
            return viewModels[indexPath.row]
        } else {
            return nil
        }
    }
    
    internal func automaticItemSize() -> Bool {
        return true
    }
    
}
