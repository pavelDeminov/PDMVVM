//
//  PDMVVMTableViewController.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 27.02.2021.
//  Copyright © 2021 Pavel Deminov. All rights reserved.
//

import UIKit

class PDMVVMTableViewController: SectionsPDMVVMViewController {

    @IBOutlet open weak var tableView: UITableView?
    
    open override var viewModel: PDMVVMViewModel? {
        didSet {
            tableViewModel?.sectionsUpdatedDelegate = self
            tableViewModel?.viewModeldDelegate = self
        }
    }
    open var tableViewModel: PDMVVMTableViewModel? {
        get {
            return viewModel as? PDMVVMTableViewModel
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.dataSource = self
        tableView?.delegate = self
        
        if  let tableViewModel = tableViewModel {
            tableView?.estimatedRowHeight = tableViewModel.automaticItemSize() ? UITableView.automaticDimension : 0
        }
        
        tableViewModel?.sectionsUpdatedDelegate = self
        tableViewModel?.viewModeldDelegate = self
        
    }
    
    public override func loadView() {
        if fromCode {
            let view = UIView()
            view.backgroundColor = UIColor.white
            let tableView = UITableView(frame: CGRect.zero)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.backgroundColor = UIColor.clear
            view.addSubview(tableView)
            self.tableView = tableView
            self.view = view
            
            let top: NSLayoutConstraint = tableView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0)
            let bottom: NSLayoutConstraint = tableView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: 0)
            let left: NSLayoutConstraint = tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
            let right: NSLayoutConstraint = tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
            NSLayoutConstraint.activate([top,bottom,left,right])
            
        } else {
            super.loadView()
        }
    }
    
    open func prepare(_ cell: PDMVVMTableViewCell?, for indexPath: IndexPath?) {
    }
    
    open func prepare(_ reusableView: PDMVVMTableReusableView?, forSection section: Int) {
    }

}

extension PDMVVMTableViewController: UITableViewDelegate, UITableViewDataSource  {
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsViewModel != nil ? sectionsViewModel!.numberOfSections : 0
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsViewModel != nil ? sectionsViewModel!.numberOfItems(inSection: section) : 0
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viewModel = sectionsViewModel?.viewModel(at: indexPath)
        guard let cellIdentifier = sectionsViewModel?.cellIdentifier(for: indexPath) else {
            return UITableViewCell(frame: CGRect.zero)
        }
        
        
        if reuseIdentifiersDict[cellIdentifier] == nil {
            reuseIdentifiersDict[cellIdentifier] = cellIdentifier
            
            let isTableClass = classFrom(name: cellIdentifier) as? PDMVVMTableViewCell.Type
            if  isTableClass != nil {
                if nibExists(name: cellIdentifier) {
                    tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
                } else {
                    tableView.register(NSClassFromString(cellIdentifier), forCellReuseIdentifier: cellIdentifier)
                }
            } else {
                tableView.register(PDMVVMTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PDMVVMTableViewCell
        
        if let cell = cell, cell.plateView == nil && cell.pdmvvmView == nil, let view = (Bundle.main.loadNibNamed(cellIdentifier, owner: nil, options: nil))?.first as? PDMVVMView {
            cell.pdmvvmView = view
        }
        
        if viewModel != nil {
            cell?.viewModel = viewModel
            cell?.pdmvvmView?.viewModel = viewModel
        }

        prepare(cell, for: indexPath)
        
        return cell!
        
    }
    
    
    /*
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        guard let headerIdentifier = sectionsViewModel?.headerIdentifier(forSection: indexPath.section), let _ = classFrom(name: headerIdentifier) else {
            return UICollectionReusableView(frame: CGRect.zero)
        }

        let sectionInfo = sectionsViewModel?.sectionInfo(forSection: indexPath.section)

        if sectionInfo != nil {
            if reuseIdentifiersDict[headerIdentifier] == nil {
                reuseIdentifiersDict[headerIdentifier] = headerIdentifier
                if nibExists(name: headerIdentifier) {
                    collectionView.register(UINib(nibName: headerIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
                } else {
                    collectionView.register(NSClassFromString(headerIdentifier), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
                    
                }
            }
        }

        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as? PDMVVMCollectionReusableView

        if sectionInfo != nil {
            let sectionInfoMVVM = sectionInfo
            let viewModel: PDMVVMViewModel? = sectionInfoMVVM?.viewModel

            sectionHeaderView?.viewModel = viewModel
        }

        prepare(sectionHeaderView, forSection: indexPath.section)

        return sectionHeaderView!
    }
 */

}

extension PDMVVMTableViewController : PDMVVMSectionsViewModelDelegate {
    
    @objc open override func viewModelUpdated(viewModel: PDMVVMViewModel) {
        super.viewModelUpdated(viewModel: viewModel)
        tableView?.reloadData()
        updateUI()
    }
    
    @objc open func viewModel(_ viewModel: PDMVVMViewModel?, didDeleteModel model: Any?, at indexPath: IndexPath?, completion: @escaping (_ finished: Bool) -> Void) {
        
        if let indexPath = indexPath {
            tableView?.deleteRows(at: [indexPath], with: .automatic)
        }
        updateUI()
    }

    @objc open func viewModel(_ viewModel: PDMVVMViewModel?, didInsertModel model: Any?, at indexPath: IndexPath?, completion: @escaping (_ finished: Bool) -> Void) {
        if let indexPath = indexPath {
            tableView?.insertRows(at: [indexPath], with: .automatic)
        }
        updateUI()
    }

    @objc open func viewModel(_ viewModel: PDMVVMViewModel?, didUpdateModel model: Any?, at indexPath: IndexPath?) {
        
        if let indexPath = indexPath {
            tableView?.reloadRows(at: [indexPath], with: .automatic)
        }
        updateUI()
    }

    @objc open func viewModelsUpdated(atIndexPaths indexPaths: [IndexPath]?) {
        if let indexPaths = indexPaths {
            tableView?.reloadRows(at: indexPaths, with: .automatic)
        }
        updateUI()
    }
    
    @objc open func sectionReloadSections(_ indexSet: IndexSet?) {
        if let indexSet = indexSet {
            tableView?.reloadSections(indexSet, with: .automatic)
        }
        updateUI()
    }

    @objc open func sectionViewModelDidInsertSections(at indexSet: IndexSet?, completion: @escaping (_ finished: Bool) -> Void) {
        
        if let indexSet = indexSet {
            tableView?.insertSections(indexSet, with: .automatic)
        }
        updateUI()
    }

    @objc open func sectionViewModelDidDeleteSections(at indexSet: IndexSet?, completion: @escaping (_ finished: Bool) -> Void) {
        if let indexSet = indexSet {
            tableView?.deleteSections(indexSet, with: .automatic)
        }
        updateUI()
    }

    @objc open func sectionReloadSections(_ indexSet: IndexSet?, completion: @escaping (_ finished: Bool) -> Void) {
        if let indexSet = indexSet {
            tableView?.reloadSections(indexSet, with: .automatic)
        }
        updateUI()
    }

    @objc open func sectionViewModelDidInsertSections(at insertedIndexSet: IndexSet?, deleteSectionsAt deletedindexSet: IndexSet?, reloadSectionsAt reloadedIndexSet: IndexSet?, completion: @escaping (_ finished: Bool) -> Void) {
        
        if let insertedIndexSet = insertedIndexSet,let deletedindexSet = deletedindexSet, let reloadedIndexSet = reloadedIndexSet {
            tableView?.beginUpdates()
            tableView?.insertSections(insertedIndexSet, with: .automatic)
            tableView?.reloadSections(reloadedIndexSet, with: .automatic)
            tableView?.deleteSections(deletedindexSet, with: .automatic)
            tableView?.endUpdates()
        }
        updateUI()
    }

}
