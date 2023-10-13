//
// Created by viktor.volkov on 20.12.2021.
// Copyright © 2021 'E-Legion' Ltd. All rights reserved.
//

import Foundation
import UIKit

/// Конфигурация Layer
public struct ELTextInputLayerConfiguration {
    public let borderColor: UIColor?
    public let borderWidth: CGFloat?
    public let cornerRadius: CGFloat?
    /// Tint color для изображений
    public let tintColor: UIColor?
    /// Цвет курсора
    public let caretColor: UIColor?
    public let backgroundColor: UIColor?
    
    public init(
        borderColor: UIColor?,
        borderWidth: CGFloat?,
        cornerRadius: CGFloat,
        tintColor: UIColor?,
        caretColor: UIColor?,
        backgroundColor: UIColor?
    ) {
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.tintColor = tintColor
        self.caretColor = caretColor
        self.backgroundColor = backgroundColor
    }
}

public struct ELTextInputFontConfiguration {
    public let font: UIFont?
    public let textColor: UIColor?
    
    public init(font: UIFont?, textColor: UIColor?) {
        self.font = font
        self.textColor = textColor
    }
}
