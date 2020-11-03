//
//  PDMVVMCollectionViewCell.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 03/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

open class PDMVVMCollectionViewCell: UICollectionViewCell {
    
    var viewModel: PDMVVMViewModel? {
        didSet {
            updateUI()
        }
    }
    @IBOutlet weak var plateView: UIView!
    @IBOutlet weak var separator: UIView?
    @IBOutlet weak var separatorHeight: NSLayoutConstraint?
    var plateViewColor: UIColor?
    var scrollDirection: UICollectionView.ScrollDirection = .vertical
    
    class var reuseIdentifier: String? {
        let classString = NSStringFromClass(self.self).components(separatedBy: ".").last
        return classString
    }
    
    static var minimalSafeSizesCollection: [AnyHashable : Any]? = {
        var minimalSafeSizesCollection =  [AnyHashable : Any]()
        return minimalSafeSizesCollection
    }()

    open class func minimalSelfSize() -> CGSize? {
        
        if let size = minimalSafeSizesCollection?[reuseIdentifier] as? CGSize {
            return size
        } else {
            let prototype = (Bundle.main.loadNibNamed(self.reuseIdentifier ?? "", owner: nil, options: nil))?[0] as? PDMVVMCollectionViewCell
            prototype?.contentView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue)
            
            prototype?.viewModel = nil;
            prototype?.layoutSubviews()
            let size = prototype?.contentView.systemLayoutSizeFitting(layoutFittingCompressedSize)
            minimalSafeSizesCollection?[reuseIdentifier] = size
            return size;
        }
       
    }

    open override func awakeFromNib() {
         super.awakeFromNib()
        setup()
    }
    
    open func setup() {
        separatorHeight?.constant = 1.0 / UIScreen.main.scale
    }
    
    open func updateUI() {
        
    }
    
    open override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        self.layoutIfNeeded()
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        var frame = attributes.frame
        if self.scrollDirection == .vertical {
            frame.size = systemLayoutSizeFitting(frame.size, withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.fittingSizeLevel)
        } else {
            frame.size =  systemLayoutSizeFitting(frame.size, withHorizontalFittingPriority: UILayoutPriority.fittingSizeLevel, verticalFittingPriority: UILayoutPriority.required)
        }
        attributes.frame = frame;
        return attributes
    }
    
}
