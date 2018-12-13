//
//  Base+UITableView.swift
//  ANPlaceholder
//
//  Created by 刘栋 on 2018/12/13.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import UIKit

extension UITableView: PlaceholderCompatible { }

private var tableViewPlaceholderDataSourceKey: UInt8 = 0
private var tableViewPlaceholderDelegateKey: UInt8 = 0

extension PlaceholderBase where Base: UITableView {
    
    public var dataSource: TableViewPlaceholderDataSource? {
        get {
            let container = objc_getAssociatedObject(self, &tableViewPlaceholderDataSourceKey) as? WeakObjectContainer
            return container?.object as? TableViewPlaceholderDataSource
        }
        nonmutating set {
            if let newValue = newValue {
                let container = WeakObjectContainer(object: newValue)
                objc_setAssociatedObject(self, &tableViewPlaceholderDataSourceKey, container, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                UITableView.swizzleReloadData
                UITableView.swizzleEndUpdates
                if #available(iOS 11.0, *) {
                    UITableView.swizzlePerformBatchUpdates
                }
            } else {
                base.handlingInvalidPlaceholder()
            }
        }
    }
    
    public var delegate: TableViewPlaceholderDelegate? {
        get {
            let container = objc_getAssociatedObject(self, &tableViewPlaceholderDelegateKey) as? WeakObjectContainer
            return container?.object as? TableViewPlaceholderDelegate
        }
        nonmutating set {
            if let newValue = newValue {
                let container = WeakObjectContainer(object: newValue)
                objc_setAssociatedObject(self, &tableViewPlaceholderDelegateKey, container, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
