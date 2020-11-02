//
//  MainReusableView.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 15.09.2020.
//  Copyright © 2020 Pavel Deminov. All rights reserved.
//

import UIKit

class MainReusableView: PDMVVMCollectionReusableView {
    
    @IBOutlet weak var titleLabel: UILabel!

    override func updateUI() {
           guard let viewModel = viewModel as? CellPDMVVMViewModel, let modelInfo = viewModel.model as? PDMVVMModel else {
               return
               
           }
           
           titleLabel.text = modelInfo.mvvmTitle
           
           
       }
}
