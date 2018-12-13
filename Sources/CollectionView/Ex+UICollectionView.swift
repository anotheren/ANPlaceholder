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
        
    }
    
    @objc func swizzledPerformBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        
    }
}

extension UICollectionView {
    
    func handlingInvalidPlaceholder() {
        
    }
}
