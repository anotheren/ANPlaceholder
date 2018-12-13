//
//  Base+UICollectionView.swift
//  ANPlaceholder
//
//  Created by 刘栋 on 2018/12/13.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import UIKit

extension UICollectionView: PlaceholderCompatible { }

private var collectionViewPlaceholderDataSourceKey: UInt8 = 0
private var collectionViewPlaceholderDelegateKey: UInt8 = 0

extension PlaceholderBase where Base: UICollectionView {
    
    public var dataSource: CollectionViewPlaceholderDataSource? {
        get {
            let container = objc_getAssociatedObject(self, &collectionViewPlaceholderDataSourceKey) as? WeakObjectContainer
            return container?.object as? CollectionViewPlaceholderDataSource
        }
        nonmutating set {
            if let newValue = newValue {
                let container = WeakObjectContainer(object: newValue)
                objc_setAssociatedObject(self, &collectionViewPlaceholderDataSourceKey, container, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                UICollectionView.swizzleReloadData
                UICollectionView.swizzlePerformBatchUpdates
            } else {
                base.handlingInvalidPlaceholder()
            }
        }
    }
    
    public var delegate: CollectionViewPlaceholderDelegate? {
        get {
            let container = objc_getAssociatedObject(self, &collectionViewPlaceholderDelegateKey) as? WeakObjectContainer
            return container?.object as? CollectionViewPlaceholderDelegate
        }
        nonmutating set {
            if let newValue = newValue {
                let container = WeakObjectContainer(object: newValue)
                objc_setAssociatedObject(self, &collectionViewPlaceholderDelegateKey, container, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    public var isVisible: Bool {
        get {
            if let placeholderView = base.placeholderView {
                return !placeholderView.isHidden
            }
            return false
        }
    }
    
    public func updateIfNeeded() {
        base.reloadPlaceholder()
    }
}
