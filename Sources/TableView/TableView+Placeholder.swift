//
//  TableView+Placeholder.swift
//  ANPlaceholder
//
//  Created by 刘栋 on 2018/12/13.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import UIKit

public protocol TableViewPlaceholderDataSource: class {
    
    func imageForPlaceholder(in tableView: UITableView) -> UIImage?
    func titleForPlaceholder(in tableView: UITableView) -> NSAttributedString?
    func descriptionForPlaceholder(in tableView: UITableView) -> NSAttributedString?
    func imageTintColorForPlaceholder(in tableView: UITableView) -> UIColor?
    func backgroundColorForPlaceholder(in tableView: UITableView) -> UIColor?
    func verticalOffsetForPlaceholder(in tableView: UITableView) -> CGFloat
    func verticalSpacesForPlaceholder(in tableView: UITableView) -> [CGFloat]
    func titleMarginForPlaceholder(in tableView: UITableView) -> CGFloat
    func descriptionMarginForPlaceholder(in tableView: UITableView) -> CGFloat
    func customViewForPlaceholder(in tableView: UITableView) -> UIView?
}

public protocol TableViewPlaceholderDelegate: class {
    
    func placeholderShouldDisplay(in tableView: UITableView) -> Bool
    func placeholderTapEnabled(in tableView: UITableView) -> Bool
    func placeholderScrollEnabled(in tableView: UITableView) -> Bool
    func placeholderDidTapEmptyView(in tableView: UITableView)
    func placeholderWillAppear(in tableView: UITableView)
    func placeholderDidAppear(in tableView: UITableView)
    func placeholderWillDisappear(in tableView: UITableView)
    func placeholderDidDisappear(in tableView: UITableView)
}

extension TableViewPlaceholderDataSource {
    
    public func imageForPlaceholder(in tableView: UITableView) -> UIImage? {
        return nil
    }
    
    public func titleForPlaceholder(in tableView: UITableView) -> NSAttributedString? {
        return nil
    }
    
    public func descriptionForPlaceholder(in tableView: UITableView) -> NSAttributedString? {
        return nil
    }
    
    public func imageTintColorForPlaceholder(in tableView: UITableView) -> UIColor? {
        return nil
    }
    
    public func backgroundColorForPlaceholder(in tableView: UITableView) -> UIColor? {
        return nil
    }
    
    public func verticalOffsetForPlaceholder(in tableView: UITableView) -> CGFloat {
        return DefaultValue.verticalOffset
    }
    
    public func verticalSpacesForPlaceholder(in tableView: UITableView) -> [CGFloat] {
        return DefaultValue.verticalSpaces
    }
    
    public func titleMarginForPlaceholder(in tableView: UITableView) -> CGFloat {
        return DefaultValue.titleMargin
    }
    
    public func descriptionMarginForPlaceholder(in tableView: UITableView) -> CGFloat {
        return DefaultValue.descriptionMargin
    }
    
    public func customViewForPlaceholder(in tableView: UITableView) -> UIView? {
        return nil
    }
}

extension TableViewPlaceholderDelegate {
    
    public func placeholderShouldDisplay(in tableView: UITableView) -> Bool {
        return true
    }
    
    public func placeholderTapEnabled(in tableView: UITableView) -> Bool {
        return true
    }
    
    public func placeholderScrollEnabled(in tableView: UITableView) -> Bool {
        return false
    }
    
    public func placeholderDidTapEmptyView(in tableView: UITableView) {
        
    }
    
    public func placeholderWillAppear(in tableView: UITableView) {
        
    }
    
    public func placeholderDidAppear(in tableView: UITableView) {
        
    }
    
    public func placeholderWillDisappear(in tableView: UITableView) {
        
    }
    
    public func placeholderDidDisappear(in tableView: UITableView) {
        
    }
}
