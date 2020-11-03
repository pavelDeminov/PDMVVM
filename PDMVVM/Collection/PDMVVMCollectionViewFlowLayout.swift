//
//  PDMVVMCollectionViewFlowLayout.swift
//  PDMVVMExample
//
//  Created by Pavel Deminov on 10.09.2020.
//  Copyright © 2020 Pavel Deminov. All rights reserved.
//

import UIKit

open class PDMVVMCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var viewModel: CollectionPDMVVMViewModel?
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let superLayoutAttributes = super.layoutAttributesForElements(in: rect)
        
        if  let superLayoutAttributes = superLayoutAttributes, let layoutAttributes = NSArray(array: superLayoutAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes] {
            for attributes in layoutAttributes {
                if attributes.representedElementCategory == .cell, let customAttributes = layoutAttributesForItem(at: attributes.indexPath) {
                    attributes.frame = customAttributes.frame
                }
            }
            return layoutAttributes
        } else {
             return superLayoutAttributes
        }
        
    }
    
    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath)
            else {
            return nil
        }
        
        var frame = layoutAttributes.frame
        frame = rectForItem(at: indexPath, original: frame)
        layoutAttributes.frame = frame
        return layoutAttributes
    
    }
    
    public func rectForItem(at indexPath: IndexPath, original frame:CGRect) -> CGRect {
        
        var rect = frame
        guard let collectionView = collectionView,
            let viewModel = viewModel
            else {
                return rect
        }
        
        let itemsCount = viewModel.numberOfItemsInRow(forSection: indexPath.section)
        
        let insets: UIEdgeInsets = viewModel.insetForSection(at: indexPath.section)
        let minimumInteritemSpacing = viewModel.minimumInteritemSpacingForSection(at: indexPath.section)
        let minimumLineSpacing = viewModel.minimumLineSpacingForSection(at: indexPath.section)
        
        if self.scrollDirection == .vertical {
            let contentWidth = itemsCount > 0 ? collectionView.frame.size.width - insets.left - insets.right - minimumInteritemSpacing * CGFloat((itemsCount - 1)) : rect.width
            let width = itemsCount > 1 ? contentWidth / CGFloat(itemsCount) : contentWidth
            let index = indexPath.row % itemsCount
            let x = insets.left + CGFloat(index) * (width + minimumInteritemSpacing)
            rect.origin = CGPoint(x: x, y: rect.origin.y)
            rect.size = CGSize(width: width, height: rect.height)
        } else {
            let contentHeight = itemsCount > 0 ? collectionView.frame.size.height - insets.top - insets.bottom - minimumLineSpacing * CGFloat((itemsCount - 1)) : rect.height
            let height = itemsCount > 1 ? contentHeight / CGFloat(itemsCount) : contentHeight 
            let index = indexPath.row % itemsCount
            let y = insets.top + CGFloat(index) * (height + minimumLineSpacing)
            rect.origin = CGPoint(x: rect.origin.x, y: y)
            rect.size = CGSize(width: rect.width, height: height)
        }
        
        return rect;
    }
    
    public override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let layoutAttributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)?.copy() as? UICollectionViewLayoutAttributes
            else {
            return nil
        }
        
        var frame = layoutAttributes.frame
        frame = rectForSuplementaryView(at: indexPath.section, original: frame)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
    public func rectForSuplementaryView(at section: Int, original frame:CGRect) -> CGRect {
        
        var rect = frame
        guard let collectionView = collectionView
            else {
                return rect
        }
                    
        if self.scrollDirection == .vertical {
            let contentWidth = collectionView.frame.size.width
            rect.size = CGSize(width: contentWidth, height: rect.height)
        } else {
            let contentHeight = collectionView.frame.size.height
            rect.size = CGSize(width: rect.width, height: contentHeight)
        }
        
        return rect;
    }

}
