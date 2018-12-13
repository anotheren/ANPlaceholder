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
        
    }
    
    @objc func swizzledEndUpdates() {
        
    }
    
    @available(iOS 11.0, *)
    @objc func swizzledPerformBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        
    }
}

extension UITableView {
    
    func handlingInvalidPlaceholder() {
        
    }
}
