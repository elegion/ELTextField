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
    public let tintColor: UIColor?
    public let backgroundColor: UIColor?
    
    public init(
        borderColor: UIColor?,
        borderWidth: CGFloat?,
        cornerRadius: CGFloat,
        tintColor: UIColor?,
        backgroundColor: UIColor?
    ) {
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
    }
}
