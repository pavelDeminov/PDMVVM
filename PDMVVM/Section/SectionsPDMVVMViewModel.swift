//
//  SectionsPDMVVMViewModel.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 06/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

public protocol PDMVVMSectionsViewModelDelegate {
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

open class SectionsPDMVVMViewModel: PDMVVMViewModel {
    
    public var sectionsUpdatedDelegate: PDMVVMSectionsViewModelDelegate?
    
    open func automaticItemSize() -> Bool {
        return true
    }
    
    open func refreshData() {
        setup()
        viewModeldDelegate?.viewModelUpdated(viewModel: self)
    }
    
    open var sections: [PDMVVMSection] = [] {
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
    
    open var numberOfSections: Int {
        return sections.count
    }
    
    open func sectionInfo(forSection section: Int) -> PDMVVMSection? {
        return sections[section]
    }
    
    open func numberOfItems(inSection section: Int) -> Int {
        if let sectionInfo = self.sectionInfo(forSection: section), let viewModels = sectionInfo.sectionViewModels {
            return viewModels.count
        } else {
            return 0
        }
    }
    
    open func viewModel(at indexPath: IndexPath?) -> CellPDMVVMViewModel? {
        if let indexPath = indexPath, let sectionInfo = self.sectionInfo(forSection: indexPath.section),
            let viewModels = sectionInfo.sectionViewModels {
            let item = viewModels[indexPath.row]
            return item
        } else {
            return nil
        }
    }
    
    open func cellIdentifier(for indexPath: IndexPath) -> String? {
        if let viewModel = self.viewModel(at: indexPath) {
            return viewModel.reuseIdentifier
        } else {
            var classString = NSStringFromClass(type(of: self)).components(separatedBy: ".").last
            classString = classString?.replacingOccurrences(of: "ViewModel", with: "")
            let identifier = "\(classString ?? "")Cell"
            return identifier
        }
    }
    
    open func headerIdentifier(forSection section: Int) -> String? {
        
        if let sectionInfo = self.sectionInfo(forSection: section),let viewModel = sectionInfo.viewModel {
            return viewModel.reuseIdentifier;
        }
        
        var classString = NSStringFromClass(type(of: self)).components(separatedBy: ".").last
        classString = classString?.replacingOccurrences(of: "ViewModel", with: "")
        let reuseIdentifier = "\(classString ?? "")Header"
        return reuseIdentifier
       
    }
    
    open func model(at indexPath: IndexPath?) -> Any? {
        if let indexPath = indexPath, let sectionInfo = self.sectionInfo(forSection: indexPath.section),
            let viewModels = sectionInfo.sectionViewModels {
            return viewModels[indexPath.row]
        } else {
            return nil
        }
    }
    
    open func indexPath(for viewModel: PDMVVMViewModel?) -> IndexPath? {
        var indexPath: IndexPath?
        
        for  s in 0..<sections.count {
            let section = sections[s]
            if let viewModels = section.sectionViewModels {
                for r in 0..<viewModels.count {
                    let vm = viewModels[r]
                    if viewModel == vm {
                        indexPath = IndexPath(row: r, section: s)
                        break
                    }
                }
            }
            if indexPath != nil {
                break
            }
            
        }
        return indexPath
    }
    
}

extension SectionsPDMVVMViewModel: PDMVVMViewModelDelegate {
    @objc open func viewModelUpdated(viewModel: PDMVVMViewModel) {
        if let delegate = sectionsUpdatedDelegate, let indexPath = indexPath(for: viewModel) {
            delegate.viewModel(viewModel, didUpdateModel: viewModel.model, at: indexPath)
        }
    }
}
