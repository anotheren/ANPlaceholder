//
//  Base+UICollectionView.swift
//  ANPlaceholder
//
//  Created by 刘栋 on 2018/12/13.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import UIKit

extension UICollectionView: PlaceholderCompatible { }

extension PlaceholderBase where Base: UICollectionView {
    
    public var dataSource: CollectionViewPlaceholderDataSource? {
        get {
            return nil
        }
        nonmutating set {
            
        }
    }
    
    public var delegate: CollectionViewPlaceholderDelegate? {
        get {
            return nil
        }
        nonmutating set {
            
        }
    }
}
