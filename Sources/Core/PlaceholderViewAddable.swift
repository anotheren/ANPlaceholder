//
//  PlaceholderViewAddable.swift
//  ANPlaceholder
//
//  Created by 刘栋 on 2018/12/14.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import UIKit

protocol PlaceholderViewAddable {
    
    var cellsCount: Int { get }
    var placeholderView: PlaceholderView? { get set }
    
    func reloadPlaceholder()
    func invalidPlaceholder()
}
