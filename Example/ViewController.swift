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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        collectionView.backgroundColor = UIColor.lightGray
        collectionView.placeholder.dataSource = self
        collectionView.placeholder.delegate = self
    }
}

extension ViewController: CollectionViewPlaceholderDataSource {
    
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
