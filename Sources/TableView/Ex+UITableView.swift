//
//  Ex+UITableView.swift
//  ANPlaceholder
//
//  Created by 刘栋 on 2018/12/13.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import UIKit

extension UITableView {
    
    static let swizzleReloadData: () = {
        let originalSelector = #selector(UITableView.reloadData)
        let swizzledSelector = #selector(UITableView.swizzledReloadData)
        SwizzleHelper.swizzleMethod(for: UITableView.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    
    static let swizzleEndUpdates: () = {
        let originalSelector = #selector(UITableView.endUpdates)
        let swizzledSelector = #selector(UITableView.swizzledEndUpdates)
        SwizzleHelper.swizzleMethod(for: UITableView.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    
    @available(iOS 11.0, *)
    static let swizzlePerformBatchUpdates: () = {
        let originalSelector = #selector(UITableView.performBatchUpdates(_:completion:))
        let swizzledSelector = #selector(UITableView.swizzledPerformBatchUpdates(_:completion:))
        SwizzleHelper.swizzleMethod(for: UITableView.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
}

extension UITableView {
    
    @objc func swizzledReloadData() {
        swizzledReloadData()
        reloadPlaceholder()
    }
    
    @objc func swizzledEndUpdates() {
        swizzledEndUpdates()
        reloadPlaceholder()
    }
    
    @available(iOS 11.0, *)
    @objc func swizzledPerformBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        swizzledPerformBatchUpdates(updates) { [weak self] finished in
            completion?(finished)
            self?.reloadPlaceholder()
        }
    }
}

private var tableViewPlaceholderView: UInt8 = 0

extension UITableView {
    
    var placeholderView: PlaceholderView? {
        get {
            return objc_getAssociatedObject(self, &tableViewPlaceholderView) as? PlaceholderView
        }
        set {
            objc_setAssociatedObject(self, &tableViewPlaceholderView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func reloadPlaceholder() {
        
    }
    
    func handlingInvalidPlaceholder() {
        
    }
}

extension UITableView {
    
    private func cellsCount() -> Int {
        var count = 0
        if let dataSource = dataSource {
            let sections = dataSource.numberOfSections?(in: self) ?? 0
            for section in 0..<sections {
                count += dataSource.tableView(self, numberOfRowsInSection: section)
            }
        }
        return count
    }
}
