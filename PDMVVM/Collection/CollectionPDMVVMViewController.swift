//
//  CollectionMVVMViewController.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 06/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

open class CollectionPDMVVMViewController: SectionsPDMVVMViewController {
    
    @IBOutlet open weak var collectionView: UICollectionView!
    
    open override var viewModel: PDMVVMViewModel? {
        didSet {
            collectionViewModel?.sectionsUpdatedDelegate = self
            collectionViewModel?.viewModeldDelegate = self
        }
    }
    open var collectionViewModel: CollectionPDMVVMViewModel? {
        get {
            return viewModel as? CollectionPDMVVMViewModel
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        let layout = PDMVVMCollectionViewFlowLayout()
        layout.viewModel = self.collectionViewModel
        
        if  let collectionViewModel = collectionViewModel {
            if #available(iOS 10.0, *) {
                layout.estimatedItemSize = collectionViewModel.automaticItemSize() ? UICollectionViewFlowLayout.automaticSize : CGSize.zero
            }
            layout.scrollDirection = collectionViewModel.scrollDirection()
            layout.sectionFootersPinToVisibleBounds = collectionViewModel.sectionFootersPinToVisibleBounds()
            layout.sectionHeadersPinToVisibleBounds = collectionViewModel.sectionHeadersPinToVisibleBounds()
        }
        collectionView.collectionViewLayout = layout
        
        collectionViewModel?.sectionsUpdatedDelegate = self
        collectionViewModel?.viewModeldDelegate = self
        
    }
    
    public override func loadView() {
        if fromCode {
            let view = UIView()
            view.backgroundColor = UIColor.white
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.backgroundColor = UIColor.clear
            view.addSubview(collectionView)
            self.collectionView = collectionView
            self.view = view
            
            let top: NSLayoutConstraint = collectionView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0)
            let bottom: NSLayoutConstraint = collectionView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: 0)
            let left: NSLayoutConstraint = collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
            let right: NSLayoutConstraint = collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
            NSLayoutConstraint.activate([top,bottom,left,right])
            
        } else {
            super.loadView()
        }
    }
    
    open func prepare(_ cell: PDMVVMCollectionViewCell?, for indexPath: IndexPath?) {
    }
    
    open func prepare(_ reusableView: PDMVVMCollectionReusableView?, forSection section: Int) {
    }

}

extension CollectionPDMVVMViewController: UICollectionViewDataSource, UICollectionViewDelegate  {
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionsViewModel != nil ? sectionsViewModel!.numberOfSections : 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionsViewModel != nil ? sectionsViewModel!.numberOfItems(inSection: section) : 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = sectionsViewModel?.viewModel(at: indexPath)
        guard let cellIdentifier = sectionsViewModel?.cellIdentifier(for: indexPath) else {
            return UICollectionViewCell(frame: CGRect.zero)
        }
        
        
        if reuseIdentifiersDict[cellIdentifier] == nil {
            reuseIdentifiersDict[cellIdentifier] = cellIdentifier
            
            
            if nibExists(name: cellIdentifier) {
                collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
            } else {
                collectionView.register(NSClassFromString(cellIdentifier), forCellWithReuseIdentifier: cellIdentifier)
            }
            
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PDMVVMCollectionViewCell
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            cell?.scrollDirection = layout.scrollDirection
        }
        
        if viewModel != nil {
            cell?.viewModel = viewModel
        }

        prepare(cell, for: indexPath)
        
        return cell!
    }
    
    
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        guard let headerIdentifier = sectionsViewModel?.headerIdentifier(forSection: indexPath.section), classExists(name: headerIdentifier) else {
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

}

extension CollectionPDMVVMViewController: UICollectionViewDelegateFlowLayout {
   
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var size = CGSize(width: 50, height: 50)
        guard let collectionViewModel = collectionViewModel,
            let cellIdentifier = collectionViewModel.cellIdentifier(for: indexPath) else {
            return size
        }
        
        if let mvvmLayout = collectionViewLayout as? PDMVVMCollectionViewFlowLayout {
            
            size = collectionViewModel.sizeForItem(at: indexPath)
            let rect = CGRect(origin: CGPoint.zero, size: size)
            size = mvvmLayout.rectForItem(at: indexPath, original: rect).size
            
            if (collectionViewModel.automaticItemSize()) {

                var identifier = cellIdentifier
                var viewModelClass: AnyClass? = NSClassFromString(identifier)

                if viewModelClass == nil {
                    //Not objc
                    let moduleName = NSStringFromClass(type(of: self)).components(separatedBy: ".").first
                    identifier = "\(moduleName ?? "").\(identifier)"
                    viewModelClass = NSClassFromString(identifier)
                }

                if let cls = viewModelClass as? PDMVVMCollectionViewCell.Type, let s = cls.minimalSelfSize()  {
                    size.height = s.height
                }

            } else if (collectionViewModel.shouldHeightEqualWidth(indexPath)) {
                if (mvvmLayout.scrollDirection == .vertical) {
                    size.height = size.width
                } else {
                    size.width = size.height
                }
            }
        }
        
        return size
    }
 
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        var size = CGSize.zero
        guard let collectionViewModel = collectionViewModel,
            let cellIdentifier = collectionViewModel.headerIdentifier(forSection: section),
            classExists(name: cellIdentifier) else {
            return size
        }
        size = CGSize(width: 50, height: 50)

        if (collectionViewModel.automaticItemSize()) {
            
            var identifier = cellIdentifier
            var viewModelClass: AnyClass? = NSClassFromString(identifier)
            
            if viewModelClass == nil {
                //Not objc
                let moduleName = NSStringFromClass(type(of: self)).components(separatedBy: ".").first
                identifier = "\(moduleName ?? "").\(identifier)"
                viewModelClass = NSClassFromString(identifier)
            }
            
            if let cls = viewModelClass as? PDMVVMCollectionReusableView.Type, let s = cls.minimalSelfSize()  {
                size = s
            }
            
        } else if let mvvmLayout = collectionViewLayout as? PDMVVMCollectionViewFlowLayout    {
            size = collectionViewModel.sizeForHeader(inSection: section)
            let rect = CGRect(origin: CGPoint.zero, size: size)
            size = mvvmLayout.rectForSuplementaryView(at: section, original: rect).size
        }
        
        return size
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionsViewModel != nil ? collectionViewModel!.minimumLineSpacingForSection(at: section) : 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionsViewModel != nil ? collectionViewModel!.minimumInteritemSpacingForSection(at: section) : 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionsViewModel != nil ? collectionViewModel!.insetForSection(at: section) : UIEdgeInsets.zero
    }
 
}

extension CollectionPDMVVMViewController : PDMVVMSectionsViewModelDelegate {
    
    @objc open override func viewModelUpdated(viewModel: PDMVVMViewModel) {
        super.viewModelUpdated(viewModel: viewModel)
        collectionView.reloadData()
        updateUI()
    }
    
    @objc open func viewModel(_ viewModel: PDMVVMViewModel?, didDeleteModel model: Any?, at indexPath: IndexPath?, completion: @escaping (_ finished: Bool) -> Void) {
        
        if let indexPath = indexPath {
            collectionView.performBatchUpdates({
                collectionView.deleteItems(at: [indexPath])
            }) { (success) in
                
            }
        }
    }

    @objc open func viewModel(_ viewModel: PDMVVMViewModel?, didInsertModel model: Any?, at indexPath: IndexPath?, completion: @escaping (_ finished: Bool) -> Void) {
        if let indexPath = indexPath {
            collectionView.performBatchUpdates({
                collectionView.insertItems(at: [indexPath])
            }) { (success) in
                       
            }
        }
    }

    @objc open func viewModel(_ viewModel: PDMVVMViewModel?, didUpdateModel model: Any?, at indexPath: IndexPath?) {
        
        if let indexPath = indexPath, let cell = collectionView.cellForItem(at: indexPath) as? PDMVVMCollectionViewCell {
            collectionView.collectionViewLayout.invalidateLayout()
            cell.updateUI()
        }
    }

    @objc open func viewModelsUpdated(atIndexPaths indexPaths: [IndexPath]?) {
        if let indexPaths = indexPaths {
            collectionView.performBatchUpdates({
                collectionView.reloadItems(at: indexPaths)
            }, completion: nil)
        }
        
    }
    
    @objc open func sectionReloadSections(_ indexSet: IndexSet?) {
        if let indexSet = indexSet {
            collectionView.reloadSections(indexSet)
        }
    }

    @objc open func sectionViewModelDidInsertSections(at indexSet: IndexSet?, completion: @escaping (_ finished: Bool) -> Void) {
        
        if let indexSet = indexSet {
            collectionView.performBatchUpdates({
                collectionView.insertSections(indexSet)
            }, completion: completion)
        }
    }

    @objc open func sectionViewModelDidDeleteSections(at indexSet: IndexSet?, completion: @escaping (_ finished: Bool) -> Void) {
        if let indexSet = indexSet {
            collectionView.performBatchUpdates({
                collectionView.deleteSections(indexSet)
            }, completion: completion)
        }
    }

    @objc open func sectionReloadSections(_ indexSet: IndexSet?, completion: @escaping (_ finished: Bool) -> Void) {
        if let indexSet = indexSet {
            collectionView.performBatchUpdates({
                collectionView.reloadSections(indexSet)
            }, completion: completion)
        }
    }

    @objc open func sectionViewModelDidInsertSections(at insertedIndexSet: IndexSet?, deleteSectionsAt deletedindexSet: IndexSet?, reloadSectionsAt reloadedIndexSet: IndexSet?, completion: @escaping (_ finished: Bool) -> Void) {
        
        if let insertedIndexSet = insertedIndexSet,let deletedindexSet = deletedindexSet, let reloadedIndexSet = reloadedIndexSet {
            collectionView.performBatchUpdates({
                collectionView.insertSections(insertedIndexSet)
                collectionView.deleteSections(deletedindexSet)
                collectionView.reloadSections(reloadedIndexSet)
            }, completion: completion)
        }
    }
}
