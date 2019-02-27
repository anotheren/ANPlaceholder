//
//  CustomPlaceholderView.swift
//  ANPlaceholder-Example
//
//  Created by 刘栋 on 2018/12/15.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import UIKit
import SnapKit

final class CustomPlaceholderView: UIView {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        let image = UIImage(named: "EmptyBillTitle")
        view.image = image
        view.contentMode = .center
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "您的还款账单获取失败"
        view.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        view.textAlignment = .center
        view.textColor = UIColor.black
        return view
    }()
    
    private(set) lazy var requestButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.backgroundColor = UIColor.blue
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        var attributes = [NSAttributedString.Key: Any]()
        attributes[.font] = UIFont.systemFont(ofSize: 18, weight: .regular)
        attributes[.foregroundColor] = UIColor.white
        let attributedTitle = NSAttributedString(string: "点击获取账单数据", attributes: attributes)
        view.setAttributedTitle(attributedTitle, for: .normal)
        return view
    }()
    
    private lazy var tipsTitleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "温馨提示："
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.textAlignment = .left
        view.textColor = UIColor.red
        return view
    }()
    
    private lazy var tipsLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        view.text =
        """
        1：请确保您已经支付首付，并将信息提交给服务您的长合公司的工作人员
        2：如果一周以内没有获取到还款账单信息，请联系客服
        客服电话：400-905-7173
        """
        view.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        view.textAlignment = .left
        view.textColor = UIColor.gray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = UIColor.white
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(requestButton)
        addSubview(tipsTitleLabel)
        addSubview(tipsLabel)
        imageView.snp.makeConstraints { maker in
            maker.top.equalTo(snp.top).offset(50)
            maker.centerX.equalTo(snp.centerX)
            maker.size.equalTo(CGSize(width: 142, height: 104))
        }
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(imageView.snp.bottom).offset(15)
            maker.centerX.equalTo(snp.centerX)
            maker.height.equalTo(22)
        }
        requestButton.snp.makeConstraints { maker in
            maker.top.equalTo(titleLabel.snp.bottom).offset(40)
            maker.left.equalTo(snp.left).offset(15)
            maker.right.equalTo(snp.right).offset(-15)
            maker.height.equalTo(44)
        }
        tipsTitleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(requestButton.snp.bottom).offset(30)
            maker.left.equalTo(snp.left).offset(20)
            maker.height.equalTo(20)
        }
        tipsLabel.snp.makeConstraints { maker in
            maker.top.equalTo(tipsTitleLabel.snp.bottom).offset(8)
            maker.left.equalTo(snp.left).offset(15)
            maker.right.equalTo(snp.right).offset(-15)
        }
    }
}
