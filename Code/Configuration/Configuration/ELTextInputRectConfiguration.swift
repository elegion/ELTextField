//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

/// Конфигурация размера контейнера и позиции поля ввода
public struct ELTextInputRectConfiguration {
    public let textInset: UIEdgeInsets?
    public let editingInset: UIEdgeInsets?
    public let leftViewPosition: ELLeftViewPosition?
    public let rightViewPosition: ELRightViewPosition?
    public let containerHeight: ELContainerHeight
    
    public var singlelineHeight: CGFloat {
        containerHeight.singleline
    }
    
    public var multilineHeight: CGFloat {
        containerHeight.multiline
    }

    public init(
        textInset: UIEdgeInsets? = nil,
        editingInset: UIEdgeInsets? = nil,
        leftViewPosition: ELLeftViewPosition? = nil,
        rightViewPosition: ELRightViewPosition? = nil,
        containerHeight: ELContainerHeight
    ) {
        self.textInset = textInset
        self.editingInset = editingInset ?? textInset
        self.leftViewPosition = leftViewPosition
        self.rightViewPosition = rightViewPosition
        self.containerHeight = containerHeight
    }
}
