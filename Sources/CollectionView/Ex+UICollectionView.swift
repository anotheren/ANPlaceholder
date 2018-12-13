//
//  Ex+UICollectionView.swift
//  ANPlaceholder
//
//  Created by 刘栋 on 2018/12/13.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    static let swizzleReloadData: () = {
        let originalSelector = #selector(UICollectionView.reloadData)
        let swizzledSelector = #selector(UICollectionView.swizzledReloadData)
        SwizzleHelper.swizzleMethod(for: UICollectionView.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    
    static let swizzlePerformBatchUpdates: () = {
        let originalSelector = #selector(UICollectionView.performBatchUpdates(_:completion:))
        let swizzledSelector = #selector(UICollectionView.swizzledPerformBatchUpdates(_:completion:))
        SwizzleHelper.swizzleMethod(for: UICollectionView.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
}

extension UICollectionView {
    
    @objc func swizzledReloadData() {
        swizzledReloadData()
        reloadPlaceholder()
    }
    
    @objc func swizzledPerformBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        swizzledPerformBatchUpdates(updates) { [weak self] finished in
            completion?(finished)
            self?.reloadPlaceholder()
        }
    }
}

private var collectionViewPlaceholderView: UInt8 = 0

extension UICollectionView {
    
    var placeholderView: PlaceholderView? {
        get {
            return objc_getAssociatedObject(self, &collectionViewPlaceholderView) as? PlaceholderView
        }
        set {
            objc_setAssociatedObject(self, &collectionViewPlaceholderView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func reloadPlaceholder() {
        
    }
    
    func handlingInvalidPlaceholder() {
        
    }
}

extension UICollectionView {
    
    private func cellsCount() -> Int {
        var count = 0
        if let dataSource = dataSource {
            let sections = dataSource.numberOfSections?(in: self) ?? 0
            for section in 0..<sections {
                count += dataSource.collectionView(self, numberOfItemsInSection: section)
            }
        }
        return count
    }
}
