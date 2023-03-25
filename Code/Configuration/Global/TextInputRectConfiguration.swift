//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

public struct IntrinsicHeight {
    let singleline: CGFloat
    let multiline: CGFloat

    public init(singleline: CGFloat,
                multiline: CGFloat) {
        self.singleline = singleline
        self.multiline = multiline
    }

    public init(singleline: CGFloat) {
        self.init(singleline: singleline, multiline: singleline)
    }
}

/// Позиция RightView
public enum RightViewPosition {
    /// Явные значения позиции
    case absolute(topRight: CGPoint, size: CGSize)
    /// По центру по горизонтали
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

public struct TextInputRectConfiguration {
    public let textInset: UIEdgeInsets?
    public let editingInset: UIEdgeInsets?
    public let rightViewPosition: RightViewPosition?
    public let intrinsicHeight: IntrinsicHeight

    public init(textInset: UIEdgeInsets? = nil,
                editingInset: UIEdgeInsets? = nil,
                rightViewPosition: RightViewPosition? = nil,
                intrinsicHeight: IntrinsicHeight) {
        self.textInset = textInset
        self.editingInset = editingInset
        self.rightViewPosition = rightViewPosition
        self.intrinsicHeight = intrinsicHeight
    }
}
