//
//  PlaceholderCompatible.swift
//  ANPlaceholder
//
//  Created by 刘栋 on 2018/12/13.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import Foundation

public protocol PlaceholderCompatible {
    
    associatedtype PlaceholderCompatibleType
    
    static var holder: PlaceholderBase<PlaceholderCompatibleType>.Type { get }
    
    var holder: PlaceholderBase<PlaceholderCompatibleType> { get }
}

extension PlaceholderCompatible {
    
    public static var holder: PlaceholderBase<Self>.Type {
        get {
            return PlaceholderBase<Self>.self
        }
    }
    
    public var holder: PlaceholderBase<Self> {
        get {
            return PlaceholderBase(base: self)
        }
    }
}
