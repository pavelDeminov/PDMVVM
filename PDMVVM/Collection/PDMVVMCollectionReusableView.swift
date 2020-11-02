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
    var scrollDirection: UICollectionView.ScrollDirection = .vertical

    class var reuseIdentifier: String? {
        let classString = NSStringFromClass(self.self).components(separatedBy: ".").last
        return classString
    }
    
    static var minimalSafeSizesCollection: [AnyHashable : Any]? = {
        var minimalSafeSizesCollection =  [AnyHashable : Any]()
        return minimalSafeSizesCollection
    }()

    class func minimalSelfSize() -> CGSize? {
        
        if let size = minimalSafeSizesCollection?[reuseIdentifier] as? CGSize {
            return size
        } else {
            let prototype = (Bundle.main.loadNibNamed(self.reuseIdentifier ?? "", owner: nil, options: nil))?[0] as? PDMVVMCollectionReusableView
            prototype?.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue)
            
            prototype?.viewModel = nil;
            prototype?.layoutSubviews()
            let size = prototype?.systemLayoutSizeFitting(layoutFittingCompressedSize)
            minimalSafeSizesCollection?[reuseIdentifier] = size
            return size;
        }
       
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
