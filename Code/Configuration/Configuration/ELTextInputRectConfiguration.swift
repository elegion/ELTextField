//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

/// Высота контейнера ввода
public struct ELContainerHeight {
    /// Высота однострочного контейнера
    let singleline: CGFloat
    /// Высота многострочного контейнера
    let multiline: CGFloat

    public init(
        singleline: CGFloat,
        multiline: CGFloat
    ) {
        self.singleline = singleline
        self.multiline = multiline
    }

    public init(singleline: CGFloat) {
        self.init(singleline: singleline, multiline: singleline)
    }
}

/// Позиция RightView
public enum ELRightViewPosition {
    /// Явные значения позиции
    case absolute(topRight: CGPoint, size: CGSize)
    /// Позиция будет выровнена по горизонтальной оси
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

/// Конфигурация размера контейнера и позиции поля ввода
public struct ELTextInputRectConfiguration {
    public let textInset: UIEdgeInsets?
    public let editingInset: UIEdgeInsets?
    public let rightViewPosition: ELRightViewPosition?
    public let containerHeight: ELContainerHeight

    public init(
        textInset: UIEdgeInsets? = nil,
        editingInset: UIEdgeInsets? = nil,
        rightViewPosition: ELRightViewPosition? = nil,
        containerHeight: ELContainerHeight
    ) {
        self.textInset = textInset
        self.editingInset = editingInset ?? textInset
        self.rightViewPosition = rightViewPosition
        self.containerHeight = containerHeight
    }
}
