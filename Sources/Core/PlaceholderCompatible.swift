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
    
    static var placeholder: PlaceholderBase<PlaceholderCompatibleType>.Type { get }
    
    var placeholder: PlaceholderBase<PlaceholderCompatibleType> { get }
}

extension PlaceholderCompatible {
    
    public static var placeholder: PlaceholderBase<Self>.Type {
        get {
            return PlaceholderBase<Self>.self
        }
    }
    
    public var placeholder: PlaceholderBase<Self> {
        get {
            return PlaceholderBase(base: self)
        }
    }
}
