//
//  WeakObjectContainer.swift
//  ANPlaceholder
//
//  Created by 刘栋 on 2018/12/13.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import Foundation

class WeakObjectContainer: NSObject {
    
    weak var object: AnyObject?
    
    init(object: AnyObject) {
        super.init()
        self.object = object
    }
}
