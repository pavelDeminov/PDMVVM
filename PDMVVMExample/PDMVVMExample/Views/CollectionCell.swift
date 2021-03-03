//
//  MainCell.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 08/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

class CollectionCell: PDMVVMCollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func updateUI() {
        guard let viewModel = viewModel as? CellPDMVVMViewModel, let modelInfo = viewModel.model as? PDMVVMModel else {
            return
        }
        
        titleLabel.text = modelInfo.mvvmTitle
    }
}
