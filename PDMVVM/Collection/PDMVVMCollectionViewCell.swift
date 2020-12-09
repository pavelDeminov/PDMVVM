//
//  PDMVVMCollectionViewCell.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 03/02/2019.
//  Copyright © 2019 Pavel Deminov. All rights reserved.
//

import UIKit

open class PDMVVMCollectionViewCell: UICollectionViewCell {
    
    public var viewModel: PDMVVMViewModel? {
        didSet {
            updateUI()
        }
    }
    @IBOutlet public weak var plateView: UIView!
    
    open var scrollDirection: UICollectionView.ScrollDirection = .vertical
    public static var useViewModelForCalculateMinimalSize = false
    
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
    
    open class func minimalSelfSizeWithViewModel(viewModel: PDMVVMViewModel) -> CGSize? {
        
        if let size = minimalSafeSizesCollection?[reuseIdentifier] as? CGSize {
            return size
        } else {
            let prototype = (Bundle.main.loadNibNamed(self.reuseIdentifier ?? "", owner: nil, options: nil))?[0] as? PDMVVMCollectionViewCell
            prototype?.contentView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue)
            
            prototype?.viewModel = viewModel;
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
