//
//  Base+UITableView.swift
//  ANPlaceholder
//
//  Created by 刘栋 on 2018/12/13.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import UIKit

extension UITableView: PlaceholderCompatible { }

extension PlaceholderBase where Base: UITableView {
    
    public var dataSource: TableViewPlaceholderDataSource? {
        get {
            return nil
        }
        nonmutating set {
            
        }
    }
    
    public var delegate: TableViewPlaceholderDelegate? {
        get {
            return nil
        }
        nonmutating set {
            
        }
    }
}
