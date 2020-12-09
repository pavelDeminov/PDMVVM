//
//  ScrollViewPDMVVMViewController.swift
//  TelcellBusiness
//
//  Created by Pavel Deminov on 16.11.2020.
//  Copyright © 2020 Telcell CJSC. All rights reserved.
//

import UIKit

class ScrollViewPDMVVMViewController: SectionsPDMVVMViewController {
    
    @IBOutlet open weak var scrollView: UIScrollView!
    
    open override var viewModel: PDMVVMViewModel? {
        didSet {
            scrollViewModel?.sectionsUpdatedDelegate = self
            scrollViewModel?.viewModeldDelegate = self
        }
    }
    
    open var scrollViewModel: ScrollViewPDMVVMViewModel? {
        get {
            return viewModel as? ScrollViewPDMVVMViewModel
        }
    }
    
    private var cellIndexPathDict = [IndexPath:PDMVVMScrollView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func setup() {
        
        for view in scrollView.subviews {
            view.removeFromSuperview()
        }
        cellIndexPathDict = [IndexPath: PDMVVMScrollView]()
        
        guard let scrollViewModel = scrollViewModel else {
            return
        }
        
        var prevView: PDMVVMScrollView?
        var s = Int(0)
        for section in scrollViewModel.sections {
            if let sectionViewModels = section.sectionViewModels {
                var r = Int(0)
                let sectionInsets = scrollViewModel.insetForSection(at: s)
                let minimumLineSpacingForSection = scrollViewModel.minimumLineSpacingForSection(at: s)
                for viewModel in sectionViewModels {
                    if let reuseIdentifier = viewModel.reuseIdentifier {
                        let nibExist = nibExists(name: reuseIdentifier)
                        if nibExist {
                            guard let view = (Bundle.main.loadNibNamed(reuseIdentifier, owner: nil, options: nil))?[0] as? PDMVVMScrollView else {
                                continue
                            }
                            let indexPath = IndexPath(row: r, section: s)
                            view.viewModel = scrollViewModel.viewModel(at: indexPath)
                            cellIndexPathDict[indexPath] = view
                            prepare(view, for: indexPath)
                            view.translatesAutoresizingMaskIntoConstraints = false
                            
                            scrollView.addSubview(view)
                            
                            if let prevView = prevView {
                                let top = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: prevView, attribute: .bottom, multiplier: 1.0, constant: minimumLineSpacingForSection)
                                scrollView.addConstraint(top)
                            } else {
                                let top = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: view.superview, attribute: .top, multiplier: 1.0, constant: sectionInsets.top)
                                scrollView.addConstraint(top)
                            }
                            
                            let leading = scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sectionInsets.left)
                            scrollView.addConstraint(leading)
                            
                            let trailing = scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: sectionInsets.right)
                            scrollView.addConstraint(trailing)
                            
                            let vertical = scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                            scrollView.addConstraint(vertical)
                            
                            prevView = view
                            r += 1
                        }
                    }
                }
                
                s += 1
                if let prevView = prevView {
                    let bottom = scrollView.bottomAnchor.constraint(equalTo: prevView.bottomAnchor, constant: sectionInsets.bottom)
                    scrollView.addConstraint(bottom)
                }
                
            }
        }
        
    }
    
    open func prepare(_ cell: PDMVVMScrollView?, for indexPath: IndexPath?) {
       
    }
    
    open func cell(for indexPath: IndexPath?) -> PDMVVMScrollView? {
        if let indexPath = indexPath {
            return cellIndexPathDict[indexPath]
        } else {
            return nil
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ScrollViewPDMVVMViewController : PDMVVMSectionsViewModelDelegate {
    
    @objc open override func viewModelUpdated(viewModel: PDMVVMViewModel) {
        super.viewModelUpdated(viewModel: viewModel)
        
        for view in scrollView.subviews {
            if let mvvmView = view as? PDMVVMScrollView {
                mvvmView.updateUI()
            }
        }
        updateUI()
    }
    
    @objc open func viewModel(_ viewModel: PDMVVMViewModel?, didDeleteModel model: Any?, at indexPath: IndexPath?, completion: @escaping (_ finished: Bool) -> Void) {
        updateUI()
    }

    @objc open func viewModel(_ viewModel: PDMVVMViewModel?, didInsertModel model: Any?, at indexPath: IndexPath?, completion: @escaping (_ finished: Bool) -> Void) {
        updateUI()
    }

    @objc open func viewModel(_ viewModel: PDMVVMViewModel?, didUpdateModel model: Any?, at indexPath: IndexPath?) {
        
        if let indexPath = indexPath, let cell = cell(for: indexPath) {
            cell.updateUI()
        }
        updateUI()
    }

    @objc open func viewModelsUpdated(atIndexPaths indexPaths: [IndexPath]?) {
        updateUI()
    }
    
    @objc open func sectionReloadSections(_ indexSet: IndexSet?) {

        updateUI()
    }

    @objc open func sectionViewModelDidInsertSections(at indexSet: IndexSet?, completion: @escaping (_ finished: Bool) -> Void) {
        updateUI()
    }

    @objc open func sectionViewModelDidDeleteSections(at indexSet: IndexSet?, completion: @escaping (_ finished: Bool) -> Void) {
        updateUI()
    }

    @objc open func sectionReloadSections(_ indexSet: IndexSet?, completion: @escaping (_ finished: Bool) -> Void) {
        updateUI()
    }

    @objc open func sectionViewModelDidInsertSections(at insertedIndexSet: IndexSet?, deleteSectionsAt deletedindexSet: IndexSet?, reloadSectionsAt reloadedIndexSet: IndexSet?, completion: @escaping (_ finished: Bool) -> Void) {
        updateUI()
    }
}
