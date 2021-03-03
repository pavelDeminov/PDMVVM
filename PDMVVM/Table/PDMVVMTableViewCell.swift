//
//  PDMVVMTableViewCell.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 27.02.2021.
//  Copyright © 2021 Pavel Deminov. All rights reserved.
//

import UIKit

class PDMVVMTableViewCell: UITableViewCell {
    
    public var viewModel: PDMVVMViewModel? {
        didSet {
            updateUI()
        }
    }
    @IBOutlet public weak var plateView: UIView?
    public var pdmvvmView: PDMVVMView? {
        didSet {
            if let pdmvvmView = pdmvvmView {
                contentView.addSubview(pdmvvmView)
                pdmvvmView.translatesAutoresizingMaskIntoConstraints = false
                let leading = contentView.leadingAnchor.constraint(equalTo: pdmvvmView.leadingAnchor)
                let trailing = contentView.trailingAnchor.constraint(equalTo: pdmvvmView.trailingAnchor)
                let bottom = contentView.bottomAnchor.constraint(equalTo: pdmvvmView.bottomAnchor)
                let top = contentView.topAnchor.constraint(equalTo: pdmvvmView.topAnchor)
                NSLayoutConstraint.activate([leading, trailing, bottom, top])
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    open func updateUI() {
        
    }

}
