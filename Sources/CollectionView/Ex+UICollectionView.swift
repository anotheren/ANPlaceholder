//
//  Ex+UICollectionView.swift
//  ANPlaceholder
//
//  Created by 刘栋 on 2018/12/13.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import UIKit
import SnapKit

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

private var collectionViewPlaceholderViewKey: UInt8 = 0

extension UICollectionView {
    
    var placeholderView: PlaceholderView? {
        get {
            return objc_getAssociatedObject(self, &collectionViewPlaceholderViewKey) as? PlaceholderView
        }
        set {
            objc_setAssociatedObject(self, &collectionViewPlaceholderViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func reloadPlaceholder() {
        guard let dataSource = placeholder.dataSource else { return }
        let shouldDisplay = placeholder.delegate?.placeholderShouldDisplay(in: self) ?? DefaultValue.shouldDisplay
        guard shouldDisplay && cellsCount() == 0 else {
            if placeholder.isVisible {
                handlingInvalidPlaceholder()
            }
            return
        }
        
        let placeholderView: PlaceholderView = {
            if let view = self.placeholderView {
                return view
            } else {
                let view = PlaceholderView(frame: .zero)
                view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
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
        
        placeholderView.snp.makeConstraints { maker in
            maker.edges.equalTo(snp.edges)
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
        placeholderView.isHidden = true
        placeholderView.clipsToBounds = true
        placeholderView.tapGesture?.isEnabled = placeholder.delegate?.placeholderTapEnabled(in: self) ?? DefaultValue.tapEnabled
        isScrollEnabled = placeholder.delegate?.placeholderScrollEnabled(in: self) ?? DefaultValue.scrollEnabled
        
        placeholderView.setupConstraints()
        placeholderView.layoutIfNeeded()
        
        placeholder.delegate?.placeholderDidAppear(in: self)
    }
    
    func handlingInvalidPlaceholder() {
        placeholder.delegate?.placeholderWillDisappear(in: self)
        placeholderView?.reset()
        placeholderView?.removeFromSuperview()
        placeholderView = nil
        isScrollEnabled = true
        placeholder.delegate?.placeholderDidAppear(in: self)
    }
}

extension UICollectionView {
    
    @objc private func didTapPlaceholderView(_ sender: UITapGestureRecognizer) {
        placeholder.delegate?.placeholderDidTap(in: self)
    }
    
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
