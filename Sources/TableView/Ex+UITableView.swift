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

private var tableViewPlaceholderViewKey: UInt8 = 0

extension UITableView: PlaceholderViewAddable {
    
    var cellsTotalCount: Int {
        var count = 0
        if let dataSource = dataSource {
            let sections = dataSource.numberOfSections?(in: self) ?? 1
            for section in 0..<sections {
                count += dataSource.tableView(self, numberOfRowsInSection: section)
            }
        }
        return count
    }
    
    var placeholderView: PlaceholderView? {
        get {
            return objc_getAssociatedObject(self, &tableViewPlaceholderViewKey) as? PlaceholderView
        }
        set {
            objc_setAssociatedObject(self, &tableViewPlaceholderViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func reloadPlaceholder() {
        guard let dataSource = placeholder.dataSource else { return }
        let shouldDisplay = placeholder.delegate?.placeholderShouldDisplay(in: self) ?? DefaultValue.shouldDisplay
        guard shouldDisplay && cellsTotalCount == 0 else {
            if placeholder.isVisible {
                invalidPlaceholder()
            }
            return
        }
        
        let placeholderView: PlaceholderView = {
            if let view = self.placeholderView {
                return view
            } else {
                let origin = CGPoint(x: bounds.origin.x-contentInset.left, y: bounds.origin.y)
                let _frame = CGRect(origin: origin, size: bounds.size)
                let view = PlaceholderView(frame: _frame)
                view.isHidden = true
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPlaceholderView(_:)))
                view.addGestureRecognizer(tapGesture)
                view.tapGesture = tapGesture
                self.placeholderView = view
                return view
            }
        }()
        
        placeholder.delegate?.placeholderWillAppear(in: self)
        
        if placeholderView.superview == nil {
            if subviews.count > 1 {
                insertSubview(placeholderView, at: 0)
            } else {
                addSubview(placeholderView)
            }
        }
        
        placeholderView.prepareForDisplay()
        placeholderView.titleMargin = dataSource.titleMarginForPlaceholder(in: self)
        placeholderView.descriptionMargin = dataSource.descriptionMarginForPlaceholder(in: self)
        
        if let customView = dataSource.customViewForPlaceholder(in: self) {
            placeholderView.customView = customView
        } else {
            if let imageTintColor = dataSource.imageTintColorForPlaceholder(in: self) {
                placeholderView.imageView.image = dataSource.imageForPlaceholder(in: self)?.withRenderingMode(.alwaysTemplate)
                placeholderView.imageView.tintColor = imageTintColor
            } else {
                placeholderView.imageView.image = dataSource.imageForPlaceholder(in: self)?.withRenderingMode(.alwaysOriginal)
            }
            placeholderView.titleLabel.attributedText = dataSource.titleForPlaceholder(in: self)
            placeholderView.descriptionLabel.attributedText = dataSource.descriptionForPlaceholder(in: self)
        }
        
        placeholderView.backgroundColor = dataSource.backgroundColorForPlaceholder(in: self)
        placeholderView.isHidden = false
        placeholderView.clipsToBounds = true
        placeholderView.tapGesture?.isEnabled = placeholder.delegate?.placeholderTapEnabled(in: self) ?? DefaultValue.tapEnabled
        isScrollEnabled = placeholder.delegate?.placeholderScrollEnabled(in: self) ?? DefaultValue.scrollEnabled
        
        placeholderView.setupConstraints()
        placeholderView.layoutIfNeeded()
        
        placeholder.delegate?.placeholderDidAppear(in: self)
    }
    
    func invalidPlaceholder() {
        placeholder.delegate?.placeholderWillDisappear(in: self)
        placeholderView?.reset()
        placeholderView?.removeFromSuperview()
        placeholderView = nil
        isScrollEnabled = true
        placeholder.delegate?.placeholderDidAppear(in: self)
    }
}

extension UITableView {
    
    @objc private func didTapPlaceholderView(_ sender: UITapGestureRecognizer) {
        placeholder.delegate?.placeholderDidTap(in: self)
    }
}
