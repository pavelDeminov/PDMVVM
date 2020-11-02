//
//  SectionsPDMVVMViewModel.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 06/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

protocol PDMVVMSectionsViewModelDelegate {
    func viewModel(_ viewModel: PDMVVMViewModel?, didDeleteModel model: Any?, at indexPath: IndexPath?, completion: @escaping (_ finished: Bool) -> Void)

    func viewModel(_ viewModel: PDMVVMViewModel?, didInsertModel model: Any?, at indexPath: IndexPath?, completion: @escaping (_ finished: Bool) -> Void)

    func viewModel(_ viewModel: PDMVVMViewModel?, didUpdateModel model: Any?, at indexPath: IndexPath?)

    func viewModelsUpdated(atIndexPaths indexPaths: [IndexPath]?)
    
    func sectionReloadSections(_ indexSet: IndexSet?)

    func sectionViewModelDidInsertSections(at indexSet: IndexSet?, completion: @escaping (_ finished: Bool) -> Void)

    func sectionViewModelDidDeleteSections(at indexSet: IndexSet?, completion: @escaping (_ finished: Bool) -> Void)

    func sectionReloadSections(_ indexSet: IndexSet?, completion: @escaping (_ finished: Bool) -> Void)

    func sectionViewModelDidInsertSections(
        at insertedIndexSet: IndexSet?,
        deleteSectionsAt deletedindexSet: IndexSet?,
        reloadSectionsAt reloadedIndexSet: IndexSet?,
        completion: @escaping (_ finished: Bool) -> Void
    )

}

class SectionsPDMVVMViewModel: PDMVVMViewModel {
    
    var sectionsUpdatedDelegate: PDMVVMSectionsViewModelDelegate?
    
    internal func automaticItemSize() -> Bool {
        return true
    }
    
    public func refreshData() {
        setup()
        viewModeldDelegate?.viewModelUpdated(viewModel: self)
    }
    
    internal var sections: [PDMVVMSection] = [] {
        didSet {
            for sectionInfo in sections {
                if let viewModels = sectionInfo.sectionViewModels {
                    for viewModel in viewModels {
                        viewModel.viewModeldDelegate = self
                    }
                }
            }
        }
    }
    
    internal var numberOfSections: Int {
        return sections.count
    }
    
    internal func sectionInfo(forSection section: Int) -> PDMVVMSection? {
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
    
    func indexPath(for viewModel: PDMVVMViewModel?) -> IndexPath? {
        var indexPath: IndexPath?
        
        for sectionInfo in sections {
            if let viewModels = sectionInfo.sectionViewModels {
                for viewModel in viewModels {
                    if let section = sections.firstIndex(where: { (info) -> Bool in
                        return info == sectionInfo
                    }), let row = viewModels.firstIndex(of: viewModel) {
                         indexPath = IndexPath(row: row, section: section)
                    }
                   
                }
            }
        }
        return indexPath
    }
    
}

extension SectionsPDMVVMViewModel: PDMVVMViewModelDelegate {
    func viewModelUpdated(viewModel: PDMVVMViewModel) {
        if let delegate = sectionsUpdatedDelegate, let indexPath = indexPath(for: viewModel) {
            delegate.viewModel(viewModel, didUpdateModel: viewModel.model, at: indexPath)
        }
    }
}
