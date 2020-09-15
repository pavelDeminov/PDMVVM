//
//  CollectionMVVMViewController.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 06/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

class CollectionPDMVVMViewController: SectionsPDMVVMViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    internal var collectionViewModel: CollectionViewModel? {
        get {
            return super.viewModel as? CollectionViewModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        let layout = MVVMCollectionViewFlowLayout()
        layout.viewModel = self.collectionViewModel
        
        if  let collectionViewModel = collectionViewModel {
            if #available(iOS 10.0, *) {
                layout.estimatedItemSize = collectionViewModel.automaticItemSize() ? UICollectionViewFlowLayout.automaticSize : CGSize.zero
            }
            layout.scrollDirection = collectionViewModel.scrollDirection()
        }
        collectionView.collectionViewLayout = layout
        
    }
    
    override func loadView() {
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
    
    internal func prepare(_ cell: PDMVVMCollectionViewCell?, for indexPath: IndexPath?) {
    }
    
    internal func prepare(_ reusableView: PDMVVMCollectionReusableView?, forSection section: Int) {
    }
    
    
//
//    internal func sizeForHeaderFooter(atSection section: Int) -> CGSize {
//
//           guard let sectionsViewModel = sectionsViewModel  else {
//               return CGSize.zero
//           }
//
//           var size: CGSize = sectionsViewModel.referenceSizeForHeader(inSection: section)
//           size.width = widthForReusableView()
//
//           var classString = sectionsViewModel.headerIdentifier(forSection: section)
//
//           /*
//            classString = classString?.components(separatedBy: ".").last ?? ""
//            let `class`: AnyClass? = NSClassFromString(classString?)
//            if `class`?.responds(to: #selector(AnyClass.sizeForView(withViewModel:withViewWidth:))) ?? false {
//            let sectionInfo = collectionViewModel.sectionInfo(forSection: section)
//
//            if sectionInfo is MVVMSectionInfo != nil {
//            let sectionInfoMVVM = sectionInfo as? MVVMSectionInfo
//            let viewModel: MVVMViewModel? = sectionInfoMVVM?.viewModel
//            size.height = `class`?.sizeForView(with: viewModel, withViewWidth: size.width) ?? 0.0
//            }
//            }
//            */
//           return size
//    }
//
//    internal func widthForReusableView() -> CGFloat {
//        return collectionView.frame.size.width
//    }

}

extension CollectionPDMVVMViewController: UICollectionViewDataSource, UICollectionViewDelegate  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionsViewModel != nil ? sectionsViewModel!.numberOfSections : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionsViewModel != nil ? sectionsViewModel!.numberOfItems(inSection: section) : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
        //cell?.separator.hidden = !collectionViewModel.shouldShowSeparator(for: indexPath)
        
        //cell?.roundCorners(collectionViewModel.corners(for: indexPath))
        //cell?.showShadow(collectionViewModel.shouldShowShadow(for: indexPath))
        
        
        prepare(cell, for: indexPath)
        
        return cell!
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        guard let headerIdentifier = sectionsViewModel?.headerIdentifier(forSection: indexPath.section) else {
//            return UICollectionReusableView(frame: CGRect.zero)
//        }
//
//        let sectionInfo = sectionsViewModel?.sectionInfo(forSection: indexPath.section)
//
//        if sectionInfo != nil {
//            if reuseIdentifiersDict[headerIdentifier] == nil {
//                reuseIdentifiersDict[headerIdentifier] = headerIdentifier
//                if nibExists(name: headerIdentifier) {
//                    collectionView.register(NSClassFromString(headerIdentifier), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
//                } else {
//                    collectionView.register(UINib(nibName: headerIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
//                }
//            }
//        }
//
//        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as? PDMVVMCollectionReusableView
//
//        if sectionInfo != nil {
//            let sectionInfoMVVM = sectionInfo
//            let viewModel: PDMVVMViewModel? = sectionInfoMVVM?.viewModel
//
//            sectionHeaderView?.viewModel = viewModel
//        }
//
//        prepare(sectionHeaderView, forSection: indexPath.section)
//
//        return sectionHeaderView!
//    }
}

extension CollectionPDMVVMViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size = CGSize(width: 50, height: 50)
        guard let collectionViewModel = collectionViewModel,
            let cellIdentifier = collectionViewModel.cellIdentifier(for: indexPath) else {
            return size
        }

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
                size = s
            }
            
        } else if let mvvmLayout = collectionViewLayout as? MVVMCollectionViewFlowLayout    {
            size = collectionViewModel.sizeForItem(at: indexPath)
            let rect = CGRect(origin: CGPoint.zero, size: size)
            size = mvvmLayout.rectForItem(at: indexPath, original: rect).size
            if (collectionViewModel.shouldHeightEqualWidth(indexPath)) {
                if (mvvmLayout.scrollDirection == .vertical) {
                    size.height = size.width
                } else {
                    size.width = size.height
                }
            }
        }
        
        return size
    }
    
 
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        
//        let size: CGSize = sizeForHeaderFooter(atSection: section)
//        return size
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionsViewModel != nil ? collectionViewModel!.minimumLineSpacingForSection(at: section) : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionsViewModel != nil ? collectionViewModel!.minimumInteritemSpacingForSection(at: section) : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionsViewModel != nil ? collectionViewModel!.insetForSection(at: section) : UIEdgeInsets.zero
    }
 
}
