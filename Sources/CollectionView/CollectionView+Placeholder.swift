//
//  CollectionView+Placeholder.swift
//  ANPlaceholder
//
//  Created by 刘栋 on 2018/12/13.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import UIKit

public protocol CollectionViewPlaceholderDataSource: class {
    
    func imageForPlaceholder(in collectionView: UICollectionView) -> UIImage?
    func titleForPlaceholder(in collectionView: UICollectionView) -> NSAttributedString?
    func descriptionForPlaceholder(in collectionView: UICollectionView) -> NSAttributedString?
    func imageTintColorForPlaceholder(in collectionView: UICollectionView) -> UIColor?
    func backgroundColorForPlaceholder(in collectionView: UICollectionView) -> UIColor?
    func verticalOffsetForPlaceholder(in collectionView: UICollectionView) -> CGFloat
    func verticalSpacesForPlaceholder(in collectionView: UICollectionView) -> [CGFloat]
    func titleMarginForPlaceholder(in collectionView: UICollectionView) -> CGFloat
    func descriptionMarginForPlaceholder(in collectionView: UICollectionView) -> CGFloat
    func customViewForPlaceholder(in collectionView: UICollectionView) -> UIView?
}

public protocol CollectionViewPlaceholderDelegate: class {
    
    func placeholderShouldDisplay(in collectionView: UICollectionView) -> Bool
    func placeholderTapEnabled(in collectionView: UICollectionView) -> Bool
    func placeholderScrollEnabled(in collectionView: UICollectionView) -> Bool
    func placeholderDidTapEmptyView(in collectionView: UICollectionView)
    func placeholderWillAppear(in collectionView: UICollectionView)
    func placeholderDidAppear(in collectionView: UICollectionView)
    func placeholderWillDisappear(in collectionView: UICollectionView)
    func placeholderDidDisappear(in collectionView: UICollectionView)
}

extension CollectionViewPlaceholderDataSource {
    
    public func imageForPlaceholder(in collectionView: UICollectionView) -> UIImage? {
        return nil
    }
    
    public func titleForPlaceholder(in collectionView: UICollectionView) -> NSAttributedString? {
        return nil
    }
    
    public func descriptionForPlaceholder(in collectionView: UICollectionView) -> NSAttributedString? {
        return nil
    }
    
    public func imageTintColorForPlaceholder(in collectionView: UICollectionView) -> UIColor? {
        return nil
    }
    
    public func backgroundColorForPlaceholder(in collectionView: UICollectionView) -> UIColor? {
        return nil
    }
    
    public func verticalOffsetForPlaceholder(in collectionView: UICollectionView) -> CGFloat {
        return DefaultValue.verticalOffset
    }
    
    public func verticalSpacesForPlaceholder(in collectionView: UICollectionView) -> [CGFloat] {
        return DefaultValue.verticalSpaces
    }
    
    public func titleMarginForPlaceholder(in collectionView: UICollectionView) -> CGFloat {
        return DefaultValue.titleMargin
    }
    
    public func descriptionMarginForPlaceholder(in collectionView: UICollectionView) -> CGFloat {
        return DefaultValue.descriptionMargin
    }
    
    public func customViewForPlaceholder(in collectionView: UICollectionView) -> UIView? {
        return nil
    }
}

extension CollectionViewPlaceholderDelegate {
    
    public func placeholderShouldDisplay(in collectionView: UICollectionView) -> Bool {
        return true
    }
    
    public func placeholderTapEnabled(in collectionView: UICollectionView) -> Bool {
        return true
    }
    
    public func placeholderScrollEnabled(in collectionView: UICollectionView) -> Bool {
        return false
    }
    
    public func placeholderDidTapEmptyView(in collectionView: UICollectionView) {
        
    }
    
    public func placeholderWillAppear(in collectionView: UICollectionView) {
        
    }
    
    public func placeholderDidAppear(in collectionView: UICollectionView) {
        
    }
    
    public func placeholderWillDisappear(in collectionView: UICollectionView) {
        
    }
    
    public func placeholderDidDisappear(in collectionView: UICollectionView) {
        
    }
}
