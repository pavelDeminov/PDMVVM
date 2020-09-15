//
//  PDMVVMCollectionReusableView.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 07/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

class PDMVVMCollectionReusableView: UICollectionReusableView {
    
    var viewModel: PDMVVMViewModel? {
        didSet {
            updateUI()
        }
    }
    @IBOutlet weak var plateView: UIView!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var separatorHeight: NSLayoutConstraint!
    var plateViewColor: UIColor?
    var scrollDirection: UICollectionView.ScrollDirection = .vertical

    class var reuseIdentifier: String? {
        let classString = NSStringFromClass(self.self).components(separatedBy: ".").last
        return classString
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    internal func setup() {
        separatorHeight.constant = 1.0 / UIScreen.main.scale
    }
    
    internal func updateUI() {
        
        
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        self.layoutIfNeeded()
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        var frame = attributes.frame
        if self.scrollDirection == .vertical {
            frame.size = self.systemLayoutSizeFitting(frame.size, withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.fittingSizeLevel)
        } else {
            frame.size = self.systemLayoutSizeFitting(frame.size, withHorizontalFittingPriority: UILayoutPriority.fittingSizeLevel, verticalFittingPriority: UILayoutPriority.required)
        }
        attributes.frame = frame;
        return attributes
    }
}
