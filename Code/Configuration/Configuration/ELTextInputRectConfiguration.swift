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
