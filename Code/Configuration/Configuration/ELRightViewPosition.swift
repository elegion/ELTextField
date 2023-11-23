//
//  ELRightViewPosition.swift
//  
//
//  Created by viktor.volkov on 13.06.2023.
//

import Foundation

/// Позиция RightView
public enum ELRightViewPosition {
    /// Явные значения позиции
    case absolute(topRight: CGPoint, size: CGSize)
    /// Позиция будет выровнена по горизонтальной оси
    /// - Parameters:
    ///   - inset: Отступ от textRect
    ///   - size: Размер View
    case centerHorizontally(inset: CGFloat, size: CGSize)

    var size: CGSize {
        switch self {
        case let .absolute(_, size):
            return size
        case let .centerHorizontally(_, size):
            return size
        }
    }

    var rightInset: CGFloat {
        switch self {
        case let .absolute(topRight, _):
            return topRight.x
        case let .centerHorizontally(inset, _):
            return inset
        }
    }
}

public enum ELLeftViewPosition {
    case absolute(topLeft: CGPoint, size: CGSize)
    /// Позиция будет выровнена по горизонтальной оси
    /// - Parameters:
    ///   - inset: Отступ от textRect
    ///   - size: Размер View
    case centerHorizontally(inset: CGFloat, size: CGSize)
    
    public var size: CGSize {
        switch self {
        case let .absolute(_, size):
            return size
        case let .centerHorizontally(_, size):
            return size
        }
    }
    
    public var leftInset: CGFloat {
        switch self {
        case let .absolute(topLeft, _):
            return topLeft.x
        case let .centerHorizontally(inset, _):
            return inset
        }
    }
}
