//
//  PlaceholderBase.swift
//  ANPlaceholder
//
//  Created by 刘栋 on 2018/12/13.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import Foundation

public struct PlaceholderBase<Base> {
    
    public let base: Base
    
    public init(base: Base) {
        self.base = base
    }
}
