//
//  ViewController.swift
//  ANPlaceholder-Example
//
//  Created by 刘栋 on 2018/12/14.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import UIKit
import ANPlaceholder
import SnapKit

class ViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 20
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.contentInset = UIEdgeInsets(top: 30, left: 20, bottom: 20, right: 20)
        view.backgroundColor = UIColor.lightGray
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.dataSource = self
        view.delegate = self
        view.placeholder.dataSource = self
        view.placeholder.delegate = self
        return view
    }()
    
    private lazy var placeholderView: CustomPlaceholderView = {
        let view = CustomPlaceholderView(frame: .zero)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { maker in
            maker.edges.equalTo(view.snp.edges)
        }
    }
}

extension ViewController: CollectionViewPlaceholderDataSource {
    
    /*
    func titleForPlaceholder(in collectionView: UICollectionView) -> NSAttributedString? {
        var attributes = [NSAttributedString.Key: Any]()
        attributes[.font] = UIFont.systemFont(ofSize: 26, weight: .medium)
        attributes[.foregroundColor] = UIColor.black
        return NSAttributedString(string: "您的还款账单获取失败", attributes: attributes)
    }
    
    func descriptionForPlaceholder(in collectionView: UICollectionView) -> NSAttributedString? {
        var attributes = [NSAttributedString.Key: Any]()
        attributes[.font] = UIFont.systemFont(ofSize: 16, weight: .medium)
        attributes[.foregroundColor] = UIColor.brown
        return NSAttributedString(string: "点击获取账单数据", attributes: attributes)
    }
    
    func backgroundColorForPlaceholder(in collectionView: UICollectionView) -> UIColor? {
        return UIColor.white
    }
     */
    
    func customViewForPlaceholder(in collectionView: UICollectionView) -> UIView? {
        return placeholderView
    }
}

extension ViewController: CollectionViewPlaceholderDelegate {
    
    func placeholderDidTap(in collectionView: UICollectionView) {
        print("placeholderDidTap")
    }
    
    func placeholderWillAppear(in collectionView: UICollectionView) {
        print("placeholderWillAppear")
    }
    
    func placeholderDidAppear(in collectionView: UICollectionView) {
        print("placeholderDidAppear")
    }
    
    func placeholderWillDisappear(in collectionView: UICollectionView) {
        print("placeholderWillDisappear")
    }
    
    func placeholderDidDisappear(in collectionView: UICollectionView) {
        print("placeholderDidDisappear")
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
}
