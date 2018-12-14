//
//  PlaceholderView.swift
//  ANPlaceholder
//
//  Created by 刘栋 on 2018/12/13.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import UIKit
import SnapKit

final class PlaceholderView: UIView {
    
    private(set) lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        contentView.alpha = 0
        return contentView
    }()
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.backgroundColor = .clear
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    var customView: UIView? {
        willSet {
            if let customView = customView {
                customView.removeFromSuperview()
            }
        }
        didSet {
            if let customView = customView {
                contentView.addSubview(customView)
            }
        }
    }
    
    private lazy var layoutGuide = UILayoutGuide()
    
    var tapGesture: UITapGestureRecognizer?
    var titleMargin = DefaultValue.titleMargin
    var descriptionMargin = DefaultValue.descriptionMargin
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    override func didMoveToSuperview() {
        frame = super.bounds
        UIView.animate(withDuration: 0.25) {
            self.contentView.alpha = 1
        }
    }
    
    private func setupSubviews() {
        addSubview(contentView)
        contentView.snp.makeConstraints { maker in
            maker.edges.equalTo(snp.edges)
        }
        contentView.addLayoutGuide(layoutGuide)
        layoutGuide.snp.makeConstraints { maker in
            maker.center.equalTo(contentView.snp.center)
        }
    }
    
    func setupConstraints() {
        if let customView = customView {
            customView.snp.makeConstraints { maker in
                maker.edges.equalTo(contentView.snp.edges)
            }
        } else {
            var showedViews = [UIView]()
            
            if shouldShowImageView {
                if imageView.superview == nil {
                    contentView.addSubview(imageView)
                }
                showedViews.append(imageView)
            } else {
                imageView.removeFromSuperview()
            }
            if shouldShowTitleLabel {
                if titleLabel.superview == nil {
                    contentView.addSubview(titleLabel)
                }
                showedViews.append(titleLabel)
            } else {
                titleLabel.removeFromSuperview()
            }
            if shouldShowDescriptionLabel {
                if descriptionLabel.superview == nil {
                    contentView.addSubview(descriptionLabel)
                }
                showedViews.append(descriptionLabel)
            } else {
                descriptionLabel.removeFromSuperview()
            }
            
            for (index, view) in showedViews.enumerated() {
                if index == 0 {
                    view.snp.makeConstraints { maker in
                        maker.top.equalTo(layoutGuide.snp.top)
                        maker.centerX.equalTo(layoutGuide.snp.centerX)
                        if showedViews.count == 1 {
                            maker.bottom.equalTo(layoutGuide.snp.bottom)
                        }
                    }
                } else {
                    view.snp.makeConstraints { maker in
                        let margin: CGFloat = view == titleLabel ? titleMargin : descriptionMargin
                        maker.top.equalTo(showedViews[index-1].snp.bottom).offset(margin)
                        maker.centerX.equalTo(layoutGuide.snp.centerX)
                        if index == showedViews.count - 1 {
                            maker.bottom.equalTo(layoutGuide.snp.bottom)
                        }
                    }
                }
            }
        }
    }
    
    func removeConstraints() {
        imageView.snp.removeConstraints()
        titleLabel.snp.removeConstraints()
        descriptionLabel.snp.removeConstraints()
        customView?.snp.removeConstraints()
    }
    
    func prepareForDisplay() {
        imageView.image = nil
        titleLabel.attributedText = nil
        descriptionLabel.attributedText = nil
        customView = nil
        removeConstraints()
    }
    
    func reset() {
        imageView.image = nil
        titleLabel.attributedText = nil
        descriptionLabel.attributedText = nil
        customView = nil
        tapGesture = nil
        removeConstraints()
    }
}

extension PlaceholderView {
    
    private var shouldShowImageView: Bool {
        return imageView.image != nil
    }
    
    private var shouldShowTitleLabel: Bool {
        if let title = titleLabel.attributedText {
            return title.length > 0
        }
        return false
    }
    
    private var shouldShowDescriptionLabel: Bool {
        if let description = descriptionLabel.attributedText {
            return description.length > 0
        }
        return false
    }
}
