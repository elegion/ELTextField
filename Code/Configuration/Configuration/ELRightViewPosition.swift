//
//  File.swift
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
    ///   - rightInset: Отступ от правого края
    ///   - size: Размер View
    case centerHorizontally(rightInset: CGFloat, size: CGSize)

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
        case let .centerHorizontally(rightInset, _):
            return rightInset
        }
    }
}
